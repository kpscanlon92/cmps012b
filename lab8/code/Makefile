# Name: Kelly Scanlon
# User: kpscanlo

# $Id $


MKFILE 	 = Makefile
DEPSFILE  = ${MKFILE}.deps
NOINCLUDE = ci clean spotless
NEEDINCL	 = ${filter ${NOINCLUDE}, ${MAKECMDGOALS}}
GMAKE     = gmake --no-print-directory

GCC	    = gcc -g -O0 -Wall -Wextra -std=gnu99
MKDEPS 	 = gcc -MM
GRIND	    = valgrind --leak-check=full

CSOURCE1	 = numsort.c  inssort.c
CSOURCE2	 = linesort.c inssort.c
CHEADER   = 			inssort.h
OBJECTS1  = ${CSOURCE1:.c=.o}
OBJECTS2  = ${CSOURCE2:.c=.o}
EXECBIN1	 = numsort
EXECBIN2  = linesort
SOURCES 	 = ${CHEADER} ${CSOURCE1} linesort.c ${MKFILE}
PROJECT   = cmps012b-wm.s14 lab8

all: ${EXECBIN1} ${EXECBIN2}

${EXECBIN1} : ${OBJECTS1}
		${GCC} -o $@ ${OBJECTS1}

${EXECBIN2} : ${OBJECTS2}
		${GCC} -o $@ ${OBJECTS2}

%.o : %.c
		- checksource ${SOURCES}
		${GCC} $< -c $<

ci : ${SOURCES}
		cid + ${SOURCE}

clean :
		-rm ${OBJECTS1} ${OBJECTS2} ${DEPSFILE}

spotless : clean
		-rm ${EXEBIN1} ${EXEBIN2} core

submit : ${SOURCES}
		submit ${PROJECT} ${SOURCES}

deps : ${CSOURCE1} ${CSOURCE2} ${CHEADER}
		@ echo "# ${DEPSFILE} created `date`" >${DEPSFILE}
		${MKDEPS} ${CSOURCE1} ${CSOURCE2} 
					| sort | uniq >>${DEPSFILE}

${DEPSFIILE} :
		@ touch ${DEPSFILE}
		${GMAKE} deps

again :
		gmake spotless deps ci all lis

ifeq "${NEEDINCL}" ""
include ${DEPSFILE}
endif

