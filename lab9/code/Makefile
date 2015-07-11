# Name: Kelly Scanlon
# User: kpscanlo
# $Id $

GCC 	 	= gcc -g -O0 -Wall -Wextra -std=gnu99
MKDEPS	= gcc -MM

EXECBINS = l9stat
LIBSRC 	= l9stat.c
OBJECTS 	= ${EXECBINS:.o}
SOURCES 	= ${LIBSRC} ${ECEXBINS:=.c} Makefile README
DEPFILE	= Makefile.deps
LISFILES = ${SOURCES} ${DEPFILE}
LISTING  = Listing.ps
PROJECT  = cmps012b-wm.s14 lab9


all: ${EXECBINS}

%: %.o
	${GCC} -o $@ $^ -lm

%.o:%.c
	${GCC} -c $<
	
ci: ${SOURCES}
	checksource ${SOURCES}
	cid + ${SOURCES}

lis: ${SOURCES} ${DEPFILE} ${EXECBINS:=.out}
	mkpspdf ${LISTING} $^

clean:
	- rm ${OBJECTS} ${EXECBINS:=.out}

spotless: clean
	- rm ${EXECBINS} ${LISTING} ${LISTING:.ps=.pdf}

%.out: %
	$< >$@ 2>&1

${DEPFILE}:
	${MKDEPS} ${SOURCES} >${DEPFILE}

dep:
	- rm ${DEPFILE}
	make --no-print-directory ${DEPFILE}

include ${DEPFILE}

submit: ${SOURCES}
	submit ${PROJECT} ${SOURCES}

again:
	make --no-print-directory spotless dep ${EXECBINS} lis
	
