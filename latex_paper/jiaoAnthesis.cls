% 指定本模板兼容的 \LaTeX 版本。
\NeedsTeXFormat{LaTeX2e}[2018/04/01]
% 定义模板名称
\ProvidesClass{jiaoAnthesis}
[2022/12/07 1.0.0 jiaoAn Thesis Template]
% 检查是否使用 \XeTeX 编译，若没有则报错。
\RequirePackage{ifxetex}
\ifxetex\else
\ClassError{jiaoAnthesis}{XeLaTeX is required to compile the document}{}
\fi

% 加载支持中文的文档类
% 设置正文字号：小四，使用UTF8编码；
% openany避免章节末产生空白页；
% 不使用默认中文字体；
% scheme = chinese设置图表采用中文名称。
\LoadClass[zihao=-4,UTF8,openany,fontset=none,scheme=chinese]{ctexbook}

% \pkg{fontspec} 已经在 ctexbook 里加载，但这里还需要额外配置。
% 设置 \pkg{fontspec}为不处理数学字体（no-math）。
% 因为默认情况下fontspec会将 \cs{mathrm} 的字体更改为 Times New Roman，
% ⽽ \cs{mathnormal} 依然为 Computer Modern Roman，⽐ Times New Roman 要细。
\PassOptionsToPackage{no-math}{fontspec}

% ^^A ==========================================================================
% 加载模板将使用到的宏包，由于宏包加载顺序会相互影响配置，因此在此处集中加载宏包，
% 并且不随意改变宏包加载顺序。
% 生成 PDF 标签需要 \pkg{hyperref} 宏包，但该宏包必须在所有宏包后加载才能正确应用，
% 因此该宏包不在这里加载，而应该在用户端的最后加载。
\RequirePackage{newtxmath} % 用于单独设置公式使用Times New Roman字体
\RequirePackage{xeCJKfntef} % 用于实现汉字下划线和盒子内两段对齐
\RequirePackage{fancyhdr} % 用于设置页眉页脚
\RequirePackage{geometry} % 用于设置页面大小、边距
\RequirePackage{pifont} % 实现脚注编号使用漂亮的带圈数字符号
\RequirePackage[perpage]{footmisc} % 实现让脚注每页清零编号
\RequirePackage{graphicx} % 插图导入支持
\RequirePackage{color}
\RequirePackage{caption} % 设置图表标题格式
\RequirePackage{booktabs} % 设置三线表
\RequirePackage{tocloft} % 设置目录格式
\RequirePackage[inline]{enumitem} % 设置列表格式
\RequirePackage{etoolbox} % dev tool
% \RequirePackage[backend=biber,style=gb7714-2015]{biblatex} % 参考文献工具（使用国标）
\RequirePackage[backend=biber,style=gb7714-2015,gbalign=gb7714-2015,gbpub=false,gbnamefmt = lowercase]{biblatex}
\addbibresource[location=local]{ref.bib}
\RequirePackage{eqparbox}
% ^^A ==========================================================================
% 定义论文基本信息变量
% 定义用户输入参数接口：全局变量
% 批量定义关于封面信息的全局宏，使所有选项在 jiaoAn 选项族下,并将内部宏转化为外部宏命令。
\def\jiaoAn@def@prm#1#2{%
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname jiaoAn@#1\endcsname{##1}%
  }%
  \csname #1\endcsname{#2}%
}
% 作者信息：中英文姓名、学科专业、研究方向、学号。
\jiaoAn@def@prm{degree}{}
\jiaoAn@def@prm{cauthor}{中文名}
% \jiaoAn@def@prm{eauthor}{English Name}
\jiaoAn@def@prm{cmajor}{学科专业中文名}
% \jiaoAn@def@prm{emajor}{major}
\jiaoAn@def@prm{research}{研究方向}
\jiaoAn@def@prm{id}{学号}
% 论文中英文题目。
\jiaoAn@def@prm{ctitle}{}
% \jiaoAn@def@prm{etitle}{}
% 导师中英文姓名。
\jiaoAn@def@prm{csupervisor}{}
% \jiaoAn@def@prm{esupervisor}{}
% 论文完成日期（中英文）。
\jiaoAn@def@prm{cdate}{}
% \jiaoAn@def@prm{edate}{}
% 图书分类号。
\jiaoAn@def@prm{clc}{}

% ^^A ==========================================================================
% 字体设置
% 已通过加载 \pkg{ctex} 宏包设置全文字号为小四。
% 已通过加载\pkg{newtxmath}宏包单独设置公式使用Times New Roman字体。
%\setmainfont{⟨font name⟩}[⟨font features⟩]   % 修改默认衬线字体格式
% \setsansfont{⟨font name⟩}[⟨font features⟩]   % 修改默认无衬线字体格式
% \setmonofont{⟨font name⟩}[⟨font features⟩]   % 修改默认等宽字体格式
% \setCJKmainfont{FandolKai}   % 设置中文衬线字体格式
% \setCJKsansfont{FandolFang}  % 设置中文无衬线字体格式
% \setCJKmonofont{FandolHei}   % 设置中文等宽字体格式
% 使用 \pkg{fontspec} 宏包设置正文英文字体。
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}

% \setmainfont{Times New Roman}
\setCJKmainfont{SimSun}[AutoFakeBold=true] 
\setCJKsansfont{SimHei}[AutoFakeBold=true] 
% \setCJKmonofont{SimSun} % 避免 warning
\setCJKfamilyfont{song}{SimSun}
\setCJKfamilyfont{Heiti}{SimHei}
\setCJKfamilyfont{自定义的CJKfamily名称}{系统字体名称}

% 利用 \pkg{ctex} 宏包设置中文字体。设置正文字体为思源宋体(SC:简体)；
% 设置 \cs{song} 为思源宋体； 设置 \cs{hei} 为思源黑体。
% \setCJKmainfont{Source Han Serif CN}
% \setCJKsansfont{Source Han Sans CN}
% \setCJKmonofont{Source Han Sans CN} % 避免 warning
% \setCJKfamilyfont{song}{Source Han Serif CN}
% \setCJKfamilyfont{hei}{Source Han Sans CN}

% ^^A ==========================================================================
% 行距:1.25倍
\linespread{1.25}
% 字体、行距设置立即生效。
\selectfont
% TODO: Check that
% \LaTeX 和 Word 的行距的定义都是字底部到下一行字底部的距离（见刘海洋《\LaTeX 入门》p.82），
% 但后面设置，如章节、图表与正文间距时，需要用到字底部到下一行字顶部的距离。
% 因此定义该距离为 \cs{linegap}，在正文行距的基础上计算得到：（见刘海洋《\LaTeX 入门》p.83）
% \cs{jiaoAn@linegap} = 1.25 * (1.2 * 12bp)  - 12 bp = 6 bp
\newcommand{\jiaoAn@linegap}{6bp}

% ^^A ==========================================================================
% {页面设置}
% 利用 \pkg{geometry} 设置页面尺寸
% A4纸张;
% 页面：论文需用A4纸（210 mm×297 mm）印刷，页眉、页脚20mm，上、下页边距为30mm，左、右边距为25mm。
% 设置页眉高度(box) 0.55 cm, 否则编译后会警告页眉高度过小；
% 页眉顶部到纸张顶部距离 12 cm，
% 而 \pkg{geometry} 只有页眉顶部到版面顶端的选项 \cs{headsep},
% 因此需要换算：headsep = 上边距3 - 页眉顶部到纸张顶部距离 2- 页眉高度0.55 = 0.45 cm
% 页脚到纸张底部距离 2 cm，
% 也需要换算计算页脚到版式底部距离 footskip = 下边距3 - 2 = 1cm
\geometry{
  paper      = a4paper,
  left=2.5cm,
  right=2.5cm,
  top=3cm,
  bottom=3cm,
  headheight = 0.55cm,
  headsep    = 0.45cm,
  footskip   = 1cm
}

% ^^A ==========================================================================
% 利用 \pkg{fancyhdr} 设置正文前和正文中页眉页脚内容。
%
% 无页眉，页码小五号，罗马数字，Time New Roman，居中。
% 定义对应的 plain 样式。
\fancypagestyle{plain}{%
  % 清除所有页眉页脚。
  \fancyhf{}
  % 设置页码小五号
  \cfoot{\zihao{-5}\selectfont \thepage}
  % 无页眉线
  \renewcommand{\headrulewidth}{0bp}
}



% 正文页眉五号宋体居中；页码小五号，阿拉伯数字，Times New Roman，居中。
% 定义对应的 headings 样式。
% Note: 不要重定义 fancy 风格， 会导致编译时卡住。
\fancypagestyle{headings}{%
  % 清除所有页眉页脚。
  \fancyhf{}
  % 奇数页(O)页眉居中(C), 五号宋体。
  \fancyhead[CO]{\zihao{5}\CJKfamily{song}\selectfont 湖南科技大学\hspace{\ccwd}教学技能训练\hspace{\ccwd}教案}
  % 偶数页(E)居中(C)页眉, 五号宋体。
  \fancyhead[CE]{\zihao{5}\CJKfamily{song}\selectfont \leftmark}
  % 页眉线宽 1.5 bp。
  \renewcommand{\headrulewidth}{0.75bp}
  % 页码小五号
  \cfoot{\zihao{-5}\selectfont -\thepage- }
}

% 应用上述自定义的页眉页脚样式到相应的部分。
%
% 摘要、物理量名称及符号表 (frontmatter) 使用自定义的 plain 样式。
\renewcommand{\frontmatter}{%
  \clearpage
  \@mainmatterfalse
  \pagenumbering{roman} % 页码使用小写罗马数字
  \pagestyle{plain}
}

% % 目录页使用自定义的 headings 样式。


% 正文页使用自定义的 headings 样式。
\renewcommand{\mainmatter}{%
  \clearpage
  \@mainmattertrue
  \pagenumbering{arabic} % 页码使用阿拉伯数字
  \pagestyle{headings}
}
% 每章第一页默认会设置特殊的 page style，设置它与其他正文页眉页码相同
\ctexset{chapter/pagestyle=headings}


% ^^A ==========================================================================
% {常用短语的定义}
%teaching material
\newcommand{\TM}{\noindent\textsf{教\hspace{\ccwd}\hspace{\ccwd}材:}}
% Teaching Content
\newcommand{\TC}{\noindent\textsf{教学内容:}}
\newcommand{\LT}{\noindent\textsf{授课类型:}}
\newcommand{\TP}{\noindent\textsf{教学目标:}}
\newcommand{\KP}{\textsf{知识目标:}}
\newcommand{\AP}{\textsf{能力目标:}}
\newcommand{\EP}{\textsf{情感目标:}}
\newcommand{\TE}{\noindent\textsf{教学重点:}}
\newcommand{\TD}{\noindent\textsf{教学难点:}}
\newcommand{\TMethods}{\noindent\textsf{教学方法:}}
\newcommand{\TProcess}{\noindent\textsf{教学过程设计:}}
% ^^A ==========================================================================
% \newcommand{\problem}{\textsf{问题}\refstepcounter{myproblems}\themyproblems:}
% \newcommand{\example}{\textsf{例}\refstepcounter{myexample}\themyexample:}
\newcommand{\rethink}{\textsf{回顾:}}
\newcommand{\explore}{\textsf{探究:}}
\newcommand{\think}{\textsf{思考:}}
\newcommand{\change}{\textsf{变形:}}
\newcommand{\specific}{\textsf{具体:}}
\newcommand{\DP}{\textsf{[设计意图]}}
\newcommand{\TSA}{\textsf{师生活动:}}
\newcommand{\HW}{\textsf{作业:}}
\newcommand{\reproblem}{\textsf{追问:}}


% ^^A ==========================================================================
% {计数器的设置，用于问题1，问题2的显示}
\newcounter{myproblems}[chapter]
\setcounter{myproblems}{1} 
\renewcommand {\themyproblems}{\arabic{myproblems}}
\newenvironment{problem}{\par \refstepcounter{myproblems}\textsf{问题}\themyproblems:}{\par}
% ^^A ==========================================================================
% {计数器的设置，用于例1，例2的显示}
\newcounter{myexample}[chapter]
\setcounter{myexample}{1} 
\renewcommand {\themyexample}{\arabic{myexample}}
\newenvironment{example}{\par\refstepcounter{myexample}\textsf{例}\themyexample}{\par}
% ^^A ==========================================================================
% {}
\newcounter{myintroduction}[chapter]
\setcounter{myintroduction}{1} 
\newcommand{\introduction}{\textsf{引言}\refstepcounter{myintroduction}\themyintroduction:}
% ^^A ==========================================================================
% {}



% ^^A ==========================================================================
% {目录}
% 在目录中只显示三级章节标题, 即1.1.1
\setcounter{tocdepth}{1}
% 使用 \pkg{tocloft} 设置目录格式。
% 目录项前面的引导点默认是西文的句号，它与基线平齐。而中文排版需要将其修改为居中的中文省略号。
\renewcommand{\cftdot}{…}
\renewcommand{\cftdotsep}{0}
% 修改目录标题与章标题格式相同：小二，黑体 (英文Arial)，居中
% 段前 0.5行, 段后 18 bp (学校未规定）
\renewcommand{\contentsname}{目\hspace{\ccwd}\hspace{\ccwd}录}
\renewcommand{\cfttoctitlefont}{\hfill\zihao{-3}\sffamily}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftbeforetoctitleskip}{7.5 bp}
\renewcommand{\cftaftertoctitleskip}{12 bp}
% 章标题：小四，黑体 (英文 Arial)，1.25倍行距； 设置页号不加粗，设置引线
\renewcommand{\cftchapfont}{\zihao{-4}\sffamily}
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftchappagefont}{\normalfont} % 取消页码加粗
\renewcommand{\cftbeforechapskip}{0bp} % 取消章节的段前距离
% 一级节标题：小四，宋体 (英文 Times New Roman)，1.25倍行距。
\renewcommand{\cftsecfont}{\zihao{-4}}
\renewcommand{\cftbeforesecskip}{0bp} % 取消段前距离
% 二级节标题：小四，宋体 (英文 Times New Roman)，1.25倍行距。
\renewcommand{\cftsubsecfont}{\zihao{-4}}
\renewcommand{\cftbeforesubsecskip}{0bp} % 取消段前距离

% ^^A ==========================================================================
% {章节标题}
% 最多允许两级节标题编号, 即1.1.1
\setcounter{secnumdepth}{3}
% 章标题:小二，黑体 (英文Arial)，居中，1.25 倍行距 (只影响标题内行距，不影响标题与正文的行距)
% (注: LaTeX 的章节行距不影响段前段后间距，而 Word 的行距设置会影响段前段后距离)；
% 段前 24 bp, 段后 18 bp (学校未规定）；章序号与章节名间空一字。
\ctexset{
  chapter = { 
    % 注：若要调整行距 linespread, 还需要额外加 selectfont 才能生效。
    format = \linespread{1}\zihao{-2}\sffamily\centering\selectfont,
    % \linespread{1}
    % 清除单独设置章节名和随后标题内容的格式。
    nameformat = {},
    numberformat = {},
    titleformat = {},
    % 章节名与其后标题内容间的间距：1个汉字字符。
    aftername = \hspace{\ccwd},
    name = {第,课时},
    number=\arabic{chapter},
    % beforeskip=1\baselineskip
    beforeskip = 18 bp, % 段前间距
    afterskip = 18 bp, % 段后间距
    % book类的标题与正文的距离除了由 beforeskip 和 afterskip 选项设置的垂直间距外
    % 还会有一些多余的间距(该间距大小受行距影响)，fixskip 选项用于抑制这些多余间距。
    fixskip = true,
    afterindent = true % 设置章标题后首段缩进
  }
}

% 一级节标题：四号，黑体，左顶格，1.25 倍行距，段前 24 bp，段后与正文行距相同 (6 bp)；
% 但不抑制自动增加的段前段后多余的垂直间距，这样能稍大于正文行距离。
% 章序号与章节名间空一字。
\ctexset{
  section = {
    format = \zihao{4}\sffamily\raggedright\linespread{1}\selectfont,
    % aftername = \hspace{\ccwd}, % 节名与其后标题内容间的间距：1个汉字字符。
    aftername=\hspace{ 0em},
    name = {,、},
    beforeskip = 7 bp,
    afterskip=7 bp,
    % afterskip = \jiaoAn@linegap,
    fixskip = false, % 不抑制多余的垂直间距。
    afterindent = true % 设置节标题后首段缩进。
  }
}

% 二级节标题：小四号，黑体，左顶格，1.25 倍行距，
% 段前 12 bp，段后与正文行距相同 (6 bp)；
% 但不抑制自动增加的段前段后多余的垂直间距，这样能稍大于正文行距离。
% 章序号与章节名间空一字。


\ctexset{
  subsection = {
    format = \zihao{-4}\sffamily\raggedright\linespread{1}\selectfont,
    aftername = \hspace{\ccwd}, % 节名与其后标题内容间的间距：1个汉字字符。
    name={,.},
    number=\arabic{subsection},
    beforeskip =\jiaoAn@linegap,
    afterskip = \jiaoAn@linegap,
    fixskip = false, % 不抑制多余的垂直间距。
    afterindent = true % 设置节标题后首段缩进。
    }
  }
\renewcommand\thesection{\chinese{section} }
% \renewcommand\thesection{\arabic{section}.\arabic{subsection} }
\renewcommand\thesubsubsection{(\arabic{subsubsection})}
% 三级节标题：小四号，黑体，左顶格，1.25 倍行距 (只影响标题内行距，不影响标题与正文的行距)
% 段前 6 bp，段后 6 bp, 抑制多余的垂直间距，
% 这样就等价于设置：无段前段后并与正文内容为 1.25 倍行距；
% 章序号与章节名间空一字。
\ctexset{
  subsubsection = {
    format = \zihao{-4}\sffamily\raggedright\linespread{1}\selectfont,
    indent=2\ccwd,
    aftername = \hspace{\ccwd}, % 节名与其后标题内容间的间距：1个汉字字符。
    beforeskip =\jiaoAn@linegap ,
    afterskip = \jiaoAn@linegap,
    fixskip = true, % 抑制多余的垂直间距。(保持为行间距)
    afterindent = true % 设置节标题后首段缩进。
  }
}
% ^^A ==========================================================================
% {正文格式}
%
% 全文首行缩进 2 字符，标点符号用全角。
\ctexset{%
  punct=quanjiao,
  space=auto,
  autoindent=true
}
% 禁止扩大段间距。
% 并且修复 `` Underfull \cs{vbox} (badness 10000)  ‘’ warning
\raggedbottom
\setlength{\parskip}{\z@} % 段间距 0 磅

% \pkg{pitfont} 实现带圈脚注，另外LaTeX 默认脚注按章计数，即每章的开始才重置脚注计数器，
% 使用的 \pkg{footmisc} 会使每页脚注编号清零。
\renewcommand{\thefootnote}{\ding{\numexpr171+\value{footnote}}}

% ^^A ==========================================================================
% \pkg{caption} 宏包设置图表标题格式。
% 定义用于设置编号和标题内容字符间距的 caption 内部命令。
\DeclareCaptionLabelSeparator{zhspace}{\hspace{\ccwd}}
% 设置图表编号用 - 连接。
\renewcommand*{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand*{\thetable}{\thechapter-\arabic{table}}
\captionsetup{
  format = hang, % 多行缩进
  font = small, % 五号（正文小四，对应的small size是五号），宋体
  labelsep = zhspace, % 编号和标题内容间隔一个中文字符
  % 不要在这里设置图名称，利用 ctex 设置，即 scheme = chinese。
  % 因为这里设置的话会导致使用 biblatex 报错，
  % 要避免这个报错必须在导入 biblatex 前加命令个修正命令
  % 见 \url{https://github.com/CTeX-org/ctex-kit/issues/380}
  % 实在要改动也应该在 ctexsetup 里设置，见 ctex 文档
  % ^^A	figurename = 图,
  % ^^A	tablename = 表,
  skip = \jiaoAn@linegap % 图表与其标题间的垂直距离: 与正文行间的距离相同
}
% 设置表格内字体为5号
\patchcmd\@floatboxreset{\normalsize}{\small}{}{Failed to set float font}

% 注意图表底部自动加入了额外的间距，因此不需要再设置段后距离。
% 图表（使用插入模式：h）与其顶部、底部正文距离(除去额外间距)：与正文行间的距离相同。
\setlength{\intextsep}{\jiaoAn@linegap}
% 设置（浮动模式）与其顶部、底部正文距离(除去额外间距)：与正文行间的距离相同
\setlength{\textfloatsep}{\jiaoAn@linegap}
% 设置两图表（浮动模式）之间的距离(除去额外间距)：与正文行间的距离相同
\setlength{\floatsep}{\jiaoAn@linegap}

% ^^A ==========================================================================
% {公式}
% 设置公式编号用 . 连接。
\renewcommand*{\theequation}{\thechapter.\arabic{equation}}
% 设置公式段前段后距离。
% 这里有两种段前段后 displayskip 和 displayshortskip，
% 公式前一行文字会影响公式选择哪一种段前段后 (见 Mathmode 文档)。
% 当小于公式前缩进的空白长度，会采用 displayshortskip 设置公式的段前段后距离。
% 这可能是因当文字小于公式前缩进的空白长度时，这些空白会给人感觉段间距变大了，
% 因此采用一个较小的段间距参数。
% \textbf{注意：} \cs{normalsize} 在执行时会重置公式的段前段后参数设置，导致设置失效。
% 有几种办法解决：
% 1. 在 normalsize 执行后再修改这些参数；
% 2. 重定义 normalsize，在里面定义字体的同时将公式段前段后设置为正确值；
% 3. 将公式段前段后设置的参数传递给 normalsize。
% 这里采用第一种方法。
\AtBeginDocument{%
  \abovedisplayskip = 12bp \@plus 3bp \@minus 7bp
  \belowdisplayskip = \abovedisplayskip
  % 当公式上方一行文字的长度短于公式前缩进的空白长度时的段前距
  \abovedisplayshortskip = 0 bp \@plus 3bp
  % 当公式上方一行文字的长度短于公式前缩进的空白长度时的段后距
  \belowdisplayshortskip = 6.5bp \@plus 3.5bp \@minus 3bp
}

% ^^A ==========================================================================
% {列表}
% 设置列表格式与正文相同，首行缩进两字符，列表无段前段后距离。

% \setlist{wide,noitemsep,nosep}
% \setlist[enumerate]{label=(\arabic*), ref=(\arabic*)} % 采用括号数字

% 行间列表，\item换行
% 编号采用括号数字
\newenvironment{enumerateout}{\begin{enumerate}
  [label=(\arabic*), ref=(\arabic*),wide,noitemsep,nosep]
  }
  {\end{enumerate}}
% 行内列表【不可以添加公式】 \item不换行
% 编号采用括号字母
\newenvironment{enumeratein}{\begin{enumerate*}
  [label=(\arabic*), ref=(\arabic*),noitemsep,nosep]
  }
  {\end{enumerate*}}
  % 没有对齐的描述环境
  % \newenvironment{newdescription}{\begin{description}
  %   [wide,noitemsep,nosep]
  %   }
  %   {\end{description}}

% 它接收最长标签，计算它的长度，并把所有的标签都设置到同样的长度，从而实现对齐。
\newlist{mydescription}{description}{1} %% <- pick a larger number if you want to nest these
\setlist[mydescription]{
    labelwidth=\eqboxwidth{listlabel@\EnumitemId},
    leftmargin=!,
    format=\mydescriptionlabel,
    noitemsep,
    nosep,
    wide
}
\newcommand\mydescriptionlabel[2][l]{\eqmakebox[listlabel@\EnumitemId][#1]{#2}}


% ^^A ==========================================================================
% {其他宏包的设置}
% 这些宏包并非格式要求，但是为了方便使用，在这里进行简单设置。
% 这些宏包并未在模板里加载，需要在用户端加载，加载后自动设置下面预设的参数。
%
% 定义宏包末尾钩子： 与 filehook 的 \cs{AtEndOfPackageFile*} 类似
% 如果原来没有在载入宏包则在宏包末尾执行语句，否则立即执行
\newcommand\jiaoAn@atendpackage{\csname ctex_at_end_package:nn\endcsname}

% \subsubsection{\pkg{hyperref} 宏包}
\jiaoAn@atendpackage{hyperref}{
  % PDF 标签设置
  \hypersetup{
    bookmarksopen      = true, % 开启书签
    bookmarksnumbered  = true, % 目录书签带编号
    bookmarksopenlevel = 1, % 默认展开章层次
    linktoc            = all, % 目录中的章节标题、页码全部链接到对应页面
  }
  % 超链接样式设置, 无边框，黑色。
  \hypersetup{
    colorlinks = true,
    allcolors  = black
  }
  % 根据论文信息填写 PDF 个人信息。
  \AtBeginDocument{
    \hypersetup{
      pdftitle = \jiaoAn@ctitle,
      pdfauthor = \jiaoAn@cauthor
    }
  }
}

% {\pkg{cleveref} 宏包}
% 设置中文图表、公式的文中引用，该宏包应该在 \pkg{hyperref} 之后加载。
\jiaoAn@atendpackage{cleveref}{
  % 公式设置
  \crefformat{equation}{(#2#1#3)}
  \crefrangeformat{equation}{公式(#3#1#4) 至 (#5#2#6)}
  \crefmultiformat{equation}{公式(#2#1#3)}{和(#2#1#3)}{，(#2#1#3)}{和(#2#1#3)}
  % 图设置
  \crefformat{figure}{图~#2#1#3}
  \crefrangeformat{figure}{图~#3#1#4 至 #5#2#6}
  \crefmultiformat{figure}{图~#2#1#3}{ 和~#2#1#3}{，#2#1#3}{ 和~#2#1#3}
  % 表设置
  \crefformat{table}{表~#2#1#3}
  \crefrangeformat{table}{表~#3#1#4 至 #5#2#6}
  \crefmultiformat{table}{表~#2#1#3}{ 和~#2#1#3}{，#2#1#3}{ 和~#2#1#3}



}
\endinput
%%
%% End of file `jiaoAnthesis.cls'.
