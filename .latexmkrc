# 此模板依赖 XeLaTeX；让默认 latexmk 和 latexmk -pdf 都直接调用 xelatex。
$pdf_mode = 1;
$pdflatex = 'xelatex %O %S';
