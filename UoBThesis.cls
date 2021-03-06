%
% UoB-Thesis/UoBThesis.cls
%
% Developed by Greg Tourte <artourter@gmail.com>
% Copyright (c) 2018 The University of Bristol
% All rights reserved.
%
% Changelog:
% 30/07/2018 - created
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UoBThesis}[2018/08/01 University of Bristol PhD Thesis Class]


\RequirePackage{iftex,ifpdf,ifxetex,ifluatex}

% from https://tex.stackexchange.com/a/47579/12332
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\ifluatex
    \pdfvariable minorversion 7
    \pdfvariable pageattr {/Group << /S /Transparency /I true /CS /DeviceCMYK>>}
 %   \pdfextension catalog{%
 %       /OutputIntents [ <<
 %       /Type /OutputIntent
 %       /S/GTS_PDFA2
 %       /DestOutputProfile \the\numexpr\pdffeedback lastobj\relax\space 0 R
 %       /OutputConditionIdentifier (eciRGB v2)
 %       /Info(eciRGB v2)
 %       >> ]
 %   }

\else\ifpdf
    \pdfminorversion 7
    \pdfpageattr {/Group << /S /Transparency /I true /CS /DeviceCMYK>>}
\fi\fi

%% PRELIMINARY DECLARATIONS
\LoadClass[version=last]{scrbook}

\input{UoBThesis.inc}

\ifuob@uobthesis@print
    \ifluatex
        \pdfvariable minorversion 4
    \else\ifpdf
        \pdfminorversion 4
    \fi\fi
\fi

    
\RequirePackage{scrhack}
\RequirePackage{scrlayer-scrpage}
\RequirePackage{mathtools}
%\PassOptionsToPackage{pdfa}{hyperref}
\ifuob@uobthesis@print\else
    \AfterAtEndOfPackage{hyperref}{\RequirePackage{bookmark}}
    \AfterAtEndOfPackage{hyperref}{\RequirePackage{hyperxmp}}
\fi
\AfterAtEndOfPackage{hyperref}{\RequirePackage[nameinlink]{cleveref}}

\ifluatex
% Loading LuaTeX spefic packages
    \RequirePackage {fontspec}
    % required to be loaded before microtype to fix a bug in the version
    % shipped with TeXLive 2018 a revised version of microtype with a fix has
    % been release on 2019-02-28.  Since the date ckeck requires the package to
    % be already loaded, we use fontspec which as updated in TeXLive 2019
    % mid-march 2019 as the validator
    \@ifpackagelater{fontspec}{2019/03/14}{%
        % fontspec is newer than fixed microtype so we assume microtype is updated.
        \RequirePackage {microtype}
    }{%
    \message{fixing bug microtype package in TeXLive 2018, by loading the luatexbase package first}
        \RequirePackage {luatexbase}
        \RequirePackage {microtype}
    }
    %
    \defaultfontfeatures{Ligatures = {TeX}}
    \ifuob@uobthesis@minionthree
        \setmainfont {Minion 3}[
            Numbers      = {Proportional,OldStyle},
            SizeFeatures = {
                { Size   = -9.9, Font = Minion 3 Caption },
                { Size   = 9.9-13.9 },
                { Size   = 13.9-25.9, Font = Minion 3 Subhead },
                { Size   = 25.9-, Font = Minion 3 Display },
            },
            BoldFont     = * Semibold,
            ItalicFont   = * Italic,
        ]
        \newfontfamily\liningroman{Minion3}[
            Numbers = {Proportional,Lining},
            Ligatures = {TeX},
%            RawFeature = {+case},
            ]
    \else\ifuob@uobthesis@minion
        \setmainfont {Minion Pro}[
            Numbers = {Proportional,OldStyle},
            BoldFont= * bold,
        ]
        \newfontfamily\liningroman{Minion Pro}[
            Numbers = {Proportional,Lining},
            Ligatures = {TeX},
%            RawFeature = {+case},
            ]
    \else
        \setmainfont {Libertinus Serif}[
            Numbers = {Proportional,OldStyle},
            BoldFont= * bold ]
        \newfontfamily\liningroman{Libertinus Serif}[
            Numbers = {Proportional,Lining},
            Ligatures = {TeX},
            RawFeature = {+case},
            ]
    \fi\fi
    \defaultfontfeatures{Scale = {MatchLowercase}}
    \setsansfont {LibertinusSans}[
        Numbers = {Proportional,OldStyle} ]
    \setmonofont {InconsolataN}[
        ItalicFont = *,
        ItalicFeatures = FakeSlant,
        RawFeature = -tlig;-trep,
        StylisticSet={1,3} ]
    \RequirePackage[math-style=TeX]{unicode-math}
    \setmathfont{Libertinus Math}

    \RequirePackage {polyglossia}
    \setdefaultlanguage[variant=british]{english}
    \RequirePackage [english]{selnolig}
    \RequirePackage {luatextra}
%
\else\ifxetex
% Loading XeTeX specific packages
    \RequirePackage {fontspec,microtype}
    \defaultfontfeatures{Ligatures = {TeX}}
    \setmainfont {Libertinus Serif}[
        Numbers = {Proportional,OldStyle},
        BoldFont= * bold ]
    \defaultfontfeatures{Scale = {MatchLowercase}}
    \setsansfont {Libertinus Sans}[
        Numbers = {Proportional,OldStyle} ]
    \setmonofont {InconsolataN}[
        ItalicFont = *,
        ItalicFeatures = FakeSlant,
        RawFeature = -tlig;-trep,
        StylisticSet={1,3} ]
    \newfontfamily\liningroman{Libertinus Serif}[
        Numbers = {Proportional,Lining},
        Ligatures = {TeX},
        Scale = {MatchLowercase},
        RawFeature = {+case},
        ]
    \RequirePackage[math-style=TeX]{unicode-math}
    \setmathfont{Libertinus Math}

    \RequirePackage {polyglossia}
    \setdefaultlanguage[variant=british]{english}
\else
   \RequirePackage [T1]{fontenc}
   \RequirePackage [utf8]{inputenc}
   \RequirePackage {libertine}
   \RequirePackage {libertinust1math}
   \RequirePackage [narrow,varqu,varl]{inconsolata}
   \RequirePackage [british]{babel}
\fi\fi

\RequirePackage {needspace}

\RequirePackage {graphicx}
\graphicspath{{Images}}
\DeclareGraphicsExtensions{.pdf,.png,.jpg}
\RequirePackage [nodisplayskipstretch]{setspace} %onehalfspacing or doublespacing are the options here
%\setstretch{1.20}
\RequirePackage {xcolor}
%\RequirePackage [final]{changes}
\RequirePackage {multicol}
\RequirePackage {multirow}
\RequirePackage {booktabs}
%\RequirePackage [begintext={``} , endtext={''},vskip={\topsep}]{quoting}
\RequirePackage {quoting}
\RequirePackage {tabu}
\PassOptionsToPackage{hyphens,obeyspaces,spaces}{url}
\RequirePackage {etoolbox}
\RequirePackage{ragged2e}
\RequirePackage{relsize}

\ifPDFTeX\else
    \typeout{ UoBThesis: DEBUG: I am not running pdftex... }
    \AtBeginEnvironment{tabu}{
        \addfontfeature{ Numbers = {Lining, Monospaced}, RawFeature = {-onum,-pnum,+tnum,+case}}
        \smaller
    }
\fi
\RequirePackage [version=4]{mhchem}
\ifPDFTeX\else 
    \typeout{ UoBThesis: DEBUG: I am not running pdftex... }
    \mhchemoptions{%
        textfontcommand = \addfontfeature{Numbers = {Lining, Monospaced}, RawFeature = {-onum,-pnum,+tnum,+case}},%
    }
\fi

\RequirePackage {siunitx}
% fix tabu use of siunitx from http://tex.stackexchange.com/questions/70279/newcolumntype-siunitx-tabu-and-illegal-pream-tokens
\ExplSyntaxOn
\cs_new_eq:NN \siunitx_table_collect_begin:Nn \__siunitx_table_collect_begin:Nn
\ExplSyntaxOff
\RequirePackage [shortlabels,inline]{enumitem}
\setlist{noitemsep}
%\setlist[1]{labelindent=\parindent}
\setlist[itemize]{leftmargin=*}
\setlist[enumerate]{leftmargin=*}
\RequirePackage {varwidth}

\RequirePackage {float}

\RequirePackage[mode=tex]{standalone}
\RequirePackage{xstring}

\newcommand{\includestandalonewithpath}[2][]{%
    \begingroup%
    \StrCount{#2}{/}[\matches]%
    \StrBefore[\matches]{#2}{/}[\datapath]%
    \includestandalone[#1]{#2}%
    \endgroup%
}

\floatplacement{figure}{t!}
\floatplacement{table}{t!}
\floatplacement{listing}{t!}

\RequirePackage {xfrac}

\RequirePackage [british,calc]{datetime2}
\DTMlangsetup[en-GB]{ord=raise}
\RequirePackage [autostyle,english=british]{csquotes}
\RequirePackage {caption,subcaption}
\RequirePackage {verse}

%\captionsetup[subfigure]{subrefformat=simple,labelformat=simple,listofformat=subsimple}
%\renewcommand\thesubfigure{(\alph{subfigure})}
\captionsetup{
    format        = hang,
%   justification = centerlast,
    font          = small,
    width         = .75\linewidth,
}
\captionsetup[listing]{skip=10pt}

% Load glossaries package and our custom glossaries style.
\RequirePackage[acronyms,shortcuts,hyperfirst=false,nomain,toc,section=section]{glossaries}
\RequirePackage{glossaries-UoB}

\newcommand\TODO{{\color{red}\bfseries TODO}}
\RequirePackage{flafter} % places floats after they are first mentioned if possible
\ifuob@uobthesis@print
    \RequirePackage [bookmarks=false]{hyperref}
\else
    \RequirePackage {hyperref}
\fi
%\RequirePackage {algorithm}
%\RequirePackage {algorithmicx}
%\RequirePackage {algpseudocode} 

\RequirePackage{pgfplotstable}
\pgfplotsset{compat=newest}
\usetikzlibrary{external,arrows,calc,positioning}
\ifluatex
%\tikzset{external/system call={lualatex \tikzexternalcheckshellescape -shell-escape -halt-on-error -interaction=batchmode -jobname "\image" "\texsource"}}
\fi
%\tikzexternalize[prefix=figures/]

\KOMAoptions{
    fontsize      = 12pt,
    numbers       = noendperiod,
    parskip       = half*,
    twoside       = semi,
    %draft,
    captions      = tableheading,
%   toc           = listofnumbered,
    listof        = leveldown,
    listof        = totoc,
    chapterprefix = true,
    DIV           = 11,
%   BCOR          = 7mm,
    titlepage     = firstiscover,
    footinclude   = false,
    headinclude   = false,
    singlespacing = true,       % make sure page style are always in singlespace
}
\recalctypearea

\ofoot[]{}
\cfoot[\pagemark]{\pagemark}
\pagestyle{scrheadings}
\def\@dotsep{3}
\setuptoc{toc}{numbered}
%\setcounter{secnumdepth}{3}

% customize dictum format:
\setkomafont{dictumtext}{\itshape\small}
\setkomafont{dictumauthor}{\normalfont}
\renewcommand*\dictumwidth{.8\linewidth}
\renewcommand*\dictumauthorformat[1]{--- #1}
\renewcommand*\dictumrule{}

%\ifuob@uobthesis@print\else
%\renewcommand*{\hyxmp@pdfa@id@schema}{%
%  \ifHy@pdfa
%    \hyxmp@add@to@xml{%
%______<rdf:Description rdf:about=""^^J%
%____________xmlns:pdfaid="http://www.aiim.org/pdfa/ns/id/">^^J%
%    }%
%    \hyxmp@add@simple{pdfaid:part}{2}%
%    \hyxmp@add@simple{pdfaid:conformance}{B}%
%    \hyxmp@add@to@xml{%
%______</rdf:Description>^^J%
%    }%
%  \fi
%}
%\fi

{
    \DTMsetstyle{pdf}
    \ifx\@submitted\@empty
        \protected@edef\uob@pdfdate{\today 120000}
    \else
        \protected@edef\uob@pdfdate{\DTMdate{\@submitted}120000}
    \fi
}
\hypersetup {
    hidelinks,
    breaklinks,
    linktocpage        = true,
    unicode            = true,
%   hyperfootnotes     = true,
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    pdfdisplaydoctitle = true,
%   pdfpagelabels      = false,
    plainpages         = false,
%   pdfusetitle,
    pdfauthor          = {\@author},
    pdftitle           = {\@title},
    pdfsubject         = {PhD Thesis},
    pdfkeywords        = {},
    pdflang            = en-GB,
    pdfencoding        = auto,
    pdfduplex          = DuplexFlipLongEdge,
    pdfprintscaling    = None,
%   draft,
%   pdflicenseurl      = {http://creativecommons.org/licenses/by-nc-nd/4.0/},
%   pdfcopyright       = {Copyright (C) 2015, Emma L. Tonkin},
%    pdfinfo            = {
%        CreationDate    = {\uob@pdfdate},
%    }
}
\ifuob@uobthesis@print\hypersetup{draft}\fi

\ifuob@uobthesis@print\else
\bookmarksetup{%
    open,
    addtohook={%
        \ifnum\bookmarkget{level}=0 %chapter
            \bookmarksetup{bold}
        \fi
%       \ifnum\bookmarkget{level}=1 %section
%           \bookmarksetup{}
%       \fi
        \ifnum\bookmarkget{level}=2 %subsection
            \bookmarksetup{italic}
        \fi
%       \ifnum\bookmarkget{level}=3 %subsubsection
%           \bookmarksetup{italic}
%       \fi
    }
}
\fi
\ifuob@uobthesis@cclicense
\RequirePackage[
    type          = {CC},
    modifier      = {by-nc-nd},
    imagemodifier = {-eu-88x31},
    imagewidth    = {8em},
    version       = {4.0},
]{doclicense}
\fi

\sisetup{
%   group-separator = {,},
    group-digits = integer,
    detect-all   = true,
    range-units  = single,
}
\ifluatex
    \sisetup{
        number-text-rm = \liningroman,
        unit-text-rm   = \liningroman,
        text-rm        = \liningroman,
    }
\fi


\RequirePackage[backend=biber,natbib=true]{biblatex}
\ExecuteBibliographyOptions{
    sorting      = none,
    backref      = true,
    alldates     = comp,
    giveninits   = true,
    uniquename   = init,
%   dashed       = false,
    maxnames     = 1,
    minnames     = 1,
    maxbibnames  = 4,
    minbibnames  = 2,
    ibidtracker  = true,
    block        = space,
    eprint       = false,
    defernumbers = true,
}
\DeclareNameAlias{default}{family-given}
\setcounter{biburlnumpenalty}{100}
\addto\bibfont{\smaller} % makes bibliography font smalled as per typography guidelines
\DeclareSourcemap{
  \maps[datatype=bibtex]{
     \map{
        \step[fieldsource=doi,final]
        \step[fieldset=url,null]
        }
      }
}
% The following definition is copied from authortitle.bbx/authoryear.bbx
%\defbibenvironment{nolabelbib}
%  {\list
%     {}
%     {\setlength{\leftmargin}{\bibhang}%
%      \setlength{\itemindent}{-\leftmargin}%
%      \setlength{\itemsep}{\bibitemsep}%
%      \setlength{\parsep}{\bibparsep}}}
%  {\endlist}
%  {\item}
%\setlength{\oddsidemargin}{0.9in}
%\setlength{\evensidemargin}{0in}

%\ifluatex\RequirePackage{realscripts}\fi
% Add accessibility functions with pdf (>v1.5)
\RequirePackage {accsupp}
% declare function to hide text from selection in pdf, used for the draft
% watermark and linenos in listing
\DeclareRobustCommand\squelch[1]{%
  \BeginAccSupp{method=plain,ActualText={}}#1\EndAccSupp{}%
}


%\renewcommand{\em}{\itshape}
%\newcommand*\ac[1]{\textsmaller{#1}}
%\AtBeginEnvironment{tabu}{%
%  \liningroman}
 %\addfontfeature{Numbers={Monospaced,Lining}}
 %}

\ifx\uob@uobthesis@minted {
    \RequirePackage {minted}
    \BeforeBeginEnvironment{minted}{\begin{singlespace}}
    \AfterEndEnvironment{minted}{\end{singlespace}}
    \renewcommand{\theFancyVerbLine}{
    \ifluatex
        %\fontspec[Numbers = {Lining,Monospaced}]{Libertinus Serif}
        \addfontfeature{Numbers={Monospaced,Lining}, RawFeature = {+case}}
    \fi
    \color[rgb]{0.5,0.5,0.5}\scriptsize\squelch{\arabic{FancyVerbLine}}
    }

    \usemintedstyle{bw}

    \setminted{
        frame        = lines,
        framesep     = 2mm,
        linenos      = true,
        numbersep    = 5pt,
    %   gobble       = 2,
        fontsize     = \footnotesize,
        xleftmargin  = 20pt,
        xrightmargin = 20pt,
        tabsize      = 3
    }
}
\fi

\g@addto@macro{\UrlBreaks}{\UrlOrds}
\g@addto@macro\UrlSpecials{%
  \do\`{\mbox{\UrlFont\char`\`}}%
  \do\'{\mbox{\UrlFont\char`\'}}%
  \do\"{\mbox{\UrlFont\char`\"}}%
  \do\l{\mbox{\UrlFont\char`\l}}%
  \do\0{\mbox{\UrlFont\char`\0}}%
}

%\patchcmd{\@afterheading}%
%    {\clubpenalty \@M}{\clubpenalties 3 \@M \@M 0}{}{}
%\patchcmd{\@afterheading}%
%    {\clubpenalty \@clubpenalty}{\clubpenalties 2 \@clubpenalty 0}{}{}
%

\let\slashold\slash
\def\slash{\texorpdfstring{\slashold }{/}}

% to allow multiple consecutive footnotes
% as described in http://tex.stackexchange.com/a/62091/24263
\let\oldFootnote\footnote
\newcommand\nextToken\relax

\renewcommand\footnote[1]{%
    \oldFootnote{#1}\futurelet\nextToken\isFootnote}

\newcommand\isFootnote{%
    \ifx\footnote\nextToken\textsuperscript{,}\fi}
%

\let\oldfrontmatter\frontmatter
\renewcommand\frontmatter{\oldfrontmatter \singlespacing}
%% Main Matter spacing
\let\oldmainmatter\mainmatter
\ifcase\uobthesis@spacing
    % single
    \renewcommand\mainmatter{\oldmainmatter \singlespacing}
\or
    % onehalf
    \renewcommand\mainmatter{\oldmainmatter \onehalfspacing}
\or
    % double
    \renewcommand\mainmatter{\oldmainmatter \doublespacing}
\else
    \renewcommand\mainmatter{\oldmainmatter \doublespacing}
\fi
\let\oldappendix\appendix
\renewcommand\appendix{\oldappendix \singlespacing}
\let\oldbackmatter\backmatter
\renewcommand\backmatter{\oldbackmatter \singlespacing}

\setlength{\uobtitlecoverwidth}{\textwidth}

%{{{ Definition of UoB Colours
% Primary brand colours
\definecolor{UoBRed}{cmyk}{0,.91,.72,.23}
\definecolor{UoBCoolGrey}{cmyk}{.07,.91,.72,.23}

% Secondary Colours
% Bright Colours
\definecolor{UoBBrightAqua}{cmyk}{.81,0,.36,0}
\definecolor{UoBBrightBlue}{cmyk}{.69,0,.13,0}
\definecolor{UoBBrightOrange}{cmyk}{0,.65,.95,0}
\definecolor{UoBBrightPurple}{cmyk}{.53,.61,0,0}
\definecolor{UoBBrightPink}{cmyk}{.04,.88,0,0}
\definecolor{UoBBrightLime}{cmyk}{.34,0,1.00,0}
% Dark Colours
\definecolor{UoBDarkAqua}{cmyk}{1,.17,.33,.66}
\definecolor{UoBDarkBlue}{cmyk}{1,.70,.08,.54}
\definecolor{UoBDarkOrange}{cmyk}{.13,.83,1.,.62}
\definecolor{UoBDarkPurple}{cmyk}{.81,1.0,.06,.35}
\definecolor{UoBDarkPink}{cmyk}{.33,1.0,.09,.45}
\definecolor{UoBDarkLime}{cmyk}{.58,.09,.95,.64}
%}}}

%{{{ Definition of maketile
\renewcommand{\maketitle}{%
    \ifuob@uobthesis@notitle \else
    %{{{ Title page
    \begin{titlepage}
        \setlength{\parindent}{\z@}
        \setlength{\parskip}{\z@}
        \enlargethispage{17mm}

% Title
        \centering
        \vglue 3cm 

        \begin{varwidth}{\uobtitlecoverwidth}
            \centering
            \usekomafont{title}\@title
        \end{varwidth}

        \vskip 2cm
        {\usekomafont{author}\@author}
%
%
%% University Crest
        \ifcase\uobthesis@logo
        \or
            \vskip \fill
            {\centering\includegraphics[width=5cm]{Images/Bristol-uni-logo-colour}}
        \or
            \vskip \fill
            {\centering\includegraphics[width=2.5cm]{Images/Bristol-uni-crest-colour}}
        \else
        \fi
        \vskip \fill

%% Declaration
        \begin{varwidth}{.8\textwidth}
            \centering
            \uob@front@declaration@text
        \end{varwidth}

% Date of submission
        \vskip 1cm
        {\usekomafont{submitted}\DTMlangsetup{showdayofmonth=false}%
            \ifx\@submitted\@empty
                \DTMtoday
            \else
                \DTMdate{\@submitted}
            \fi
        }

        \vskip 3cm
        \ifx\@wordcount\@empty
            \mbox{}
        \else 
            {\usekomafont{wordcount}\raggedleft Word count: \num{\@wordcount} words\par}
            %%\input{wordcount/wordcount} words
        \fi
    \end{titlepage}
    %}}}

    %{{{ License/colophon
% Placing CC license if requested on verso of titlepage
    \ifuob@uobthesis@cclicense
        \newpage
        \enlargethispage{2cm}
        \thispagestyle{empty}
        \vglue \fill
        \doclicenseThis
    \fi
    %}}}

    %{{{ Dedication
    \ifx\@dedication\@empty \else
        \cleardoublepage
        \thispagestyle{empty}
        \null \vspace{\stretch{1}}
        {\raggedleft
        \usekomafont{dedication}\@dedication\par}
        \vspace{\stretch{2}}
        \cleardoublepage
    \fi
    %}}}

    %{{{ Abstract
%
% Abstract
%
    \ifx\@abstract\@empty \else {
        \chapter{Abstract}

        \@abstract
    }
    \fi
    %}}}

    %{{{ Author's Declaration
% Taken from the PGR code annex 4: http://www.bristol.ac.uk/academic-quality/pg/pgrcode/annex4/
\chapter{Author's Declaration}

\begingroup
\KOMAoption{parskip}{half*}
\uob@author@declaration@text

\vskip 10mm
\@author
\vskip 15mm

\makebox[.49\textwidth]{\textsc{signed}:~\dotfill}%
\hspace{.02\textwidth}%
\makebox[.49\textwidth]{\textsc{date}:~\dotfill}
\endgroup

\cleardoublepage
% End of author's declaration
    %}}}

%{{{ Acknowledgements
% Place acknowledgements in its own chapter if it is defined
\ifx\@acknowledgements\@empty \else {
    \chapter{Acknowledgements}

    \@acknowledgements\par
}
\fi
%}}}
    \fi
}
%}}}

%{{{ Chapter title formating
%
% Chapter title formatting
%
\renewcommand*{\chapterformat}{%
    \mbox{\liningnums{\thechapter}}%
}
\renewcommand*{\chapterheadmidvskip}{}

\renewcommand\chapterlinesformat[3]{%
\begin{singlespace}
    \parskip=0pt%
    \lineskip=0pt%
    \parindent=0pt%
    \topskip=0pt%
    \baselineskip=0pt%
    
    \begin{tikzpicture}[
        remember picture,
        every node/.style = {
            inner sep = 0,
            outer sep = 0,
            },
        chptnum/.style = {
 %           draw,
 %           color = white,
            text = gray,
            fill = white,
            overlay,
            anchor = south east,
            },
        ]
        \node[text width=\textwidth, inner xsep=0, inner ysep=13, anchor=north west] (chaptertitle) at (0,0) {\vphantom{j}#3};
        \draw[thick,overlay] (chaptertitle.north west) -- (chaptertitle.north east);
        \draw[thick,overlay] (chaptertitle.south west) -- (chaptertitle.south east);
        \Ifstr{#2}{}{}{
            \node[chptnum] (chapternumber) at ($(chaptertitle.north east) - (0,.5pt)$) {\resizebox{!}{55pt}{#2}};
            \IfChapterUsesPrefixLine{%
                \node[rotate=90,overlay,inner ysep=5pt, fill=white, anchor= south] (chaptername) at (chapternumber.west) {\resizebox{56pt}{!}{\chapapp}};
            }{%
                \draw[line width=5pt, white, overlay] ($(chapternumber.south west) - (2.5pt,0)$) -- ($(chapternumber.north west) - (2.5pt,0)$);
            }
        }
    \end{tikzpicture}
\end{singlespace}
}

\let\chapterlineswithprefixformat\chapterlinesformat

\RedeclareSectionCommand[afterskip=20pt, beforeskip=5cm, innerskip=0pt]{chapter}
%
% End of Chapter title formatting
%
%}}}

\setkomafont{disposition}{\sffamily\mdseries}
\addtokomafont{chapterentry}{\bfseries}
\addtokomafont{paragraph}{\bfseries}

\setcounter{secnumdepth}{\subsubsectionnumdepth}

\RedeclareSectionCommand[
  beforeskip=-1.5ex plus -.5ex minus -.5ex,
  afterskip=1ex plus .1ex,
  ]{section}

\RedeclareSectionCommands[
  beforeskip=-1ex plus -.5ex minus -.5ex,
  afterskip=.5ex plus .1ex,
  ]{subsection,subsubsection}

\RedeclareSectionCommands[
  beforeskip=-1ex plus -.5ex minus -.5ex,
  afterskip=-1em,
  ]{paragraph,subparagraph}

\ifcase\uobthesis@secnumpos
    % margin
    \newcommand*\marginnumber[1]{\makebox[0pt][r]{#1\autodot\hspace{10pt}}}
    \renewcommand*{\sectionformat}{\marginnumber{\thesection}}
    \renewcommand*{\subsectionformat}{\marginnumber{\thesubsection}}
    \renewcommand*{\subsubsectionformat}{\marginnumber{\thesubsubsection}}
\or
    % text (do nothing)
\else
    % else (do nothing)
\fi

% vim: ft=tex ts=4 sw=4 et
% vim600: fdl=0 fdm=marker fdc=3 spl=en_gb spell
