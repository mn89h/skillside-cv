%% start of file `skillside-cv.cls'.
%% Copyright 2024 Malte Nilges.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License version 1.3c,
% available at http://www.latex-project.org/lppl/.
% This file is a modified version of the original package 'moderncv', made by Xavier Danaux 2012.
% This package adds document options, packages, font options and commands for a revamped CV look  


%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skillside-cv}[2024/09/01 v1.0 skillside curriculum vitae]

%-------------------------------------------------------------------------------
%                class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
\RequirePackage{xkeyval}
\newcommand\leftcolumnwidthmult{0.3}
\DeclareOptionX{leftcolumnwidthmult}[0.3]{\renewcommand\leftcolumnwidthmult{#1}}

\newlength{\seperatorwidth}
\setlength{\seperatorwidth}{0.5in}
\DeclareOptionX{seperatorwidth}[0.5in]{\setlength{\seperatorwidth}{#1}}

\newcommand\cvlanguage{english}
\DeclareOptionX{language}[english]{\renewcommand\cvlanguage{#1}}
\ProcessOptionsX

% paper size option
\DeclareOption{a4paper}{
  \setlength\paperheight{297mm}
  \setlength\paperwidth{210mm}}
\DeclareOption{a5paper}{
  \setlength\paperheight{210mm}
  \setlength\paperwidth{148mm}}
\DeclareOption{b5paper}{
  \setlength\paperheight{250mm}
  \setlength\paperwidth{176mm}}
\DeclareOption{letterpaper}{
  \setlength\paperheight{11in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{legalpaper}{
  \setlength\paperheight{14in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{executivepaper}{
  \setlength\paperheight{10.5in}
  \setlength\paperwidth{7.25in}}
\DeclareOption{landscape}{
  \setlength\@tempdima{\paperheight}
  \setlength\paperheight{\paperwidth}
  \setlength\paperwidth{\@tempdima}}

% font size options
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

% font type options


% \setmainfont{Bahnschrift.ttf}
\DeclareOption{sans}{\AtBeginDocument{\renewcommand{\familydefault}{\sfdefault}}}
\DeclareOption{roman}{\AtBeginDocument{\renewcommand{\familydefault}{\rmdefault}}}
% \DeclareOption{times}{\AtBeginDocument{\usepackage{times}\fontfamily{ptm}\selectfont}}
\DeclareOption{overpass}{\AtBeginDocument{
    \defaultfontfeatures{RawFeature={+axis={wght=400}}}
    \setmainfont{Overpass-VariableFont_wght}[
    Path = fonts/,
    Extension = .ttf,
    ItalicFont=Overpass-Italic-VariableFont_wght,
    BoldFont=Overpass-VariableFont_wght,
    BoldFeatures={RawFeature={+axis={wght=600}}},
    BoldItalicFeatures={RawFeature={+axis={wght=600}}}
    ]}}
% \DeclareOption{times}{\AtBeginDocument{\setmainfont{Overpass-Regular.ttf}}}

% draft/final option
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

% execute default options
\ExecuteOptions{a4paper,11pt,final}

% process given options
\ProcessOptions\relax
\input{size1\@ptsize.clo}

\usepackage[margin=.5in]{geometry}


%-------------------------------------------------------------------------------
%                required packages
%-------------------------------------------------------------------------------



% \AtEndPreamble hook (loading etoolbox instead of defining the macro, as to avoid incompatibilities with etoolbox (and packages relying on it) defining the macro too)
\RequirePackage{etoolbox}
%\let\@endpreamblehook\@empty
%\def\AtEndPreamble{\g@addto@macro\@endpreamblehook}
%\let\document@original\document
%\def\document{\endgroup\@endpreamblehook\begingroup\document@original}

% if... then... else... constructs
\RequirePackage{ifthen}
% TODO: move to xifthen and \isempty{<arg>} instead of \equal{<arg>}{}

% color
\RequirePackage{xcolor}

% colorbar
\RequirePackage{paracol}
\RequirePackage{lipsum}
\RequirePackage{eso-pic}

% font loading
\usepackage{ifxetex,ifluatex}
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
% automatic loading of latin modern fonts
\ifxetexorluatex
 \RequirePackage{fontspec}
 \defaultfontfeatures{Ligatures=TeX}
 \RequirePackage{unicode-math}
 % \setmainfont{bahnschrift.ttf}
 % \setsansfont{Latin Modern Sans}
 % \setmathfont{Latin Modern Math}
\else
  \RequirePackage[T1]{fontenc}
  \IfFileExists{lmodern.sty}%
    {\RequirePackage{lmodern}}%
    {}
\fi

\RequirePackage{twemojis}
\RequirePackage{fontawesome5}
% MarVoSym font for symbols
%\RequirePackage{marvosym}
\newcommand*{\marvosymbol}[1]{}
%\ifxetexorluatex
%  \renewcommand*{\marvosymbol}[1]{{\fontspec{MarVoSym}\char#1}}
%\else
  \renewcommand*{\marvosymbol}[1]{{\fontfamily{mvs}\fontencoding{U}\fontseries{m}\fontshape{n}\selectfont\char#1}}
%\fi

% hyper links (hyperref is loaded at the end of the preamble to pass options required by loaded packages such as CJK)
\RequirePackage{url}
\urlstyle{tt}
\AtEndPreamble{
  \pagenumbering{arabic}% has to be issued before loading hyperref, as to set \thepage and hence to avoid hyperref issuing a warning and setting pdfpagelabels=false
  \RequirePackage[unicode]{hyperref}% unicode is required for unicode pdf metadata
  \hypersetup{
    breaklinks,
    baseurl       = http://,
    pdfborder     = 0 0 0,
    pdfpagemode   = UseNone,% do not show thumbnails or bookmarks on opening
    pdfstartpage  = 1,
    pdfcreator    = {\LaTeX{} with 'cv' package},
%    pdfproducer   = {\LaTeX{}},% will/should be set automatically to the correct TeX engine used
    bookmarksopen = true,
    bookmarksdepth= 2,% to show sections and subsections
    pdfauthor     = {\@firstname{}~\@familyname{}},
    pdftitle      = {\@firstname{}~\@familyname{} -- \@title{}},
    pdfsubject    = {Resum\'{e} of \@firstname{}~\@familyname{}},
    pdfkeywords   = {\@firstname{}~\@familyname{}, curriculum vit\ae{}, resum\'{e}}}}

% graphics
\RequirePackage{graphicx}

% headers and footers
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}}
% page numbers in footer if more than 1 page
\newif\if@displaypagenumbers\@displaypagenumberstrue
\newcommand*{\nopagenumbers}{\@displaypagenumbersfalse}
\AtEndPreamble{%
  \AtBeginDocument{%
    \if@displaypagenumbers%
      \@ifundefined{r@lastpage}{}{%
        \ifthenelse{\pageref{lastpage}>1}{%
          \newlength{\pagenumberwidth}%
          \settowidth{\pagenumberwidth}{\color{color2}\addressfont\itshape\strut\thepage/\pageref{lastpage}}%
          \fancypagestyle{plain}{%
            \fancyfoot[r]{\parbox[b]{\pagenumberwidth}{\color{color2}\addressfont\itshape\strut\thepage/\pageref{lastpage}}}}% the parbox is required to ensure alignment with a possible center footer (e.g., as in the casual style)
          \pagestyle{plain}}{}}%
      \AtEndDocument{\label{lastpage}}\else\fi}}
\pagestyle{plain}

% lengths calculations
\RequirePackage{calc}

% advanced command arguments (LaTeX 3)
\RequirePackage{xargs}
% TODO (?): replace all \newcommand by \NewDocumentCommand

% micro-typography (e.g., character protrusion, font expansion, hyphenatable letterspacing)
\RequirePackage{microtype}

% tikz
\RequirePackage{tikz}

% array
\RequirePackage{array}

\def\Plus{\texttt{+}}

%-------------------------------------------------------------------------------
%                class definition
%-------------------------------------------------------------------------------
% minimal base settings
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength{\parindent}{0\p@}
\setlength{\parskip}{0\p@}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}

% not set on purpose
%\setlength\arraycolsep{5\p@}
%\setlength\tabcolsep{6\p@}
%\setlength\tabbingsep{\labelsep}

\raggedbottom
\onecolumn


%-------------------------------------------------------------------------------
%                overall design commands definitions
%-------------------------------------------------------------------------------
% elements
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\familyname}[1]{\def\@familyname{#1}}
\renewcommand*{\title}[1]{\def\@title{#1}}
\newcommand*{\address}[2]{\def\@addressstreet{#1}\def\@addresscity{#2}}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}
\newcommand*{\phone}[1]{\def\@phone{#1}}
\newcommand*{\fax}[1]{\def\@fax{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\carlicense}[1]{\def\@carlicense{#1}}
\newcommand*{\linkedin}[2]{\def\@linkedin{#1}\def\@linkedintitle{#2}}
\newcommand*{\git}[2]{\def\@git{#1}\def\@gittitle{#2}}

% colors
\definecolor{color0}{rgb}{0,0,0}% main default color, normally left to black
\definecolor{color1}{rgb}{0,0,0}% primary theme color
\definecolor{color2}{rgb}{0,0,0}% secondary theme color
\definecolor{color3}{rgb}{0,0,0}% tertiary theme color

% symbols
%   itemize labels (the struts were added to correct inter-item spacing (works for single line items, until a solution is found for multi-line ones...)
\newcommand*{\labelitemi}{\strut\textcolor{color1}{\marvosymbol{123}}}% equivalent to \Neutral from marvosym package; alternative: \fontencoding{U}\fontfamily{ding}\selectfont\tiny\symbol{'102}
\newcommand*{\labelitemii}{\strut\textcolor{color1}{\large\bfseries-}}
\newcommand*{\labelitemiii}{\strut\textcolor{color1}{\rmfamily\textperiodcentered}}% alternative: \textasteriskcentered; the \rmfamily is required to force Latin Modern fonts when using sans serif, as OMS/lmss/m/n is not defined and gets substituted by OMS/cmsy/m/n
\newcommand*{\labelitemiv}{\labelitemiii}
%   enumerate labels
\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
%   other symbols
\newcommand*{\listitemsymbol}{\labelitemi~}
\newcommand*{\addresssymbol}{}
\newcommand*{\mobilesymbol}{}
\newcommand*{\phonesymbol}{}
\newcommand*{\faxsymbol}{}
\newcommand*{\emailsymbol}{}
\newcommand*{\carsymbol}{}
\newcommand*{\linkedinsymbol}{}
\newcommand*{\gitsymbol}{}

% fonts
\AtBeginDocument{\normalfont\color{color0}}

% strings for internationalisation
\newcommand*{\refname}{Publications}
\newcommand*{\enclname}{Enclosure}

% makes the footer (normally used both for the resume and the letter)
% usage: \makefooter
\newcommand*{\makefooter}{}%
  
% loads a style/color scheme
\newcommand*{\addstyle}[1]{
  \RequirePackage{skillside-cv-#1}}

% recomputes all automatic lengths
\newcommand*{\recomputelengths}{\recomputecvlengths}
\AtBeginDocument{\recomputelengths{}}

% creates a length if not yet defined
\newcommand*{\@initializelength}[1]{%
  \ifdefined#1\else\newlength{#1}\fi}


%-------------------------------------------------------------------------------
%                resume design commands definitions
%-------------------------------------------------------------------------------
% elements
\newcommand*{\extrainfo}[1]{\def\@extrainfo{#1}}
\newcommandx*{\photo}[3][1=64pt,2=0.4pt,usedefault]{\def\@photowidth{#1}\def\@photoframewidth{#2}\def\@photo{#3}}% the 1st (optional) argument is the width of the photo, the 2nd (optional) argument is the thickness of the frame around it.
\newcommand*{\quote}[1]{\def\@quote{#1}}

% fonts
\newcommand*{\namefont}{}
\newcommand*{\titlefont}{}
\newcommand*{\addressfont}{}
\newcommand*{\quotefont}{}
\newcommand*{\sectionfont}{}
\newcommand*{\subsectionfont}{}
\newcommand*{\hintfont}{}

% styles
\newcommand*{\namestyle}[1]{{\namefont#1}}
\newcommand*{\titlestyle}[1]{{\titlefont#1}}
\newcommand*{\addressstyle}[1]{{\addressfont#1}}
\newcommand*{\quotestyle}[1]{{\quotefont#1}}
\newcommand*{\sectionstyle}[1]{{\sectionfont#1}}
\newcommand*{\subsectionstyle}[1]{{\subsectionfont#1}}
\newcommand*{\hintstyle}[1]{{\hintfont#1}}

% recompute all resume lengths
\newcommand*{\recomputecvlengths}{}


% internal maketitle command to issue a new line only when required
\newif\if@firstdetailselement\@firstdetailselementtrue
\newcommand*{\makenewline}{
  \if@firstdetailselement%
    \strut% to ensure baseline alignment, e.g. with when put in the margin vs sections that also contains a \strut
  \else%
    \\\fi%
  \@firstdetailselementfalse}

% makes the resume title
% usage: \makecvtitle
\newcommand*{\makecvheader}{}

% makes the resume title
% usage: \makecvtitle
\newcommand*{\makecvinfo}

% makes the resume footer
% usage: \makecvfooter
\newcommand*{\makecvfooter}{\makefooter}

% makes a resume section
% usage: \section{<title>}
\newcommand*{\section}[1]{}
% starred variant, which is identical but defined to allow its use (e.g. for natbib compatibility, who uses \section*{} for the bibliography header)
\RequirePackage{suffix}
\AtBeginDocument{\WithSuffix\newcommand\section*{\section}}

% makes a resume subsection
% usage: \subsection{title}
\newcommand*{\subsection}[1]{}
\AtBeginDocument{\WithSuffix\newcommand\subsection*{\subsection}}

% makes a resume line with a header and a corresponding text
% usage: \cvitem[spacing]{header}{text}
\newcommand*{\cvitem}[3][.25em]{}

% makes a resume line 2 headers and their corresponding text
% usage: \cvdoubleitem[spacing]{header1}{text1}{header2}{text2}
\newcommand*{\cvdoubleitem}[5][.25em]{}

% makes a resume line with a list item
% usage: \cvlistitem[label]{item}
\newcommand*{\cvlistitem}[2][\listitemsymbol]{}

% makes a resume line with 2 list items
% usage: \cvlistdoubleitem[label]{item1}{item2}
\newcommand*{\cvlistdoubleitem}[3][\listitemsymbol]{}

% makes a typical resume job / education entry
% usage: \cventry[spacing]{years}{degree/job title}{institution/employer}{localization}{optionnal: grade/...}{optional: comment/job description}
\newcommand*{\cventry}[7][.25em]{}

% makes a resume entry with a proficiency comment
% usage: \cvitemwithcomment[spacing]{header}{text}{comment}
\newcommand*{\cvitemwithcomment}[4][.25em]{}

% makes a generic hyperlink
% usage: \link[optional text]{link}
\newcommand*{\link}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\href{#2}{#2}}%
    {\href{#2}{#1}}}

% makes a http hyperlink
% usage: \httplink[optional text]{link}
\newcommand*{\httplink}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\href{https://#2}{#2}}%
    {\href{https://#2}{#1}}}

% makes an email hyperlink
% usage: \emaillink[optional text]{link}
\newcommand*{\emaillink}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\href{mailto:#2}{#2}}%
    {\href{mailto:#2}{#1}}}

% thebibliography environment, for use with BibTeX and possibly multibib
\newlength{\bibindent}
\setlength{\bibindent}{1.5em}
% bibliography item label
\newcommand*{\bibliographyitemlabel}{}% use \@biblabel{\arabic{enumiv}} for BibTeX labels
%\newif\if@multibibfirstbib\@multibibfirstbibfalse
% bibliography head (section, etc}, depending on whether multibib is used
\newcommand*{\bibliographyhead}[1]{\section{#1}}
\AtEndPreamble{\@ifpackageloaded{multibib}{\renewcommand*{\bibliographyhead}[1]{\subsection{#1}}}{}}
% thebibliography environment definition
\newenvironment{thebibliography}[1]{}{}
\newcommand*{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty

\newenvironment{cvtworow}{}{}

\newenvironment{skills}[1]{}{}

%SKILL DOTS
\newcommand{\skilldots}[2]{}{}


\endinput


%% end of file `skillside-cv.cls'.