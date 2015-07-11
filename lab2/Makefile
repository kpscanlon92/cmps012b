# Name: Kelly Scanlon
# User: kpscanlo

# $Id$

all : exit255
	- checksource exit255.java

exit255 : exit255.class
	echo Main-class: exit255 >Manifest
	jar cvfm exit255 Manifest exit255.class
	- rm Manifest
	chmod +x exit255

exit255.class : exit255.java
	javac $<

test : exit255
	- exit255 >255.output 2>&1; echo $$? >>255.output
