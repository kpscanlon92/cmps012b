.so Tmac.mm-etc
.if t .Newcentury-fonts
.INITR* \n[.F]
.SIZE 12 14
.TITLE CMPS-012M Spring\~2014 Lab\~2 "Unix, shells, make"
.RCS "$Id: lab2u-unix-shells.mm,v 1.39 2014-04-03 18:48:35-07 - - $"
.PWD
.URL
.ds AFSROOT /afs/cats.ucsc.edu/courses/cmps012b-wm
.ds HTTPROOT http://www2.ucsc.edu/courses/cmps012b-wm/:/
In this lab, 
you will become familiar with some features of Unix and its shells.
Unix interaction is generally done with either the
.V= bash
shell or the
.V= tcsh
shell.
.H 1 "Reading assignment"
Following are suggested readings to become familiar with Unix\(::
.ALX a ()
.LI
.E= "Your Unix" ,
by Sumitabha Das,
chapters 1\[en]4 and 7.
If you have a different Unix book,
read the introductory chapters.
.LI
.E= "Unix is a Four Letter Word... and Vi is a Two Letter Abbreviation",
available at\(::
.VTCODE* 1 http://unix.t-a-y-l-o-r.com/
.VTCODE* 1 Tutorials/unix.t-a-y-l-o-r.com
.LI
.V= Tutorials/www.ee.surrey.ac.uk/unixtut/
.br
is another source for learning Unix.
.LI
You should also learn one of the editors
.V= vim 
or
.V= emacs .
To learn about 
.V= vim ,
use the command
.V= vimtutor ,
which will take you through a tutorial.
For emacs,
type the command
.V= "emacs &"
then click on
.IR Help\[->]Emacs\~Tutorial .
The non-GUI form of emacs can be started with
.V= "emacs -nw" .
.LI
The UCSC library has subscribed to Safai Books Online
.VTCODE* 1 http://proquest.safaribooksonline.com/
so if you go to that URL using a UCSC computer,
you can read them for free.
Search for ``Learning the Unix Operating System''
and ``Learning the Bash Shell''.
.LE
.H 1 "Symbolic links"
In order to make references to my directory easier, 
you might want to establish symbolic links from your directories
into mine.
For example,
the command
.VTCODE* 1 "ln -s /afs/cats.ucsc.edu/courses/cmps012b-wm \[ti]/12b
will create a symbolic link so that you can refer to anything in
the course volume using the name
.V= \[ti]/12b
instead of the whole path.
.P
You could also 
.V= cd
into your lab2 directory and make a symbolic link (symlink)
to point at my lab2 directory by using
.V= cd
to get to your lab2 directory.
Then type the command
.VTCODE* 1 "ln -s \[ti]/12b/Labs-cmps012m/lab2u-unix-shells/ lab2
which will allow you to refer to my lab2 files using the short name
.V= lab2 .
Example\(::
One of the commands below could then be replaced by
.VTCODE* 1 "grep '\[ha] *Submit:' lab2/*.tt"
.H 1 "Lab exercises"
Following are the lab exercises you are to do.
For each one submit a file as specified under each point.
.nr submit-count 0 1
.de submit
.   P
.   nop Submit\(::
.   V= \\$1
.   br
..
.ALX 1 ()
.LI
In your working directory for lab2,
you made a symbolic link above pointing at mine.
Type the following two commands\(::
.VTCODE* 1 "ls -la lab2 >symlink.info"
.VTCODE* 1 "stat lab2 >>symlink.info"
This will put the output of two commands into a file called
.V= symlink.info ,
which should show your symbolic link pointing at my directory.
.submit symlink.info
.LI
The
.V= find (1)
command is a useful one for locating files when you know the name or
part of it and don't remember which directory it is in.
Find all of the files in the course volume that contain the word
.=V `` lib ''
as part of the filename\(::
.VTCODE* 1 "cd /afs/cats.ucsc.edu/courses/cmps012b-wm"
.VTCODE* 1 "find . -name '*lib*'"
Note that many error messages are generated to
.V= stderr
because you don't have permission to access some of my directories.
Stop this by redirecting 
.V= stderr \(::
.VTCODE* 1 "find . -name '*lib*' 2>/dev/null"
The file
.V= /dev/null
is a pseudo-device which discards bytes written to it.\*F
.FS
It's the bit bucket.
Empty it when full.
.T= :-)
.FE
The above command works only with
.V= bash .
Now redirect the output into the file you are to submit\(::
.VTCODE* 1 "find . -name '*lib*' >\[ti]/files.found 2>/dev/null"
.submit files.found
.LI
Another useful command, this time for searching files for a given
string, is 
.V= grep (1).
Run the command
.VTCODE* 1 "grep '\[ha] *Submit:' *.tt"
in this lab directory
and redirect its output into a file called
.V= grep.submit
in your directory.
Note that the
.V= grep 
command must be entered in the lab directory,
and the output redirection must have a pathname to your directory.
You can not save files in the lab directory.
.submit grep.submit
.LI
These commands can be combined using a pipe and
.V= xargs (1).
Use a command to find all files anywhere in the course volume
.VTCODE* 1 /afs/cats.ucsc.edu/courses/cmps012b-wm
that match the wildcard
.V= *.java
and pipe this into the command
.VTCODE* 1 "xargs grep -li lib"
The pipe is the stick character
.=V ( | ).
Redirect
.V= stdout
into a file called
.V= java.libs .
.submit java.libs
.LI
Write a program in Java that will print the message
.=V `` EXIT\~1 ''
to the standard error and then exit with a status of 1.
.submit exit1.java
.LI
Write a shell script called
.V= mkexit1
which compiles that program and puts it in a jar file.
The first line of the script must be
.VTCODE* 1 "#!/bin/sh -x"
The second line should be an RCS Id string\(::
.VTCODE* 1 "# \[Do]Id\[Do]
The third line should be your name and username,
along with those of your partner, if any.
Also put the RCS Id string in your java program from the previous
part.
Type the following commands at a terminal and note that they build
a jar\(::
.VTCODE* 1 "javac exit1.java"
.VTCODE* 1 "echo Main-class: exit1 >Manifest"
.VTCODE* 1 "jar cvfm exit1 Manifest exit1.class"
.VTCODE* 1 "yes | rm -i Manifest exit1.class"
.VTCODE* 1 "chmod +x exit1"
Put all of them in the script file
.V= mkexit1
Use
.V= "chmod +x mkexit1"
to make it executable.
Run the script by typing its name at the command line\(::
.VTCODE* 1 "mkexit1"
.VTCODE* 1 "exit1 >/dev/null"
.VTCODE* 1 "echo \[Do]?"
Note that you still see the error message.
The last of these command shows you the exit status.
.submit mkexit1
.LI
Verify that your 
.V= private
directory is properly protected.
Use either of the commands
.VTCODE* 1 "fs la \[Do]HOME/private" ,
.VTCODE* 1 "fs la \[ti]/private" ,
and redirect its output into a file called
.V= privacy .
Append to this file the output from the command
.V= "echo \[Do]HOME" .
.submit privacy
.LI
Make a copy of
.V= exit1.java ,
calling it
.V= exit255.java ,
and have it return an exit status of 255.
Also change the message that it prints to
.=V `` EXIT\~255 '',
also to the standard error.
Also print the message
.=V `` Output\~255 ''
to the standard output.
Create a
.V= Makefile
with a target
.V= all ,
which depends on the jar file
.V= exit255 .
The jar target
.V= exit255
depends on 
.V= exit255.class ,
which, in turn,
depends on
.V= exit255.java .
Add commands under the last two dependencies such that it builds
the jar.
.submit exit255.java
.LI
To this same
.V= Makefile ,
add a target called 
.V= test ,
which runs the jar
.V= exit255 ,
redirecting both its standard output and standard error
 into a file called
.V= 255.output .
It then appends the value of the exit status to that same file.
Do not submit
.V= 255.output ,
the grader will create it via
.V= "make test" .
.P
Since the exit status is in the shell variable
.V= \[Do]? ,
to code that in a 
.V= Makefile ,
you need to enter it as
.V= \[Do]\[Do]? .
Also, each line of a 
.V= Makefile 
is run as a separate process,
so the line that echos the exit status must be on the same
line as the program that is being run,
separated by a semi-colon.
.submit Makefile
.LI
Check your quota and find all files larger than 500 blocks in
your file space.
The command
.VTCODE* 1 "fs lq \[ti]"
will tell you about your disk quota.
The command
.VTCODE* 1 "find \[ti] -size +500"
will print the names of all your files larger than 500 blocks.
Redirect the output of both of these commands into a file called
.V= quota.size .
.submit quota.size
.LE
.H 1 "What to submit"
You were instructed to submit many files.
Verify each of them by looking in the submit directory.
If you are in doubt as to the contents of a file you submitted,
submit it again.
You may submit any file as many times as you want,
as long as you do it before the due date.
.P
If you are doing pair programming, also submit
.V= README
and
.V= PARTNER .
Run
.V= partnercheck
to verify that your 
.V= PARTNER
file is correct.
.P
Look in the subdirectory
.V= \&.score
for instructions to the graders.
.P
Read the submit checklist file in the generic syllabus directory.
.P
\s-6\*F\s+6
.FS
.Cato.maior
.FE
.FINISH
