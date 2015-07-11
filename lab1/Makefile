# $Id: Makefile,v 1.1 2014-04-02 16:19:58-07 - - $

LAB		  = lab1
JAVASRC    = hello.java
SOURCES    = README Makefile .cshrc .bashrc .bash_profile ${JAVASRC}
MAINCLASS  = hello
CLASSES    = hello.class
JARFILE    = hello
JARCLASSES = ${CLASSES}

all: ${JARFILE}

${JARFILE}: ${CLASSES}
	echo Main-class: ${MAINCLASS} >Manifest
	jar cvfm ${JARFILE} Manifest ${JARCLASSES}
	- rm -vf Manifest
	chmod +x ${JARFILE}

%.class: %.java
	javac $<

clean:
	- rm -vf ${CLASSES} test.output

spotless: clean
	- rm -vf ${JARFILE}

ci: ${SOURCES}
	cid + ${SOURCES}
	- checksource ${SOURCES}

test: ${JARFILE}
	(${JARFILE} 2>&1; echo EXIT STATUS = $$?) >test.output
	cat -nv test.output

again:
	gmake --no-print-directory spotless ci all test

submit:
	submit cmps012b-wm.s14 ${LAB} ${SOURCES}

