\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{journalofficiel}

\LoadClass{texteofficiel}

\RequirePackage{graphicx}
\RequirePackage{tikz}
\AddToHook{shipout/background}{
  \put (0in,-\paperheight){
    \begin{tikzpicture}[remember picture, overlay]
    \node[inner sep=0pt, opacity=0.05] at (current page.center){
      \includegraphics[width=\textwidth]{logo.png}
    };
  \end{tikzpicture}
  }
}

\addto\captionsfrench{\def\journalofficielname{JOURNAL OFFICIEL DE L'ERNESTIE}}
\addto\captionsenglish{\def\journalofficielname{OFFICIAL JOURNAL OF ERNESTIE}}
\addto\captionsesperanto{\def\journalofficielname{OFICIALA ĴURNALO DE ERNESTIE}}
\addto\captionsernestien{\def\journalofficielname{lelalezedefsê librêg dâ ernestô}}


\chead{\hspace{50pt}\journalofficielname}

\endinput
