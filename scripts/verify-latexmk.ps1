$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot

Push-Location $repoRoot
try {
    $targets = Get-ChildItem -Path $repoRoot -Filter "YNU-Thesis-*.tex" |
        Sort-Object Name |
        Select-Object -ExpandProperty Name

    if (-not $targets) {
        throw "No YNU-Thesis-*.tex files found in $repoRoot"
    }

    $commands = @(
        @{
            Label = "default latexmk"
            Args = @()
        },
        @{
            Label = "latexmk -pdf"
            Args = @("-pdf")
        }
    )

    foreach ($target in $targets) {
        foreach ($command in $commands) {
            Write-Host "Cleaning $target before $($command.Label)"
            & latexmk -C $target
            if ($LASTEXITCODE -ne 0) {
                throw "latexmk clean failed for $target"
            }

            Write-Host "Building $target with $($command.Label)"
            & latexmk @($command.Args + $target)
            if ($LASTEXITCODE -ne 0) {
                throw "latexmk build failed for $target with $($command.Label)"
            }
        }
    }
}
finally {
    Pop-Location
}
