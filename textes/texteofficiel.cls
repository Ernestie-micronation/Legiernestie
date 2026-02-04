\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{texteofficiel}

\LoadClass{scrartcl}
\RequirePackage{ifthen}
\RequirePackage{babel}
\RequirePackage[headsepline, headwidth=text]{scrlayer-scrpage}
\RequirePackage[hidelinks, hypertexnames=false]{hyperref}
\RequirePackage{titling}
\RequirePackage{etoolbox}
\RequirePackage{tocbasic}
\RequirePackage{luacode}

\babelprovide[import, main]{french}
\babelprovide[import]{esperanto}
\babelprovide[import]{english}

%ERNESTIEN

\babelprovide[import=fr]{ernestien}
\babelfont[ernestien]{rm}{ErnestFont}
\babelfont[ernestien]{sf}{ErnestFont}
\babelfont[ernestien]{tt}{ErnestFont}
\setlocalecaption{ernestien}{preface}{mulinsecrî}
\setlocalecaption{ernestien}{ref}{etimolojî}
\setlocalecaption{ernestien}{abstract}{inbrêf}
\setlocalecaption{ernestien}{bibliography}{etimolojisekriî}
\setlocalecaption{ernestien}{chapter}{bukinplulâ}
\setlocalecaption{ernestien}{part}{poloniê}
\setlocalecaption{ernestien}{appendix}{poloniê}
\setlocalecaption{ernestien}{contents}{filmkujeperdû}
\setlocalecaption{ernestien}{listfigure}{mangajeperdû}
\setlocalecaption{ernestien}{listtable}{ekseljeperdû}
\setlocalecaption{ernestien}{index}{anulêr}
\setlocalecaption{ernestien}{figure}{mangâ} 
\setlocalecaption{ernestien}{table}{eksêl}
\setlocalecaption{ernestien}{page}{jûr}
\setlocalecaption{ernestien}{see}{rienâ}
\setlocalecaption{ernestien}{proofname}{margê}

\def\ernestienmonthname#1{%
  \ifcase#1\or
    jemlakukû\or
    vivikukû\or
    neptunkukû\or
    ernkukû\or
    hakukû\or
    dakukû\or
    kakukû\or
    rohomajkukû\or
    takukû\or
    diudefkukû\or
    mohkukû\or
    mariakarekukû%
  \fi
}

%\makeatletter
%\newcommand{\baseTreize}[1]{%
%  \ifnum#1<13
%    \ifcase#1 0\or 1\or 2\or 3\or 4\or 5\or 6\or 7\or 8\or 9\or x\or y\or w\fi
%  \else
%    % On calcule le quotient avec troncature : (n - 6) / 13
%    \expandafter\baseTreize\expandafter{\the\numexpr(#1-6)/13\relax}%
%    % On calcule le reste : n - (quotient * 13)
%    \expandafter\baseTreize\expandafter{\the\numexpr#1-13*((#1-6)/13)\relax}%
%  \fi
%}
%\makeatother
%
\begin{luacode*}
function base13(n)
  local digits = "0123456789xyw"
  if n == 0 then return "0" end
  local res = ""
  while n > 0 do
    local r = n % 13
    res = digits:sub(r+1,r+1) .. res
    n = math.floor(n / 13)
  end
  return res
end

function today_ernestien()
  local d = tex.count["day"]
  local m = tex.count["month"]
  local y = tex.count["year"]
  local monthnames = {
    "jemlakukû", "vivikukû", "neptunkukû", "ernkukû", "hakukû", "dakukû",
    "kakukû", "rohomajkukû", "takukû", "diudefkukû", "mohkukû", "mariakarekukû"
  }
  tex.sprint(base13(d) .. " " .. monthnames[m] .. " " .. base13(y))
end
\end{luacode*}

% --- Définir today Ernestien ---
\addto\extrasernestien{%
  \protected\def\today{\directlua{today_ernestien()}}%
  \let\monthname\ernestienmonthname
  \renewcommand{\thesection}{\directlua{tex.sprint(base13(tex.count["c@section"]))}}
  \renewcommand{\thesubsection}{\directlua{tex.sprint(base13(tex.count["c@subsection"]))}}
  \renewcommand{\thepage}{\directlua{tex.sprint(base13(tex.count["c@page"]))}}
  \renewcommand{\theequation}{\directlua{tex.sprint(base13(tex.count["c@equation"]))}}
  \renewcommand{\thefigure}{\directlua{tex.sprint(base13(tex.count["c@figure"]))}}
  \renewcommand{\thetable}{\directlua{tex.sprint(base13(tex.count["c@table"]))}}
  \renewcommand{\thefootnote}{\directlua{tex.sprint(base13(tex.count["c@footnote"]))}}
}

%%
\ohead{\thepage}
\ihead{\today}
\cfoot{}


\newcommand{\setvariable}[2]{%
\expandafter\edef\csname var@{#1}\endcsname{#2}%
}


\newcommand{\getvariable}[1]{%
\csname var@{#1}\endcsname%
}


\newcommand{\target}[2]{%
\hypertarget{#1}{}%
\setvariable{#1}{#2}%
}


\newcommand{\reftarget}[1]{%
\hyperlink{#1}{\getvariable{#1}}%
}

\newcommand{\settoc}[1]{%
  \def\ext@toc{#1}%
}

\def\tableofcontents{%
  \section*{\contentsname}%
  \@starttoc{\ext@toc}%
}

\newcommand{\passageLangue}[1]{
  \clearpage
  \noextrasernestien
  \selectlanguage{#1}
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \setcounter{figure}{0}
  \setcounter{table}{0}
  \setcounter{footnote}{0}
  \setcounter{equation}{0}
  \setcounter{part}{0}
  \settoc{toc-#1}
  \maketitle
  \tableofcontents
  \clearpage
}

\endinput
