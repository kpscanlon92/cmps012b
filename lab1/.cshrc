#!/bin/tcsh
# $Id: cshrc.csh,v 1.13 2014/01/04 02:00:52 - - $

setenv EDITOR vim
setenv MANPAGER more
setenv MANWIDTH 72
setenv SHELL /bin/tcsh
setenv VISUAL vim

setenv cmps012b /afs/cats.ucsc.edu/courses/cmps012b-wm
set path=($path $cmps012b/bin)

set hardpaths
set ignoreeof
set noclobber
set prompt=$SHELL:t'-%\!%# '
unset savehist

alias cp 'cp -i'
alias grind 'valgrind --leak-check=full --show-reachable=yes'
alias m 'more'
alias mv 'mv -i'
alias rm 'rm -i'

alias 0 'cd $cmps012b'
alias 0a 'cd $cmps012b/Assignments'
alias 0m 'cd $cmps012b/Labs-cmps012m'

alias la 'ls -la'
alias lf 'ls -Fa'
alias ll 'ls -goa'
alias llc 'ls -goa \!* | cut -c1-80'
alias llh 'ls -goah'
alias llr 'ls -goaR'
alias lls 'ls -goaSr'
alias llt 'ls -goatr'
unalias ls

