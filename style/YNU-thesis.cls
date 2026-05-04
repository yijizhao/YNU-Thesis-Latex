%% =======================================================
%% 云南大学学位论文模板 (YNU-thesis)
%% =======================================================
%% Author: 赵苡积 (Dr. Zhao Yiji)
%% Institution: 云南大学 (Yunnan University)
%% Version: V1.0
%% =======================================================
%% 编译引擎: XeLaTeX (推荐)
%% =======================================================
%% type  选项: Bachelor (学士), Master (硕士), Doctor (博士)
%% print 选项: twoside (双面打印), oneside (单面打印)
%% =======================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{style/YNU-thesis}[Yunnan University Thesis Template]

% 屏蔽xeCJK字体覆盖的警告
\PassOptionsToPackage{quiet}{xeCJK}

% =========================================================
% 1. 选项声明与处理
% =========================================================
\RequirePackage{kvoptions}

% 设置键值对的族名和变量前缀
\SetupKeyvalOptions{
    family=YNU,
    prefix=YNU@
}

% 定义 type 参数 (默认值为 Master)
\DeclareStringOption[Master]{type}
% 定义 print 参数 (默认值为 twoside)
\DeclareStringOption[twoside]{print}

% 将无法识别的参数自动透传给底层的 ctexbook
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}

% 执行选项解析
\ProcessKeyvalOptions*

% 定义底层逻辑需要的布尔开关
\newif\if@isBachelor\@isBachelorfalse
\newif\if@isMaster\@isMasterfalse
\newif\if@isDoctor\@isDoctorfalse
\newif\if@isTwoSide\@isTwoSidefalse

% ---------------- 解析 type 参数 ----------------
\def\YNU@type@bachelor{Bachelor}
\def\YNU@type@master{Master}
\def\YNU@type@doctor{Doctor}

\ifx\YNU@type\YNU@type@bachelor
    \@isBachelortrue
\else\ifx\YNU@type\YNU@type@doctor
    \@isDoctortrue
\else
    \@isMastertrue % 匹配 Master 或任何未定义的非法输入均兜底为 Master
\fi\fi

% ---------------- 解析 print 参数 ----------------
\def\YNU@print@twoside{twoside}
\ifx\YNU@print\YNU@print@twoside
    \@isTwoSidetrue
\else
    \@isTwoSidefalse % 如果传入 oneside 等其他值，则关闭双面打印
\fi

% ---------------- 加载底层文档类 ----------------
\if@isTwoSide
    \LoadClass[zihao=-4,a4paper,twoside,openright,UTF8,space=auto]{ctexbook}
\else
    \LoadClass[zihao=-4,a4paper,oneside,openright,UTF8,space=auto]{ctexbook}
\fi

% =========================================================
% 2. 核心宏包加载
% =========================================================
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm,mathrsfs,upgreek,array}
\RequirePackage{indentfirst,multirow,graphicx,graphbox,wrapfig}
\RequirePackage{fancyhdr}
\RequirePackage{fontspec}
\RequirePackage{anyfontsize}
\RequirePackage{xeCJKfntef} % 处理中文字符跨行且带下划线的宏包
\RequirePackage{subcaption} 
\RequirePackage{titletoc}
\RequirePackage{xcolor}
\RequirePackage{listings}
\RequirePackage{enumitem}
\RequirePackage{emptypage} 
\RequirePackage{blkarray}
\RequirePackage{booktabs,makecell,threeparttable} 
\RequirePackage[figuresright]{rotating} 
\RequirePackage[justification=centering]{caption}
\RequirePackage[ruled]{algorithm2e} 
\RequirePackage{varwidth} % 用于测量算法内容的真实物理宽度，实现边界收缩
\RequirePackage[numbers,square,comma,super,sort&compress]{natbib}
\RequirePackage{lastpage}
\RequirePackage{tabularray}
\RequirePackage[
    colorlinks=true,
    linkcolor=black,
    citecolor=black,
    plainpages=false,
    pdfstartview=FitH,
    bookmarksnumbered
]{hyperref}

% =========================================================
% 3. 全局页面与排版设置
% =========================================================

% 1. 英文字体设置
\setmainfont{TimesNewRoman}[
    Path = style/fonts/,
    Extension = .ttf,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    ItalicFont = *-Italic,
    BoldItalicFont = *-BoldItalic
]
\setsansfont{Helvetica}[
    Path = style/fonts/,
    Extension = .ttf,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    ItalicFont = *-Oblique,
    BoldItalicFont = *-BoldOblique
]
\setmonofont{CourierNew}[
    Path = style/fonts/,
    Extension = .ttf,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    ItalicFont = *-Italic,
    BoldItalicFont = *-BoldItalic
]

% 2. 中文字体设置
\setCJKmainfont{SimSun.ttf}[
    Path = style/fonts/, 
    AutoFakeBold = true, 
    ItalicFont = SimKai.ttf
]
\setCJKsansfont{SimHei.ttf}[Path = style/fonts/, AutoFakeBold=true]
\setCJKmonofont{SimFang.ttf}[Path = style/fonts/, AutoFakeBold=true]

\setCJKfamilyfont{zhsong}{SimSun.ttf}[Path = style/fonts/, AutoFakeBold = true, ItalicFont = SimKai.ttf]
\setCJKfamilyfont{zhhei}{SimHei.ttf}[Path = style/fonts/, AutoFakeBold=true]
\setCJKfamilyfont{zhfs}{SimFang.ttf}[Path = style/fonts/, AutoFakeBold=true]
\setCJKfamilyfont{zhkai}{SimKai.ttf}[Path = style/fonts/, AutoFakeBold=true]
\setCJKfamilyfont{zhxingkai}{STXingKai.ttf}[Path = style/fonts/, AutoFakeBold=true]
\newcommand{\xingkai}{\CJKfamily{zhxingkai}}

% 页边距设置
\RequirePackage[
    top=2.5cm, bottom=2.75cm,
    left=3.0cm, right=2.0cm,
    headheight=16pt, headsep=17.6pt, footskip=33pt
]{geometry}

% 全局行距设置
\RequirePackage{setspace}
\setstretch{1.5}%与word中的固定22磅一致

\addtocontents{toc}{\protect\hypersetup{hidelinks}}
\addtocontents{lot}{\protect\hypersetup{hidelinks}}
\addtocontents{lof}{\protect\hypersetup{hidelinks}}

\renewcommand\theequation{\arabic{chapter}.\arabic{equation}}
\renewcommand\thefigure{\arabic{chapter}.\arabic{figure}}
\renewcommand\thetable{\arabic{chapter}.\arabic{table}}
\numberwithin{table}{chapter}
% 算法编号规则：强制按章节编号，且格式与图表保持一致 (如 算法 3.1)
\numberwithin{algocf}{chapter}
\renewcommand{\thealgocf}{\arabic{chapter}.\arabic{algocf}}

\DeclareCaptionLabelSeparator{zhspace}{\hspace{1\ccwd}}
\DeclareCaptionFont{captionfont}{\heiti\zihao{-4}}
\captionsetup{font = {captionfont}, labelsep = zhspace}
\captionsetup[table]{position = top, aboveskip = 6bp, belowskip = 6bp}
\captionsetup[figure]{position = bottom, aboveskip = 6bp, belowskip = 6bp}


% =========================================================
% 4. 章节标题与目录格式设置 (基于绝对行距22bp)
% =========================================================

%一级标题，段前间距为0.8行，段后间距为0.5行；无缩进，居中
\ctexset{chapter={
        name={},
        number = {\arabic{chapter}},
        aftername = {\hspace{0.5\ccwd}},
        format = {\zihao{3}\heiti\centering}, 
        pagestyle = {YNU@heading},
        beforeskip = 0bp, %段前0.8应该为17.6bp，在页眉部分设置了17.6bp。
        afterskip = 11bp, 
        fixskip = true,  %严格锁定，不让其自动浮动
    }
}
%二级标题，黑体，四号，段前0.5行，段后0行，无缩进，顶格
\ctexset{section={
        aftername = {\hspace{0.5\ccwd}},
        format={\zihao{4}\heiti}, 
        beforeskip = 11bp, 
        afterskip = 0bp, 
        fixskip = false,
    }
}
%三级标题，黑体，小四，段前0行，段后0行，首行缩进2个字符
\ctexset{subsection={
        aftername = {\hspace{0.5\ccwd}},
        indent = {2\ccwd},
        format = {\zihao{-4}\heiti}, 
        beforeskip = 0bp, 
        afterskip = 0bp, 
        fixskip = false,
    }
}
%四级标题，黑体，小四，段前0行，段后0行，首行缩进2个字符
\setcounter{secnumdepth}{3}
\ctexset{subsubsection={
        aftername = {\hspace{0.5\ccwd}},
        indent = {2\ccwd},
        format={\zihao{-4}\heiti}, 
        beforeskip = 0bp, 
        afterskip = 0bp, 
        fixskip = false,
    }
}

% 目录定制
\renewcommand\tableofcontents{
    \chapter*{目\quad 录} 
    \thispagestyle{YNU@plain}
    \@mkboth{目录}{目录}\pdfbookmark[0]{目录}{bittoc}\@starttoc{toc}
}

\titlecontents{chapter}[0pt]{\vspace{1pt}\heiti \zihao{-4}}{\thecontentslabel\hspace{0.5\ccwd}}{}{\hspace{.25em}\titlerule*{.}\contentspage}
\titlecontents{section}[1.5\ccwd]{\vspace{1pt}\songti \zihao{-4}}{\thecontentslabel\hspace{0.5\ccwd}}{}{\hspace{.5em}\titlerule*{.}\contentspage}
\titlecontents{subsection}[3.5\ccwd]{\vspace{1pt}\songti \zihao{-4}}{\thecontentslabel\hspace{0.5\ccwd}}{}{\hspace{.5em}\titlerule*{.}\contentspage}



% =========================================================
% 5. 页眉页脚及模式设置
% =========================================================

\renewcommand\frontmatter{%
    % 让前言部分（摘要、目录）默认使用无页眉样式
    \cleardoublepage\@mainmatterfalse\pagenumbering{Roman}\pagestyle{YNU@plain}
}
\renewcommand\mainmatter{%
    \cleardoublepage\@mainmattertrue\pagenumbering{arabic}\pagestyle{YNU@heading}
}

% 为无页眉页面定义的纯净样式
\fancypagestyle{YNU@plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt} % 消除页眉的黑色下划线
    \fancyfoot[C]{\zihao{5}\thepage}   % 页脚仅显示页码，样式与正文统一
}

% 为无页眉无页脚页面定义的纯净样式
\fancypagestyle{YNU@empty}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt} % 消除页眉的黑色下划线
    \fancyfoot{}   % 页脚仅显示页码，样式与正文统一
}

% 强制empty样式，防止任何自动空白页出现黑线
\fancypagestyle{empty}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

% 页眉逻辑
\fancypagestyle{YNU@heading}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0.4pt}
    \if@isTwoSide
        \if@isBachelor
            \fancyhead[CE]{\zihao{5}\songti 云南大学本科毕业论文（设计）}
            \fancyhead[CO]{\zihao{5}\songti\leftmark}
        \else
            \fancyhead[CO]{\zihao{5}\songti\leftmark}
            \if@isDoctor
                \fancyhead[CE]{\zihao{5}\songti 云南大学博士学位论文}
            \else
                \fancyhead[CE]{\zihao{5}\songti 云南大学硕士学位论文}
            \fi
        \fi
    \else
        \fancyhead[C]{\zihao{5}\songti\leftmark}
    \fi
    % 页脚逻辑
    \fancyfoot[C]{%
        \if@mainmatter
            \if@isBachelor
                \zihao{5}第~\thepage~页~（共~\pageref{LastPage}~页）%
            \else
                \zihao{-5}\thepage
            \fi
        \else
            \zihao{5}\thepage
        \fi
    }
}
\pagestyle{YNU@heading}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}


% =========================================================
% 6. 用户信息变量与接口
% =========================================================
\def\YNU@label@schoolNumber{学校代码:~}
\def\YNU@label@classification{密级:~}
\def\YNU@label@author{作者姓名:~}
\def\YNU@label@studentNumber{学~~~~~~号:~}
\def\YNU@label@advisor{导师姓名:~}
\def\YNU@label@advisorTitle{职~~~~~~称:~}
\def\YNU@label@degreeLevel{学位级别:~}
\def\YNU@label@degreeType{学位类别:~}
\def\YNU@label@major{学科专业:~}
\def\YNU@label@researchArea{研究方向:~}
\def\YNU@label@college{学~~~~~~院:~}

% === 研究生封面左上角参数变量 ===
\def\YNU@value@clc{XXXX}          % 分类号
\def\YNU@value@secretLevel{公开}  % 密级
\def\YNU@value@udc{XXXX}          % UDC
\def\YNU@value@serialNumber{XXXX} % 编号


\def\YNU@value@schoolNumber{10673}
\def\YNU@value@classification{公开}
\def\YNU@value@author{XXXX}
\def\YNU@value@studentNumber{XXXX}
\def\YNU@value@advisor{XXXX}
\def\YNU@value@advisorTitle{XXXX}


\if@isDoctor
    \def\YNU@value@degreeLevel{博士}
\else\if@isBachelor
    \def\YNU@value@degreeLevel{学士}
\else
    \def\YNU@value@degreeLevel{硕士}
\fi\fi
\def\YNU@value@degreeType{XXXX}
\def\YNU@value@major{XXXX}
\def\YNU@value@researchArea{XXXX}
\def\YNU@value@title{中文题目}
\def\YNU@value@englishtitle{英文题目}
\def\YNU@value@college{XXXX}

\newcommand\schoolNumber[1]{\def\YNU@value@schoolNumber{#1}}
\newcommand\classification[1]{\def\YNU@value@classification{#1}}
\renewcommand\author[1]{\def\YNU@value@author{#1}}
\newcommand\studentNumber[1]{\def\YNU@value@studentNumber{#1}}
\newcommand\advisor[1]{\def\YNU@value@advisor{#1}}
\newcommand\advisorTitle[1]{\def\YNU@value@advisorTitle{#1}}
\newcommand\degreeType[1]{\def\YNU@value@degreeType{#1}}
\newcommand\major[1]{\def\YNU@value@major{#1}}
\newcommand\researchArea[1]{\def\YNU@value@researchArea{#1}}
\newcommand\college[1]{\def\YNU@value@college{#1}}
\newcommand\englishtitle[1]{\def\YNU@value@englishtitle{#1}}
\renewcommand\title[1]{\def\YNU@value@title{#1}}
\newcommand\datetime[1]{\def\YNU@label@datetime{#1}}

% 研究生
\newcommand\clc[1]{\def\YNU@value@clc{#1}}
\newcommand\secretLevel[1]{\def\YNU@value@secretLevel{#1}}
\newcommand\udc[1]{\def\YNU@value@udc{#1}}
\newcommand\serialNumber[1]{\def\YNU@value@serialNumber{#1}}

% --- 用于测量标题宽度的盒子 ---
\newsavebox{\YNU@titlebox}

% % =========================================================
% % 7. 封面与内封
% % =========================================================

\newcommand{\makeEmptyPage}{\thispagestyle{empty}{\ }}
\newcommand{\twosideEmptyPage}{\if@isTwoSide\makeEmptyPage\fi}

% ========== 将换行符智能检测引擎移到外层全局区域 ==========
\def\YNU@check@newline#1\\#2\@nil{\ifx\empty#2\empty 0\else 1\fi}
\def\YNU@safe@uline#1\\#2\@nil{%
    \underline{\makebox[300pt][c]{#1}}%
    \ifx\empty#2\empty\else
        \\ \YNU@safe@uline#2\@nil
    \fi
}
% =======================================================

%  ============= 本科封面 ================
\newcommand{\makeBachelorCover}{
    \newpage\thispagestyle{empty}
    
    % 1. 左上角：横向校徽组合
    \begin{flushleft}
        \includegraphics[height=1.8cm]{style/本科毕设-校徽logo.png} 
    \end{flushleft}
    
    \vspace{1.2cm}
    
    % 2. 居中：云大毛笔字 Logo 
    \begin{center}
        \includegraphics[width=0.7\textwidth]{style/本科毕设-云南大学logo.png}
    \end{center}
    
    \vspace{1.0cm}
    
    % 3. 文档类型字样 
    \begin{center}
        {\songti\zihao{1}\bfseries 本科毕业论文（设计）}
    \end{center}
    
    \vspace{1.5cm}
    
    % 4. 核心信息表格
    \begin{center}
        {\songti\zihao{3}
        \renewcommand{\arraystretch}{1.5} % 拉大行距，使封面更舒展
        
        \begin{tabular}{rc}
            % 使用 \makebox 强制两端对齐
            \makebox[5.5em][s]{\heiti\bfseries 题\hfill 目}： & 
            \ifnum\expandafter\YNU@check@newline\YNU@value@title\\\empty\@nil=1
                % 用户手工使用了\\
                \begin{tabular}[t]{@{}c@{}}
                    \expandafter\YNU@safe@uline\YNU@value@title\\\empty\@nil
                \end{tabular}
            \else
                % 用户没有使用\\ 
                \sbox{\YNU@titlebox}{\YNU@value@title}%
                \ifdim\wd\YNU@titlebox<300pt
                    % 短标题：强制拉伸下划线到 300pt
                    \underline{\makebox[300pt][c]{\YNU@value@title}}
                \else
                    \parbox[t]{300pt}{\linespread{1.3}\selectfont\centering\CJKunderline[skip=false]{\YNU@value@title}}
                \fi
            \fi \\
            \makebox[5.5em][s]{\heiti\bfseries 学\hfill 院}： & \underline{\makebox[300pt][c]{\YNU@value@college}} \\
            \makebox[5.5em][s]{\heiti\bfseries 专\hfill 业}： & \underline{\makebox[300pt][c]{\YNU@value@major}} \\
            \makebox[5.5em][s]{\heiti\bfseries 学\hfill 号}： & \underline{\makebox[300pt][c]{\YNU@value@studentNumber}} \\
            \makebox[5.5em][s]{\heiti\bfseries 姓\hfill 名}： & \underline{\makebox[300pt][c]{\YNU@value@author}} \\
            \makebox[5.5em][s]{\heiti\bfseries 指\hfill 导\hfill 教\hfill 师}： & \underline{\makebox[300pt][c]{\YNU@value@advisor}} \\
        \end{tabular}}
    \end{center}
    
    \vfill
    
    % 5. 底部日期
    \begin{center}
        {\songti\zihao{3}\YNU@label@datetime}
    \end{center}
    
    \newpage\thispagestyle{empty}
}


% ====== 题目部分 ==========
% 题目部分：动态计算下划线的最大可用宽度：文本总宽\textwidth减去 左侧题目标签的宽度
\newlength{\YNU@PGTitleWidth}
\setlength{\YNU@PGTitleWidth}{\dimexpr\textwidth-7em\relax}

% 临时重写换行渲染引擎，使其自适应上方计算出的硕博封面新宽度
\def\YNU@safe@uline@PG#1\\#2\@nil{%
    \underline{\makebox[\YNU@PGTitleWidth][c]{#1}}%
    \ifx\empty#2\empty\else
        \\ \YNU@safe@uline@PG#2\@nil
    \fi
}

\newcommand{\makePostgradCover}{
    \newpage\thispagestyle{empty}
    
    % 1. 左上角：分类号、密级等参数 (宋体五号)
    \begin{flushleft}
        {\songti\zihao{5}
        \renewcommand{\arraystretch}{1.3}
        \begin{tabular}{ll}
            分类号 \underline{\makebox[3.0cm][c]{\YNU@value@clc}} & \quad 密级 \underline{\makebox[3.0cm][c]{\YNU@value@secretLevel}} \\
            \;UDC\quad \underline{\makebox[3.0cm][c]{\YNU@value@udc}} & \quad 编号 \underline{\makebox[3.0cm][c]{\YNU@value@serialNumber}} \\
        \end{tabular}}
    \end{flushleft}
    
    \vspace{0.1cm}
    
    % 2. 居中 Logo
    \begin{center}
        \includegraphics[width=0.65\textwidth]{style/研究生-云南大学logo.png}
    \end{center}
    
    \vspace{0.1cm}
    
    % 3. 硕博类型字样
    \begin{center}
        {\xingkai\xingkai\fontsize{50pt}{60pt}\selectfont
        \if@isDoctor
            博士研究生学位论文
        \else
            硕士研究生学位论文
        \fi}
    \end{center}
    
    \vspace{-0.2cm}

    % 4. 核心信息表格
    \begin{center}
        {\heiti\zihao{3}
        \renewcommand{\arraystretch}{1.2} % 拉大行距

        \begin{tabular}{lc}
            \makebox[4em][s]{\heiti\zihao{2}\bfseries 题\hfill 目} & 
            \heiti\zihao{2}\bfseries\ifnum\expandafter\YNU@check@newline\YNU@value@title\\\empty\@nil=1
                % 捕获到手工 \\ 换行，走等宽下划线分支
                \begin{tabular}[t]{@{}c@{}} \expandafter\YNU@safe@uline@PG\YNU@value@title\\\empty\@nil \end{tabular}
            \else
                % 自动计算换行分支
                \sbox{\YNU@titlebox}{\YNU@value@title}%
                \ifdim\wd\YNU@titlebox<\YNU@PGTitleWidth
                    \underline{\makebox[\YNU@PGTitleWidth][c]{\YNU@value@title}}
                \else
                    \parbox[t]{\YNU@PGTitleWidth}{\linespread{1.3}\selectfont\centering\CJKunderline[skip=false]{\YNU@value@title}}
                \fi
            \fi \\
            
            \makebox[4em][c]{\zihao{-2}\bfseries Title} & 
            \zihao{-2}\bfseries\ifnum\expandafter\YNU@check@newline\YNU@value@englishtitle\\\empty\@nil=1
                % 捕获到手工 \\ 换行，走等宽下划线分支
                \begin{tabular}[t]{@{}c@{}} \expandafter\YNU@safe@uline@PG\YNU@value@englishtitle\\\empty\@nil \end{tabular}
            \else
                % 自动计算换行分支
                \sbox{\YNU@titlebox}{\YNU@value@englishtitle}%
                \ifdim\wd\YNU@titlebox<\YNU@PGTitleWidth
                    \underline{\makebox[\YNU@PGTitleWidth][c]{\YNU@value@englishtitle}}
                \else
                    \parbox[t]{\YNU@PGTitleWidth}{\linespread{1.3}\selectfont\centering\CJKunderline[skip=false]{\YNU@value@englishtitle}}
                \fi
            \fi
        \end{tabular}

        \vspace{0.8cm}

        % ========== 其他信息 (居中独立控制) ==========
        \begin{tabular}{lc}
            \makebox[6em][s]{\bfseries 学院\,（所、中心）} & \underline{\makebox[250pt][c]{\YNU@value@college}} \\
            \makebox[5.5em][s]{\bfseries 专\hfill 业\hfill 名\hfill 称} & \underline{\makebox[250pt][c]{\YNU@value@major}} \\
            \makebox[5.5em][s]{\bfseries 研\hfill 究\hfill 方\hfill 向} & \underline{\makebox[250pt][c]{\YNU@value@researchArea}} \\
 
            \makebox[5.5em][s]{\bfseries 研\hfill 究\hfill 生\hfill 姓\hfill 名} & \underline{\makebox[80pt][c]{\YNU@value@author}}\makebox[60pt][c]{\quad\bfseries 学\hfill 号}\underline{\makebox[110pt][c]{\YNU@value@studentNumber}} \\
            \makebox[5.5em][s]{\bfseries 导\hfill 师\hfill 姓\hfill 名} & \underline{\makebox[80pt][c]{\YNU@value@advisor}}\makebox[60pt][c]{\quad\bfseries 职\hfill 称}\underline{\makebox[110pt][c]{\YNU@value@advisorTitle}} \\
        \end{tabular}}
    \end{center}
    
    \vfill
    
    % 5. 底部日期
    \begin{center}
    {\hspace{5em}\heiti\zihao{3}\bfseries\YNU@label@datetime}
    \end{center}
    
    \newpage\thispagestyle{empty}
}

%% -------- 封面分发器 --------
\newcommand{\makecover}{
    \if@isBachelor
        \makeBachelorCover
    \else
        \makePostgradCover
    \fi
}


% =========================================================
% 8. 自定义环境与杂项
% =========================================================

% =========================================================
% 提供给独立 .tex 文件使用的分支判断接口
% 用法：\branchByDegree{本科生内容}{硕博内容}
% =========================================================
\newcommand{\branchByDegree}[2]{%
    \if@isBachelor #1\else #2\fi
}


% =========================================================
% 内封：生成研究生学位申请简况表
% =========================================================
\newcommand{\makereviewtable}{
    \if@isBachelor
        \relax 
    \else
        \cleardoublepage 
        \pagestyle{YNU@empty} 
        
        % minipage 允许内部的弹簧自由伸缩
        \noindent\begin{minipage}[c][\textheight][s]{\textwidth}
            \vspace*{\fill} 
            \centering
            \if@isDoctor
                \input{chapters/review_table_doctor}%
            \else
                \input{chapters/review_table_master}%
            \fi
            \par
            \vspace*{\fill} 
        \end{minipage}
        
        \clearpage
        \pagestyle{YNU@heading}
    \fi
}


% =========================================================
% statement 环境
% =========================================================
\newenvironment{statement}{
    \if@isBachelor
        \chapter*{本科毕业论文（设计）独创性声明及使用授权}
    \else
        \chapter*{论文独创性声明及使用授权}
    \fi
    \thispagestyle{YNU@empty}}{}

\newenvironment{abstract}{
\chapter*{摘\quad 要}
\thispagestyle{YNU@plain}
\addcontentsline{toc}{chapter}{\texorpdfstring{摘\quad 要}{摘要}}}{}

\newcommand{\keywords}[1]{
\par\noindent\hspace{2\ccwd}{
\heiti\zihao{-4}\textbf{关键词：}}#1}

\newenvironment{englishabstract}{
\chapter*{Abstract}
\thispagestyle{YNU@plain}
\addcontentsline{toc}{chapter}{Abstract}}{}

\newcommand{\englishkeywords}[1]{
\par\noindent\hspace{2\ccwd}{
\bfseries\zihao{-4}Key Words:~}#1}

\newenvironment{mresume}{
    % 自动嵌入 博士/硕士/学士
    \chapter*{作者简历及攻读\YNU@value@degreeLevel 学位期间取得的研究成果}
    \thispagestyle{YNU@heading}
    % 让页眉双面显示完全统一
    \markboth{作者简历及攻读\YNU@value@degreeLevel 学位期间取得的研究成果}{作者简历及攻读\YNU@value@degreeLevel 学位期间取得的研究成果}
    \addcontentsline{toc}{chapter}{作者简历及研究成果}
}{}

\newenvironment{conclusion}{
    \chapter*{结论}
    \thispagestyle{YNU@heading}
    % 设置页眉显示内容
    \markboth{结论}{结论}
    % 写入目录，并使用 \texorpdfstring 避免书签警告
    \addcontentsline{toc}{chapter}{\texorpdfstring{结论}{结论}}
}{}

\renewenvironment{thanks}{
\chapter*{致\quad 谢}
\thispagestyle{YNU@heading}
\markboth{致\quad 谢}{致\quad 谢}
\addcontentsline{toc}{chapter}{\texorpdfstring{致\quad\quad 谢}{致谢}}}{}


% 中文破折号
\newcommand{\cndash}{\rule{0.0em}{0pt}\rule[0.35em]{1.4em}{0.05em}\rule{0.2em}{0pt}}

% 列表间距设置
\setitemize[1]{itemsep=2pt,parsep=0pt,topsep=0pt}
\setenumerate[1]{itemsep=2pt,parsep=0pt,topsep=0pt}

% 参考文献风格
\bibliographystyle{gbt7714-numerical}
\renewenvironment{thebibliography}[1]
{\zihao{5}
    \chapter*{参考文献} % 取消自动提取bibname，以确保无空行且满足三号黑体
    \@mkboth{参考文献}{参考文献}%
    \addcontentsline{toc}{chapter}{参考文献}
    \list{\@biblabel{\@arabic\c@enumiv}}%
    {\def\makelabel##1{##1\hfill} 
        \settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \setlength{\parsep}{1mm}
        \setlength{\labelsep}{0.5em}
        \setlength{\itemsep}{0.05pc}
        \setlength{\listparindent}{0in}
        \setlength{\itemindent}{0in}
        \setlength{\rightmargin}{0in}
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy\clubpenalty4000\@clubpenalty \clubpenalty\widowpenalty4000
    \sfcode`\.\@m}
{\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}\endlist}


% 代码块高亮样式配置
\lstset{
    % 设置基础字体，并使用 \linespread{1.0} 强制覆盖全局的 1.5 倍行距，使代码紧凑
    basicstyle=\linespread{1.0}\ttfamily\small, 
    keywordstyle=\color{blue},
    commentstyle=\color{green!50!black},
    stringstyle=\color{red},
    showstringspaces=false,
    numbers=left,
    numberstyle=\tiny\color{gray},
    frame=none, % 去掉边框，避免跨页断框
    breaklines=true,
    xleftmargin=7em, % 因为没有边框了，给左侧行号留出缩进空间
    aboveskip=3ex, % 减小代码块与正文的上方间距
    belowskip=3ex  % 减小代码块与正文的下方间距
}

% =========================================================
% 算法伪代码 (algorithm2e)
% =========================================================
\renewcommand{\algorithmcfname}{算法}
\SetKwInput{KwIn}{输入}
\SetKwInput{KwOut}{输出}
\SetAlgoCaptionSeparator{ ：}



% 2. 彻底解决右侧留白：引入宽度参数的居中算法环境
% 用法：\begin{centeralgo}[浮动位置]{算法宽度}
\newenvironment{centeralgo}[2][htbp]{
    \begin{figure}[#1]
    \centering
    % 使用 minipage 强行切断 algorithm2e 对全屏宽度的探测
    \begin{minipage}{#2}
    \begin{algorithm}[H]
}{
    \end{algorithm}
    \end{minipage}
    \end{figure}
}


% =========================================================
% 符号及定理环境 (严格遵循 GB/T 3102.11 规范)
% =========================================================

% 1. 向量 (Vector)：小写粗斜体 (Bold Italic)
\renewcommand{\vec}[1]{\bm{#1}}
% 2. 矩阵 (Matrix)：大写粗斜体 (Bold Italic)
\newcommand{\mat}[1]{\bm{#1}}
% 3. 张量 (Tensor)：粗花体 (Bold Calligraphic)
\newcommand{\tensor}[1]{\boldsymbol{\mathcal{#1}}}

% 4. 定理环境
\newtheoremstyle{mythm}{}{}{}{\parindent}{\bfseries}{：}{ }{}
\theoremstyle{mythm}
\newtheorem{Definition}{定义}[chapter]
\newtheorem{Theorem}{定理}[chapter]
\newtheorem{Lemma}{引理}[chapter]
\newtheorem{Proof}{证明}[chapter]
\renewcommand*{\qedsymbol}{[证毕]}


\newcommand{\refeq}[1]{（\ref{#1}）} %自定义指令，正文引用公式时的括弧为中文括弧，如公式\refeq{eq:xxx}所示 -> 如公式（2.1）所示

\endinput