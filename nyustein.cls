\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{nyustein}[2015/11/11 NYU Steinhardt Music dissertation.]

% moredefs is a required package but the following commands are also defined in
% memoir, causing a conflict, hence this patch.
\RequirePackage{moredefs}
\let\providelength\relax
\let\providecounter\relax

% nyustein is based on the memoir class.
\LoadClass[letterpaper, 11pt, oneside]{memoir}

% Graphics packages.
\RequirePackage{graphicx}

% Required to implement the conditional TOC etc. footnotes.
\RequirePackage{zref}
\RequirePackage{changepage}

% Length calculations for the chapter and section heading design.
\RequirePackage{pgf}
\pgfmathsetlengthmacro{\tl}{0.65in-\topskip-\baselineskip}
\pgfmathsetlengthmacro{\tll}{\baselineskip+.05in}
\pgfmathsetlengthmacro{\tlll}{\baselineskip-0.265in}

% pdfLaTeX with UTF-8 (Unicode) encoding enabled.
\RequirePackage[russian, greek, french, german, american]{babel}
\RequirePackage[T2A, LGR, T1]{fontenc}
\RequirePackage[utf8]{inputenc}

% Miscellaneous facilities for prose writing.
\RequirePackage[autostyle=true, english=american, french=guillemets, german=guillemets]{csquotes}
\RequirePackage{lipsum}
\RequirePackage{lips}
\RequirePackage{enumitem}
\RequirePackage[noorphans=true, indentfirst=false, leftmargin=0.5in, rightmargin=0in, vskip=\tlll]{quoting}
\RequirePackage{parallel}
\RequirePackage[normalem]{ulem}
\RequirePackage{hyphenat}

% Use todonotes for annotations, comments, reminders, etc.
\RequirePackage[textsize=tiny]{todonotes}

% Bibliography.
\RequirePackage[notes, strict, autolang=hyphen, doi=only, backend=biber, bibencoding=utf8, backref=true]{biblatex-chicago}

% Page layout.
\settypeblocksize{8.5in}{5.5in}{*}
\setlrmargins{1.5in}{*}{*}
\setulmargins{1.25in}{*}{*}
\settrims{0pt}{0pt}
\checkandfixthelayout
\fixpdflayout

% Regular text page style.
\pagestyle{plain}

% Double spacing for body text.
\AfterEndPreamble{\DoubleSpacing}

% Paragraph indentation.
\setlength\parindent{0.5in}

% Do not number sections or lower-level divisions.
\setsecnumdepth{chapter}

% Chapter heading style.
\makeatletter
\makechapterstyle{nyustein}{
        \renewcommand*{\chapnamefont}{\normalsize\normalfont\upshape}
        \renewcommand*{\chaptitlefont}{\normalsize\normalfont\upshape}
        \renewcommand*{\printchaptername}{\MakeTextUppercase{\@chapapp}}
        \renewcommand*{\printchaptertitle}[1]{\chaptitlefont\SingleSpacing\centering{\MakeTextUppercase{##1}}}
        \renewcommand*{\printchapternum}{\centering{\thechapter}}
}
\makeatother
\chapterstyle{nyustein}
% Roman numerals for chapter numbering.
\renewcommand*{\thechapter}{\Roman{chapter}}
% Start the chapter heading 2in below top of page (assuming 11pt font).
% We patch the chapter command, otherwise we get a blank first page
% for some reason that I have no time to investigate.
\pretocmd{\chapter}{\setlength\beforechapskip{\tl}}{}{}
% Set distance between chapter heading and chapter title to one double space.
\pretocmd{\chapter}{\setlength\midchapskip{-0.075in}}{}{}
% Set distance between chapter title and following text to two double spaces.
\pretocmd{\chapter}{\setlength\afterchapskip{\baselineskip}}{}{}

% Section heading and lower-level heading styles.
% Sane writers should use no divisions below the section level,
% and definitely no consecutive headings without text in-between.
\setsecheadstyle{\normalfont\raggedright\SingleSpacing\em}
        \setbeforesecskip{-\tll}
        \setaftersecskip{0.00001in}
\setsubsecheadstyle{\normalfont\centering\SingleSpacing\em}
        \setbeforesubsecskip{-\tll}
        \setaftersubsecskip{0.00001in}
\setsubsubsecheadstyle{\normalfont\raggedright\SingleSpacing}
        \setbeforesubsubsecskip{-\tll}
        \setaftersubsubsecskip{0.00001in}
\setparaheadstyle{\normalfont\centering\SingleSpacing}
        \setbeforeparaskip{-\tll}
        \setafterparaskip{0.00001in}
\setsubparaheadstyle{\normalfont\SingleSpacing\em}
        \setaftersubparaskip{-1em}
        \setsubparaindent{-\parindent}

% Hide page number for title page.
\apptocmd{\maketitle}{\thispagestyle{empty}}{}{}

% Block quotations should be single-spaced. Subtract for exactly (and sadly)
% one double space before and after the block, per the specifications.
\BeforeBeginEnvironment{quoting}{\SingleSpacing}
\AfterEndEnvironment{quoting}{\DoubleSpacing}
\AfterEndEnvironment{quoting}{\vspace{0.07in}}

% Facilities for inline music typesetting.
\newcommand{\stufe}[1]{$\widehat{#1}$}  % Schenkerian scale degree (e.g. ^1).
\newcommand{\shp}{$\sharp$\ }
\newcommand{\flt}{$\flat$\ }
\newcommand{\nat}{$\natural$\ }
\newcommand{\m}[1]{m.\ #1}
\newcommand{\mm}[1]{mm.\ #1}
\newcommand{\mmb}[1]{mm.\ \mbox{#1}}
%% Macro for bass figures and chords.
\RequirePackage{amsmath}
\newcommand{\fb}[4]{%
\ifthenelse{\equal{#4}{}}{%
\ifthenelse{\equal{#3}{}}{%
{#1}{#2}}%
{\textrm{#1}\(\begin{smallmatrix}{#2}\\{#3}\end{smallmatrix}\)}}%
{\textrm{#1}\(\begin{smallmatrix}{#2}\\{#3}\\{#4}\end{smallmatrix}\)}}%

% Itemize and enumerate.
\AfterPreamble{\setlist[itemize]{nosep, label=\emph{\textendash}, listparindent=0.25in, leftmargin=0.38in, labelindent=0in, labelsep=0.10in}}
\AfterPreamble{\setlist[enumerate]{nosep, listparindent=0.25in, leftmargin=0.38in, labelindent=0in, labelsep=0.10in}}
\AfterPreamble{\setlist[enumerate,1]{label=\arabic*., ref=\arabic*)}}
\AfterPreamble{\setlist[enumerate,2]{label=\arabic*., ref=\arabic{enumi}.\arabic*)}}
\AfterPreamble{\setlist[enumerate,3]{label=\arabic*., ref=\arabic{enumi}.\arabic{enumii}.\arabic*)}}

% Floats.
%% Float positioning.
%%% General.
\RequirePackage{flafter} % Ensure that floats are not placed before declaration.
\RequirePackage[counterclockwise]{rotating} % Required to typeset wide floats in landscape orientation.
\captionwidth{11.45cm}\changecaptionwidth
\hangcaption
\hangsubcaption
%%% Examples.
\newfloat[chapter]{example}{lex}{Example}
\newsubfloat{example}
\setfloatlocations{example}{htbp}
\setfloatadjustment{example}{\centering}
%%%% Format of the example counter.
\makeatletter\renewcommand{\theexample}{
   \ifnum\c@chapter>\z@ \@arabic\c@chapter.\fi \@arabic\c@example}\makeatother
%%%% Declare List of Examples.
\newlistof{listofexamples}{lex}{List of Examples}
\makeatletter\let\l@example\l@figure\makeatother
%%% Tables.
\newsubfloat{table}
\setfloatlocations{table}{htbp}
\setfloatadjustment{table}{\centering}
%%%% Format of the table counter.
\makeatletter\renewcommand{\thetable}{%
   \ifnum\c@chapter>\z@ \@arabic\c@chapter.\fi \@arabic\c@table}\makeatother
%%% Figures.
\newsubfloat{figure}
\setfloatlocations{figure}{htbp}
\setfloatadjustment{figure}{\centering}
%%%% Format of the figure counter.
\makeatletter\renewcommand{\thefigure}{%
   \ifnum\c@chapter>\z@ \@arabic\c@chapter.\fi \@arabic\c@figure}\makeatother
%% Float counters should be continuous (not per-chapter).
\makeatletter
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{example}{chapter}
\renewcommand\@memfront@floats{}
\renewcommand\@memmain@floats{}
\renewcommand\@memback@floats{}
\makeatother
%% Shortcuts to float references.
\newcommand{\eref}[1]{Example~\ref{#1}}
\newcommand{\cref}[1]{Chapter~\ref{#1}}
\newcommand{\Nref}[1]{Note~\ref{#1}}
\newcommand{\nref}[1]{note~\ref{#1}}
\renewcommand{\tref}[1]{\tablerefname~\ref{#1}}
\renewcommand{\fref}[1]{\figurerefname~\ref{#1}}
\renewcommand{\pref}[1]{\pagerefname~\pageref{#1}}

% Title and footer formatting for the TOC and other such lists.
%% Fix TOC title.
\addto\captionsamerican{
  \renewcommand{\contentsname}{Table of Contents}
}

%% Create a custom page style for the TOC. Conditionally add "(continued)" in footer.
%% Warning: Dirty hack.
\copypagestyle{toc}{plain}
\makeevenfoot{toc}
             {}
             {\thepage}
             {\ifthenelse{\value{tocend}=0 \OR \value{tocend}>\value{page}}
                   {\vspace*{0.38in}Continued}{}}
\makeoddfoot{toc}
            {}
            {\thepage}
            {\ifthenelse{\value{tocend}=0  \OR \value{tocend}>\value{page}}
                   {\vspace*{0.38in}Continued}{}}
\renewcommand{\cfttocbeforelisthook}
             {\thispagestyle{toc}\pagestyle{toc}
             }
\newcounter{tocend}
\makeatletter
        \zref@newprop*{numpage}{\the\value{page}}
        \zref@addprop{main}{numpage}
        \renewcommand{\cfttocafterlisthook}
                     {\makeatletter
                      \zref@label{reftocend}
                      \setcounter{tocend}
                                {\zref@extractdefault{reftocend}{numpage}{1000}}
                      \makeatother
                      \clearpage
                      \pagestyle{plain}
                      }
\makeatother
%% Create a custom page style for the LEX. Conditionally add "(continued)" in footer.
%% Warning: Dirty hack.
\copypagestyle{lex}{plain}
\makeevenfoot{lex}
             {}
             {\thepage}
             {\ifthenelse{\value{lexend}=0 \OR \value{lexend}>\value{page}}
                   {\vspace*{0.38in}Continued}{}}
\makeoddfoot{lex}
            {}
            {\thepage}
            {\ifthenelse{\value{lexend}=0  \OR \value{lexend}>\value{page}}
                   {\vspace*{0.38in}Continued}{}}
\renewcommand{\cftlexbeforelisthook}
             {\thispagestyle{lex}\pagestyle{lex}
             }
\newcounter{lexend}
\makeatletter
        \renewcommand{\cftlexafterlisthook}
                     {\makeatletter
                      \zref@label{reflexend}
                      \setcounter{lexend}
                                {\zref@extractdefault{reflexend}{numpage}{1000}}
                      \makeatother
                      \clearpage
                      \pagestyle{plain}
                      }
\makeatother
%% Create a custom page style for the LOT. Conditionally add "(continued)" in footer.
%% Warning: Dirty hack.
\copypagestyle{lot}{plain}
\makeevenfoot{lot}
             {}
             {\thepage}
             {\ifthenelse{\value{lotend}=0 \OR \value{lotend}>\value{page}}
                   {\vspace*{0.38in}Continued}{}}
\makeoddfoot{lot}
            {}
            {\thepage}
            {\ifthenelse{\value{lotend}=0  \OR \value{lotend}>\value{page}}
                   {\vspace*{0.38in}Continued}{}}
\renewcommand{\cftlotbeforelisthook}
             {\thispagestyle{lot}\pagestyle{lot}
             }
\newcounter{lotend}
\makeatletter
        \renewcommand{\cftlotafterlisthook}
                     {\makeatletter
                      \zref@label{reflotend}
                      \setcounter{lotend}
                                {\zref@extractdefault{reflotend}{numpage}{1000}}
                      \makeatother
                      \clearpage
                      \pagestyle{plain}
                      }
\makeatother
%% Create a custom page style for the LOF. Conditionally add "(continued)" in footer.
%% Warning: Dirty hack.
\copypagestyle{lof}{plain}
\makeevenfoot{lof}
             {}
             {\thepage}
             {\ifthenelse{\value{lofend}=0 \OR \value{lofend}>\value{page}}
                   {\vspace*{0.38in}Continued}{}}
\makeoddfoot{lof}
            {}
            {\thepage}
            {\ifthenelse{\value{lofend}=0  \OR \value{lofend}>\value{page}}
                   {\vspace*{0.38in}Continued}{}}
\renewcommand{\cftlofbeforelisthook}
             {\thispagestyle{lof}\pagestyle{lof}
             }
\newcounter{lofend}
\makeatletter
        \renewcommand{\cftlofafterlisthook}
                     {\makeatletter
                      \zref@label{reflofend}
                      \setcounter{lofend}
                                {\zref@extractdefault{reflofend}{numpage}{1000}}
                      \makeatother
                      \clearpage
                      \pagestyle{plain}
                      }
\makeatother
%% Apply TOC & list page styles and margin settings. Adjust distance of their titles from upper margins.
\pretocmd{\tableofcontents}
         {\clearpage\thispagestyle{toc}\pagestyle{toc}
          \changepage{-0.33in}{}{}{}{}{}{}{}{0.33in}        % Make space for "continued" in footer.
          \begingroup
          \setlength{\beforechapskip}{0.31in}
          \SingleSpacing}{}{}
\apptocmd{\tableofcontents}{*\endgroup % Note that we hard-wire the asterisk so that the TOC does not include itself.
          \clearpage\pagestyle{plain}
          \changepage{0.33in}{}{}{}{}{}{}{}{-0.33in}        % Reclaim space allocated for "continued".
          \DoubleSpacing}{}{}
\pretocmd{\listofexamples}
         {\clearpage\thispagestyle{lex}\pagestyle{lex}
          \changepage{-0.33in}{}{}{}{}{}{}{}{0.33in}        % Make space for "continued" in footer.
          \begingroup
          \setlength{\beforechapskip}{0.31in}
          \SingleSpacing}{}{}
\apptocmd{\listofexamples}
         {\endgroup
          \clearpage\pagestyle{plain}
          \changepage{0.33in}{}{}{}{}{}{}{}{-0.33in}        % Reclaim space allocated for "continued".
          \DoubleSpacing}{}{}
\pretocmd{\listoftables}
         {\clearpage
          \changepage{-0.33in}{}{}{}{}{}{}{}{0.33in}        % Make space for "continued" in footer.
          \begingroup
          \setlength{\beforechapskip}{0.31in}
          \SingleSpacing}{}{}
\apptocmd{\listoftables}
         {\endgroup
          \clearpage\pagestyle{plain}
          \changepage{0.33in}{}{}{}{}{}{}{}{-0.33in}        % Reclaim space allocated for "continued".
          \DoubleSpacing}{}{}
\pretocmd{\listoffigures}
         {\clearpage
          \changepage{-0.33in}{}{}{}{}{}{}{}{0.33in}        % Make space for "continued" in footer.
          \begingroup
          \setlength{\beforechapskip}{0.31in}
          \SingleSpacing}{}{}
\apptocmd{\listoffigures}
         {\endgroup
          \clearpage\pagestyle{plain}
          \changepage{0.33in}{}{}{}{}{}{}{}{-0.33in}        % Reclaim space allocated for "continued".
          \DoubleSpacing}{}{}

% Format content of TOCs and other such lists.
%% Include subsections but no lower-level divisions in the TOC.
\settocdepth{subsection}
%% No trailing dots in the lists.
\renewcommand{\cftdotsep}{\cftnodots}
%% Formatting of chapter entries in the TOC.
\renewcommand{\cftchapterfont}{\normalsize\normalfont\MakeUppercase}
\renewcommand{\cftchapterpagefont}{\normalsize\normalfont}
%% Prepend "Chapter" before the first chapter entry in the TOC.
\apptocmd{\mainmatter}{\phantomsection\cftaddtitleline{toc}{chapter}{\MakeUppercase Chapter}{}}{}{}
%% Add Bibliography and Appendices entries into the TOC.
\renewcommand{\bibsetup}{\phantomsection\addcontentsline{toc}{chapter}{\MakeUppercase Bibliography}}
\apptocmd{\appendix}{\phantomsection\addcontentsline{toc}{chapter}{\MakeUppercase Appendices}}{}{}
%% Horizontal spacing adjustments to chap, fig, tab (and ex) entries.
%%% chap
\renewcommand{\cftchapterpresnum}{\hfill} % Option 1: right-indented chapter numbers.
%%%%% \renewcommand{\cftchapterpresnum}{\hspace*{0.5in}} % Option 2: Left-indented chapter numbers.
\renewcommand{\cftchapteraftersnum}{\hspace*{0.5in}}
\addtolength{\cftchapternumwidth}{0.87in}
%%% tab
\renewcommand{\cfttablenumwidth}{0.57in} % Allow for approximate number width.
%%% fig
\renewcommand{\cftfigurenumwidth}{0.57in}
%% Section and subsection entry indentation.
\setlength{\cftsectionindent}{1.09in}
\setlength{\cftsubsectionindent}{1.59in}
%% LoT & LoF: Remove extra vertical space before each new chapter.
\renewcommand{\insertchapterspace}{%
        \addtocontents{lof}{\protect\addvspace{0pt}}
        \addtocontents{lot}{\protect\addvspace{0pt}}
}
%% Vertical spacing of TOC entries.
%%% Distance between section and subsection entries should be a single space.
\setlength{\cftbeforesectionskip}{0in}
\setlength{\cftbeforesubsectionskip}{0in}
%%% Distance between figures, between examples, and between tables.
\setlength{\cftbeforetableskip}{0.12in}
\setlength{\cftbeforefigureskip}{0.12in}
%%% Adjust vertical spacing parameters for chapter entries.
%%% This requires some boolean trickery because no such parameter as \ctfafterchapterskip exists.
\setlength{\cftbeforechapterskip}{0.12in}
\newbool{waschap}
\pretocmd{\chapter}{\protect\booltrue{waschap}}{}{}
\pretocmd{\section}{\protect\boolfalse{waschap}}{}{}
\pretocmd{\subsection}{\protect\boolfalse{waschap}}{}{}
\pretocmd{\subsubsection}{\protect\boolfalse{waschap}}{}{}
\pretocmd{\paragraph}{\protect\boolfalse{waschap}}{}{}
\pretocmd{\section}{\ifbool{waschap}{\addtocontents{toc}{\addvspace{0.12in}}}{}}{}{}

% Bibliography formatting.
\pretocmd{\printbibliography}{\SingleSpacing}{}{}
\pretocmd{\printbibliography}{\setlength\bibhang{0.5in}}{}{}
\apptocmd{\printbibliography}{\DoubleSpacing}{}{}
%% Fix hyphenation and line breaking for URLs in the bibliography.
\setcounter{biburlnumpenalty}{9000}
\setcounter{biburlucpenalty}{9000}
\setcounter{biburllcpenalty}{9000}
%% Adjust bibliography heading.
\defbibheading{bibliography}[\bibname]{
        \clearpage
        \pagestyle{plain}
        \chapter*{#1}
        \vspace{0.23in}
}

% Macro to generate a copyright page.
\newcommand{\copyrightpage}[2]{
        \clearpage
        \pagestyle{empty}
        \vspace*{\fill}
        \begin{center}
                Copyright © {#1} {#2}
        \end{center}
        \vfill
}

% Epigraph settings
\epigraphfontsize{\small\itshape\SingleSpacing}
\setlength\epigraphwidth{8cm}
\setlength\epigraphrule{0pt}
\apptocmd{\epigraph}{\DoubleSpacing}{}{}

% Macro to generate a title page.
\newcommand{\titlepage}[9]{
% \titlepage parameters:
% #1, #2, #3: Names of committee members
% #4, #5, #6: Title lines in inverted pyramid form
% #7:         Boolean; true if title page is for abstract
% #8:         Year
% #9:         Author name

        % Preliminaries.
        \newcommand{\sponsortitle}{Sponsoring Committee: }
        \clearpage
        \pagestyle{empty}
        \SingleSpacing

        % Typeset committee membership at the top of the page.
        %% Create lengths.
        \newlength{\sponsortitlewidth}
        \newlength{\toplinewidth}
        \newlength{\nameindent}
        %% Assign and calculate lengths to justify 2nd and 3rd advisor names
        %% at colon of top line.
        \settowidth{\sponsortitlewidth}{\sponsortitle}
        \settowidth{\toplinewidth}{\sponsortitle {#1}}
        \setlength{\nameindent}{\sponsortitlewidth}
        \addtolength{\nameindent}{0.5\textwidth}
        \addtolength{\nameindent}{-0.5\toplinewidth}
        %% Print.
        \noindent\hspace*{\fill}\sponsortitle {#1}\hspace*{\fill}\par
        \noindent\hspace{\nameindent}{#2}\par
        \noindent\hspace{\nameindent}{#3}

        % Typeset the dissertation title.
        \DoubleSpacing
        \newbool{abstract}\setbool{abstract}{#7}
        \ifthenelse{\boolean{abstract}}
        {
                \vspace{1.55in}
                \noindent\hspace*{\fill}An Abstract of\hspace*{\fill}
        }
        {
                \vspace{1.85in}
        }
        \par\noindent
        \hspace*{\fill}\MakeUppercase{#4}\hspace*{\fill}\par\noindent
        \hspace*{\fill}\MakeUppercase{#5}\hspace*{\fill}\par\noindent
        \hspace*{\fill}\MakeUppercase{#6}\hspace*{\fill}\par\noindent

        % Typeset name and program info.
        \SingleSpacing
        \vspace{0.38in}
        \noindent\hspace*{\fill}{#9}\hspace*{\fill}
        \par\vspace{0.19in}
        \noindent\hspace*{\fill}Department of Music \& Performing Arts\hspace*{\fill}\par
        \noindent\hspace*{\fill}Program in Music for Performers\hspace*{\fill}

        % Typeset institution and degree info
        \vspace{2.50in}
        \begin{center}
                Submitted in partial fulfillment\par
                of the requirements for the degree of\par
                Doctor of Philosophy in the\par
                Steinhardt School of Culture, Education, and Human Development\par
                New York University\par
                {#8}
        \end{center}

        % Clean up.
        \clearpage
        \pagestyle{plain}
        \DoubleSpacing
}
