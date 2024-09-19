\ExplSyntaxOn
\cs_new_eq:NN \Repeat \prg_replicate:nn
\ExplSyntaxOff

\newcommand{\myMinLineHeight}[1]{\parbox{0pt}{\vskip#1}}
\newcommand{\myDummyQ}{\textcolor{white}{Q}}

{{- $numbers := .Cfg.Layout.Numbers -}}
\newcommand{\myNumArrayStretch}{ {{- $numbers.ArrayStretch -}} }
\newcommand{\myNumQuarterlyLines}{ {{- $numbers.QuarterlyLines -}} }
\newcommand{\myNumDotHeightFull}{ {{- $numbers.DotHeightFull -}} }
\newcommand{\myNumDotWidthFull}{ {{- $numbers.DotWidthFull -}} }
\newcommand{\myNumDotWidthTwoThirds}{ {{- $numbers.DotWidthTwoThirds -}} }
\newcommand{\myNumWeeklyLines}{ {{- $numbers.WeeklyLines -}} }
\newcommand{\myNumDailyTodos}{ {{- $numbers.DailyTodos -}} }
\newcommand{\myNumDailyNotes}{ {{- $numbers.DailyNotes -}} }
\newcommand{\myNumDailyBottomHour}{ {{- $numbers.DailyBottomHour -}} }
\newcommand{\myNumDailyTopHour}{ {{- $numbers.DailyTopHour -}} }
\newcommand{\myNumDailyDiaryGoals}{ {{- $numbers.DailyDiaryGoals -}} }
\newcommand{\myNumDailyDiaryGrateful}{ {{- $numbers.DailyDiaryGrateful -}} }
\newcommand{\myNumDailyDiaryBest}{ {{- $numbers.DailyDiaryBest -}} }
\newcommand{\myNumDailyDiaryLog}{ {{- $numbers.DailyDiaryLog -}} }
\newcommand{\myNumDailyPersonal}{ {{- $numbers.DailyPersonal -}} }
\newcommand{\myNumTodoLinesInTodoPage}{ {{- $numbers.TodoLinesInTodoPage -}} }
\newcommand{\myNumColsForDay}{ {{- $numbers.ColumnsForDay -}} }

\newlength{\myLenTabColSep}
\newlength{\myLenLineThicknessDefault}
\newlength{\myLenLineThicknessThick}
\newlength{\myLenLineHeightButLine}
\newlength{\myLenTwoColSep}
\newlength{\myLenTwoCol}
\newlength{\myLenTriColSep}
\newlength{\myLenTriCol}
\newlength{\myLenQuadColSep}
\newlength{\myLenQuadCol}
\newlength{\myLenFiveColSep}
\newlength{\myLenFiveCol}
\newlength{\myLenMonthlyCellHeight}
\newlength{\myLenNotesIndexCellHeight}
\newlength{\myLenHeaderResizeBox}
\newlength{\myLenHeaderSideQuartersWidth}
\newlength{\myLenHeaderSideMonthsWidth}

{{- $lengths := .Cfg.Layout.Lengths -}}
\setlength{\myLenTabColSep}{ {{- $lengths.TabColSep -}} }
\setlength{\myLenLineThicknessDefault}{ {{- $lengths.LineThicknessDefault -}} }
\setlength{\myLenLineThicknessThick}{ {{- $lengths.LineThicknessThick -}} }
\setlength{\myLenLineHeightButLine}{ {{- $lengths.LineHeightButLine -}} }
\setlength{\myLenTwoColSep}{ {{- $lengths.TwoColSep -}} }
\setlength{\myLenTwoCol}{\dimexpr.5\linewidth-.5\myLenTwoColSep}
\setlength{\myLenQuadColSep}{ {{- $lengths.QuadColSep -}} }
\setlength{\myLenQuadCol}{\dimexpr.25\linewidth-.25\myLenQuadColSep}
\setlength{\myLenFiveColSep}{ {{- $lengths.FiveColSep -}} }
\setlength{\myLenFiveCol}{\dimexpr.2\linewidth-\myLenFiveColSep}
\setlength{\myLenMonthlyCellHeight}{ {{- $lengths.MonthlyCellHeight -}} }
\setlength{\myLenTriColSep}{ {{- $lengths.TriColSep -}} }
\setlength{\myLenTriCol}{\dimexpr.333\linewidth-.667\myLenTriColSep}
\setlength{\myLenNotesIndexCellHeight}{ {{- $lengths.NotesIndexCellHeight -}} }
\setlength{\myLenHeaderResizeBox}{ {{- $lengths.HeaderResizeBox -}} }
\setlength{\myLenHeaderSideQuartersWidth}{ {{- $lengths.HeaderSideQuartersWidth -}} }
\setlength{\myLenHeaderSideMonthsWidth}{ {{- $lengths.HeaderSideMonthsWidth -}} }

\newcommand{\myQuarterlySpring}{ {{- $lengths.QuarterlySpring -}} }
\newcommand{\myMonthlySpring}{ {{- $lengths.MonthlySpring -}} }
\newcommand{\myDailySpring}{ {{- $lengths.DailySpring -}} }
\newcommand{\myColorGray}{ {{- .Cfg.Layout.Colors.Gray -}} }
\newcommand{\myColorLightGray}{ {{- .Cfg.Layout.Colors.LightGray -}} }
\newcommand{\myColorDots}{ {{- .Cfg.Layout.Colors.Dots -}} }

\newcommand{\myLinePlain}{\hrule width \linewidth height \myLenLineThicknessDefault}
\newcommand{\myLineThick}{\hrule width \linewidth height \myLenLineThicknessThick}

\newcommand{\myLineHeightButLine}{\myMinLineHeight{\myLenLineHeightButLine}}
\newcommand{\myUnderline}[1]{#1\vskip1mm\myLineThick\par}
\newcommand{\myLineColor}[1]{\textcolor{#1}{\myLinePlain}}
\newcommand{\myLineGray}{\myLineColor{\myColorGray}}
\newcommand{\myLineLightGray}{\myLineColor{\myColorLightGray}}
\newcommand{\myLineGrayVskipBottom}{\myLineGray\vskip\myLenLineHeightButLine}
\newcommand{\myLineGrayVskipTop}{\vskip\myLenLineHeightButLine\myLineGray}

\newcommand{\myTodo}{\myLineHeightButLine$\square$\myLinePlain}
\newcommand{\myTodoLineGray}{\myLineHeightButLine$\square$\myLineGray}

\newcommand{\myDotGrid}[2]{\leavevmode\multido{\dC=0mm+\myLenLineHeightButLine}{#1}{\multido{\dR=0mm+\myLenLineHeightButLine}{#2}{\put(\dR,\dC){\color{\myColorDots}\circle*{0.1}}}}}

\newcommand{\myMash}[3][]{
  {{- if $.Cfg.Dotted -}} \vskip\myLenLineHeightButLine#1\myDotGrid{#2}{#3} {{- else -}} \Repeat{#2}{\myLineGrayVskipTop} {{- end -}}
}

\newcommand{\remainingHeight}{%
  \ifdim\pagegoal=\maxdimen
  \dimexpr\textheight-9.4pt\relax
  \else
  \dimexpr\pagegoal-\pagetotal-\lineskip-9.4pt\relax
  \fi%
}

\makeatletter
%--------------------------------------------------------------------
%                            \fillwithlines


% \fillwithlines takes one argument, which is either a length or \fill
% or \stretch{number}, and it fills that much vertical space with
% horizontal lines that run the length of the current line.  That is,
% they extend from the current left margin (which depends on whether
% we're in a question, part, subpart, or subsubpart) to the right
% margin.
%
% The distance between the lines is \linefillheight, whose default value
% is set with the command
%
% \setlength\linefillheight{.25in}
%
% This value can be changed by giving a new \setlength command.
%
% The thickness of the lines is \linefillthickness, whose default value
% is set with the command
%
% \setlength\linefillthickness{.1pt}
%
% This value can be changed by giving a new \setlength command.
%
% As of version 2.503, 2016/03/25, the lines drawn by the
% \fillwithlines command will be drawn in color if the user has given
% the command
%
%      \colorfillwithlines.
%
% The actual drawing of the lines is now done by the command
% \do@fillwithlines, after the \fillwithlines command decides whether
% they will be in color.  The default color is set by the command
%
%      \definecolor{FillWithLinesColor}{gray}{0.8}
%
% and the color can be changed by giving a new \definecolor command.
% You can return to black lines by giving the command
%
%      \nocolorfillwithlines

\newlength\linefillheight
\newlength\linefillthickness
\setlength\linefillheight{.25in}
\setlength\linefillthickness{0.1pt}




\newif\if@colorfillwithlines
\@colorfillwithlinesfalse
\def\colorfillwithlines{%
  \@ifundefined{definecolor}
  {%
    \ClassError{exam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\colorfillwithlines
      \MessageBreak
      }{%
      This command requires either the package color.sty\MessageBreak
      or xcolor.sty, and so you have to load one of those before \MessageBreak
      your \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{FillWithLinesColor}{gray}{0.8}
    \@colorfillwithlinestrue
  }%
}% \colorfillwithlines
\def\nocolorfillwithlines{\@colorfillwithlinesfalse}

\newcommand\fillwithlines[1]{%
  \if@colorfillwithlines
    \color@begingroup
      \color{FillWithLinesColor}%
      \do@fillwithlines{#1}%
    \color@endgroup
  \else
    \do@fillwithlines{#1}%
  \fi
}% \fillwithlines

\newcommand\linefill{\leavevmode
    \leaders\hrule height \linefillthickness \hfill\kern\z@}

% \do@fillwithlines is called only by \fillwithlines
\def\do@fillwithlines#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak
  \setbox0=\hbox to \hsize{\hskip \@totalleftmargin
          \vrule height \linefillheight depth \z@ width \z@
          \linefill}%
  % We use \cleaders (rather than \leaders) so that a given
  % vertical space will always produce the same number of lines
  % no matter where on the page it happens to start:
  \cleaders \copy0 \vskip #1 \hbox{}%
  \endgroup
}% \do@fillwithlines

%--------------------------------------------------------------------
%                         \fillwithdottedlines


% \fillwithdottedlines is similar to \fillwithlines, except that it
% fills the space with dotted lines (created by \dotfill) rather than
% with solid lines.

% \fillwithdottedlines takes one argument, which is either a length or
% \fill or \stretch{number}, and it fills that much vertical space
% with dotted lines that run the length of the current line.  That is,
% they extend from the current left margin (which depends on whether
% we're in a question, part, subpart, or subsubpart) to the right
% margin.
%
% The distance between the lines is \dottedlinefillheight, whose
% default value is set with the command
%
% \setlength\dottedlinefillheight{.25in}
%
% This value can be changed by giving a new \setlength command.

% As of version 2.503, 2016/03/25, the dotted lines drawn by the
% \fillwithdottedlines command will be drawn in color if the user has
% given the command
%
%      \colorfillwithdottedlines.
%
% The actual drawing of the lines is now done by the command
% \do@fillwithdottedlines, after the \fillwithdottedlines command
% decides whether they will be in color.  The default color is set by
% the command
%
%      \definecolor{FillWithDottedLinesColor}{gray}{0.8}
%
% and the color can be changed by giving a new \definecolor command.
% You can return to black lines by giving the command
%
%      \nocolorfillwithdottedlines


\newlength\dottedlinefillheight
\setlength\dottedlinefillheight{.25in}

\newif\if@colorfillwithdottedlines
\@colorfillwithdottedlinesfalse
\def\colorfillwithdottedlines{%
  \@ifundefined{definecolor}
  {%
    \ClassError{exam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\colorfillwithdottedlines
      \MessageBreak
      }{%
      This command requires either the package color.sty\MessageBreak
      or xcolor.sty, and so you have to load one of those before \MessageBreak
      your \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{FillWithDottedLinesColor}{gray}{0.8}
    \@colorfillwithdottedlinestrue
  }%
}% \colorfillwithdottedlines
\def\nocolorfillwithdottedlines{\@colorfillwithdottedlinesfalse}

\newcommand\fillwithdottedlines[1]{%
  \if@colorfillwithdottedlines
    \color@begingroup
      \color{FillWithDottedLinesColor}%
      \do@fillwithdottedlines{#1}%
    \color@endgroup
  \else
    \do@fillwithdottedlines{#1}%
  \fi
}% \fillwithdottedlines

% \do@fillwithdottedlines is called only by \fillwithdottedlines
\def\do@fillwithdottedlines#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak
  \setbox0=\hbox to \hsize{\hskip \@totalleftmargin
          \vrule height \dottedlinefillheight depth \z@ width \z@
          \dotfill}%
  % We use \cleaders (rather than \leaders) so that a given
  % vertical space will always produce the same number of lines
  % no matter where on the page it happens to start:
  \cleaders \copy0 \vskip #1 \hbox{}%
  \endgroup
}% \do@fillwithdottedlines

%--------------------------------------------------------------------
%                            \fillwithgrid


% \fillwithgrid is similar to \fillwithlines, except that it
% fills the space with a grid.

% \fillwithgrid takes one argument, which is either a length or \fill
% or \stretch{number}, and it fills that much vertical space with a
% grid that runs the length of the current line.  That is, it extends
% from the current left margin (which depends on whether we're in a
% question, part, subpart, or subsubpart) to the right margin.
%
% The default grid size and grid line thickness were set by the
% commands
%
% \setlength{\gridsize}{5mm}
% \setlength{\gridlinewidth}{0.1pt}
%
% You can change either or both of those by giving new \setlength
% commands.  The period of the grid is \gridsize (both horizontally
% and vertically).  That is, the horizontal distance from the left
% edge of one vertical line to the left edge of the next vertical line
% is \gridsize, as is the vertical distance from the top edge of one
% horizontal line to the top edge of the next horizontal line.  Thus,
% each square has outer side length equal to \gridsize+\gridlinewidth.

% By default, the created grids are in black.  However, if you give the
% commands
%
% \usepackage{color}
% \colorgrids
%
% then the grids will be in color, by default a light gray.  That
% default color was defined by the command
%
% \definecolor{GridColor}{gray}{0.8}
%
% You can change the color by redefining the color GridColor by giving
% a new \definecolor command.

\newif\if@colorgrids
\newcommand\colorgrids{%
  \@ifundefined{definecolor}
  {%
    \ClassError{exam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\colorgrids
      }{%
      This command requires either the package color.sty\MessageBreak
      or xcolor.sty, and so you have to load one of those before \MessageBreak
      your \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{GridColor}{gray}{0.8}
    \@colorgridstrue
  }%
}% \colorgrids
\newcommand\nocolorgrids{\@colorgridsfalse}
\nocolorgrids

\newlength\gridsize
\newlength\gridlinewidth
\setlength{\gridsize}{5mm}
\setlength{\gridlinewidth}{0.1pt}

\def\fillwithgrid#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak

  % We first set box0 equal to an \hbox which, when printed, is a
  % square with width and height equal to \gridsize+\gridlinewidth,
  % but which has
  % width equal to \gridsize,
  % height equal to \gridsize, and
  % depth equal to 0pt.
  % When we put multiple copies of it together using \leaders or
  % \cleaders, the right edge will coincide with the left edge of the
  % next box and the bottom edge will coincide with the top edge of
  % the box below it.
  \setlength{\@tempdima}{\gridsize}
  \addtolength{\@tempdima}{\gridlinewidth}
  \setlength{\@tempdimb}{\gridsize}
  \addtolength{\@tempdimb}{-\gridlinewidth}
  \setbox0=\hbox{%
    \rlap{\vrule height \gridsize depth \gridlinewidth width \gridlinewidth}%
    \rlap{\vrule height \gridsize depth -\@tempdimb width \@tempdima}%
    \vrule height 0pt depth \gridlinewidth width \@tempdima
    \llap{\vrule height \gridsize depth \gridlinewidth width \gridlinewidth}%
  }%
  \wd0=\gridsize
  \dp0=0pt
  % Now we set box1 equal to an \hbox containing a single line of
  % copies of box0.  We use \leaders (instead of \cleaders) so that
  % if we use it twice on a page, once with a question and once
  % with a part, the boxes will line up vertically.  We add a kern of
  % \gridlinewidth at the right because the rightmost vertical line
  % appears to the right of where the \leaders command thinks that it
  % appears.
  \setbox1=\hbox to \textwidth{%
    \color@begingroup
    \if@colorgrids
      \color{GridColor}%
    \fi
    \hskip \@totalleftmargin \leaders\copy0\hfil \kern\gridlinewidth
    \color@endgroup
  }%
  % Finally: We create the grid, using \cleaders: We use \cleaders
  % (rather than \leaders) so that a given vertical space will always
  % produce the same number of lines no matter where on the page it
  % happens to start.  We add a kern of \gridlinewidth because the
  % bottommost horizontal line appears below where the \cleaders
  % command thinks that it appears.
  \cleaders \copy1 \vskip #1 \kern \gridlinewidth \hbox{}%
  \endgroup
}% fillwithgrid
\makeatother
