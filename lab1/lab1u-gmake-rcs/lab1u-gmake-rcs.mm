.so Tmac.mm-etc
.if t .Newcentury-fonts
.INITR* \n[.F]
.SIZE 12 14
.GETPN* HELLOJAVA Page_HELLOJAVA
.GETPN* MAKEFILE Page_MAKEFILE
.GETPN* BASHRC_SH Page_BASHRC_SH
.GETST* HELLOJAVA Figure_HELLOJAVA
.GETST* OUTPUT Figure_OUTPUT
.GETST* MAKEFILE Figure_MAKEFILE
.GETST* BASHRC_SH Figure_BASHRC_SH
.TITLE CMPS-012M Spring\~2014 Lab\~1 \
"Unix\(:) \f[CB]AFS gmake RCS \[Do]PATH\f[P]"
.RCS "$Id: lab1u-gmake-rcs.mm,v 1.120 2014-03-27 17:49:47-07 - - $"
.PWD
.URL
.ds SUBQUARTER cmps012b-wm.s14
.ds SUBMITDIR /afs/cats.ucsc.edu/class/\*[SUBQUARTER]/lab1/\[Do]USER
.ds COURSEDIR /afs/cats.ucsc.edu/courses/cmps012b-wm
.ds BINDIR \*[COURSEDIR]/bin
.nr HISTORY 0 1
.ds PROMPT bash-\\n+[HISTORY]\[Do]
.ds UNIXHOST unix.ucsc.edu
.H 1 "Overview"
This lab
will introduce you to Unix if you are not already familiar with it,
and show you how to compile and execute a Java program.
It also helps you with a first pass at understanding\(::
.ALX \[bu] 0 "" 0 0
.LI
.V= AFS ,
the file system where your files are kept, and access control lists\(;;
.LI
.V= RCS ,
the revision control system,
which helps you keep backup copies of all of your work\(;;
.LI
.V= gmake ,
which helps you with building executables from source code\(;;
and
.LI
automatically setting the
.V= \[Do]PATH
variable by means of dot files in your home directory.
.LE
.H 1 "Directories and ACLs"
Change directory to your home directory and create a subdirectory called
.V= private .
Then make a subdirectory of that called
.V= cmps012m ,
and a subdirectory of that called
.V= lab1 .
In the following, bolface is what you type, 
and plain face is what is typed at you\(::
.DS
.TVCODE 1 "\*[PROMPT] " "cd"
.TVCODE 1 "\*[PROMPT] " "mkdir private"
.DE
Make sure you protect the directory against other users\(::
.DS
.TVCODE 1 "\*[PROMPT] " "fs setacl private \[Do]USER all -clear"
.TVCODE 1 "\*[PROMPT] " "fs listacl private"
.TVCODE 1 "Access list for private is"
.TVCODE 1 "Normal rights\(::"
.TVCODE 1 "\0\0foobar rlidwka"
.DE
At this point, there should be only one ACL on your private
directory, namely your own,
where 
.V= foobar
is shown above should be shown your own username.
The shell variable
.V= \[Do]USER
is your own username.
You may wish to type it in explicitly instead.
If there are any other ACLs on your private directory, 
you must delete them.
Note that you may also lock your home directory to all ACLs
but your own.
That means, however, that you may not have a web page.
.P
You must understand ACLs in order to protect your files.
Some special ACL usernames are\(::
.V= wwwadmin
is the IC web server, which needs read permission on your 
directory 
.V= public_html ,
if you have one, and list permission on your home directory.
.V= system:authuser
is anybody with a IC account.
.V= system:anyuser
is anybody anywhere in the world on any machine running AFS.
Try 
.V= "ls /afs" .
.P
You should have a separate directory for each course and each
assignment.
So create a directory using the following\(::
.DS
.TVCODE 1 "\*[PROMPT] " "cd \[Do]HOME/private"
.TVCODE 1 "\*[PROMPT] " "mkdir -p cmps012b/lab1"
.TVCODE 1 "\*[PROMPT] " "cd cmps012b/lab1"
.DE
The shell variable
.V= \[Do]HOME
may also be replaced by
a tilde
.=V ( \[ti] )
as the name of your home directory.
When you use
.V= cd
without an operand, it sets the current directory to your home
directory.
You may wish to use two separate course directories,
one for your CMPS-012B work,
and one for your CMPS-012M work,
or you might want to use just one.
You may, of course, call them anything you like.
In order to organize your files,
make a separate subdirectory for each course,
and under that,
a subdirectory for each project in each course.
.H 1 "\f[CB]Hello.java\f[P]"
Now begin work on lab\~1.
Create a file called
.V= hello.java ,
as shown in Figure \*[Figure_HELLOJAVA] (page \*[Page_HELLOJAVA]).
It is a slightly more complicated version of the standard ``Hello
World'' program used to introduce programming languages.
.P
If you use the command
.V= "ls -la"
in my directory,
you might notice a subdirectory containing that code.
If you like,
you may copy it into your lab directory instead of copying it in.
Files beginning with a dot
are not listed with
.V= ls (1)
unless the
.V= \&-a
flag is given.
.H 1 "The \f[CB]\[Do]PATH\f[P] variable"
There are some commands given in this lab which are not generally
available Unix commands.
These are
.V= cid 
and
.V= checksource .
You will notice that you get an error message when you use them\(::
.DS
.TVCODE 1 "\*[PROMPT] " "cid hello.java"
.TVCODE 1 "bash: cid: command not found"
.DE
This is because they are not in your path.
These commands, among many others, are in the directory
.V= \*[BINDIR]/ .
You should add this directory to your path.
.P
How this is done depends on which shell you are using.
The file
.V= /etc/shells
lists all of the ones available\(::
.V= /bin/bash ,
.V= /bin/csh ,
.V= /bin/ksh ,
.V= /bin/mksh ,
.V= /bin/sh ,
.V= /bin/tcsh ,
.V= /bin/zsh .
We will discuss only
.V= tcsh
and
.V= bash
in this document and ignore the others.
Since we are using Linux,
.V= /bin/sh
does not exist, and is a symbolic link to
.V= /bin/bash .
Also,
.V= /bin/csh
does not exist, and is a symbolic link to 
.V= /bin/tcsh .
To find out which shell is your default, use the command\(::
.VTCODE* 1 "echo \[Do]SHELL" 
.P
Create or modify three files\(::
.V= \[ti]/.cshrc ,
.V= \[ti]/.bashrc ,
and
.V= \[ti]/.bash_profile .
Modify your path for both shells as follows\(::
.ALX a ()
.LI
For
.V= tcsh ,
add the following line to the end of your
.V= \[ti]/.cshrc
file\(::
.VTCODE* 1 \
"set path=(\[Do]path \*[BINDIR])"
Then source it with the command\(::
.VTCODE* 1 "source \[ti]/.cshrc"
For this command to work,
you must be interacting with
.V= tcsh .
.LI
For
.V= bash ,
add the following line to the end of your
.V= \[ti]/.bashrc
file\(::
.VTCODE* 1 \
"export PATH=\[Do]PATH:\*[BINDIR]"
Then source it with the command\(::
.VTCODE* 1 "source \[ti]/.bashrc"
For this command to work, you must be interacting with
.V= bash .
If your current shell is
.V= tcsh ,
type the command
.V= bash
before running the above command.
Whenever you start 
.V= bash
as a subshell, it will automatically read the contents of
.V= \&.bashrc .
.P
Since
.V= bash
differentiates between a login shell and a subshell,
You should also have the file
.V= \[ti]/.bash_profile
source
.V= \[ti]/.bashrc .
This is done by putting the following line in your
.V= \[ti]/.bash_profile
file\(::
.VTCODE* 1 "source \[ti]/.bashrc"
.LE
.P
The sourcing command does not need to be typed in every time you
log in.
Shells source their start files automatically.
Any command or alias you want executed automatically every time you
log in should be placed in the appropriate startup file.
The last two letters,
.=V `` rc ''
mean ``run commands''.
.P
If your shell is currently
.V= tcsh
and you want to use bash, just use the command
.V= bash
at the prompt.
Or follow the instructions printed by the command
.V= chsh
if you want to make this permanent.
.P
When you log in using
.V= tcsh ,
the file
.V= \[ti]/.cshrc
is automatically sourced,
followed by
.V= \[ti]/.login ,
which you probably may ignore.
When you start
.V= bash
by typing in the command at the command line,
the file
.V= \[ti]/.bashrc
is automatically sourced.
But if 
.V= bash
is your login shell,
then at login,
.V= \[ti]/.bash_profile
is automatically sourced.
.P
Submit your files
.V= .cshrc ,
.V= .bashrc ,
and
.V= .bash_profile ,
using the command\(::
.VTCODE* 1 "submit \*[SUBQUARTER] lab1 .cshrc .bashrc .bash_profile"
This command must be done in your home directory.
.H 1 "The script \f[CB]checksource\f[P]"
Use the script
.V= checksource
to check on some basic formatting items.
Edit your files so that it does not complain.
If you run
.V= checksource
without filename operands,
it will print out a text-format manual page.
To check up on 
.V= hello.java ,
use the command\(::
.DS
.TVCODE 1 "\*[PROMPT] " "checksource hello.java"
.DE
.H 1 "The script \f[CB]cid\f[P]"
An alternative to using
.V= ci
(see below)
directly is the program
.V= cid .
It works just like
.V= ci ,
but automatically creates the
.V= RCS
subdirectory and does the correct locking.
To fetch back a deleted file, use the
.V= co
command.
You will find that the
.V= cid
command is much simpler to use,
since it automatically sets up the
.V= RCS
subdirectory and appropriate file locking.
.P
In order to find where that script is, you can do the following\(::
.DS
.TVCODE 1 "\*[PROMPT] " "cd \*[COURSEDIR]"
.TVCODE 1 "\*[PROMPT] " "find * -name cid -follow 2>/dev/null"
.DE
This says find all files whose name is
.V= cid ,
even if you have to follow symbolic links.
Without the redirection
.V= 2>/dev/null ,
you will get lots of error messages because of directories that you
don't have permission to access.
With this redirection, error messages will be sent to
.V= /dev/null ,
the bit bucket.
Try it both ways, with and without redirecting
.V= stderr .
This works if you use
.V= bash
or
.V= sh
as your shell,
If you use 
.V= csh ,
you should instead use
.DS
.TVCODE 1 "csh-% " "sh -c 'find * -name cid -follow 2>/dev/null'"
.DE
which will pass the command to the Bourne shell to have it
executed.
There are many small differences between the shells.
Inside of a
.V= Makefile ,
always use Bourne shell syntax, and never use the born-again shell
syntax or 
.V= csh
syntax.
Read
.V= http://www.faqs.org/faqs/unix-faq/shell/ .
You may find something of interest in 
.V= http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/ .
.H 1 "Running the program"
The output of running the program is shown in Figure \*[Figure_OUTPUT].
The figure was actually generated from the
.V= gmake
process that created this document.
A Unix pipe was used.
If you don't want to type in the entire ``hello'' program,
you may copy it from the hidden (or ``dot'') subdirectory.
This directory will not show up if you are using a browser.
Log into
.V= \*[UNIXHOST]
and find it with
.V= ls\~-la .
.DF
.B1
.SP
.ft CR
.nf
.eo
.pso cat -n .files/test.output | expand | perl -pe 's/.{74}/$&\n/'
.ec
.fi
.ft R
.SP
.B2
.FG "\f[CB].files/test.output\f[P]" "" 0 OUTPUT
.DE
.H 1 "\f[CB]Makefile\f[P]"
Typing in all of these commands repeatedly is a hassle.
To avoid that,
we use a program called
.V= gmake .
Create a file called
.V= Makefile ,
as shown in Figure \*[Figure_MAKEFILE] (page \*[Page_MAKEFILE]).
.P
Make sure that indented commands in a
.V= Makefile
are indented with a TAB character, not spaces.
If you mistakenly use spaces to indent commands in a
.V= Makefile ,
you will get an error message.
Proper capitalization is also important.
Now you can make, check in, and submit your program as follows\(::
.DS
.TVCODE 1 "\*[PROMPT] " "rm hello.class"
.TVCODE 1 "\*[PROMPT] " "gmake ci"
.TVCODE 1 "\*[PROMPT] " "gmake all"
.TVCODE 1 "\*[PROMPT] " "gmake submit"
.DE
.P
To submit files directly from the command line without using the
.V= Makefile ,
the following command may be used\(::
.VTCODE* 1 "submit \*[SUBQUARTER] lab1 README Makefile hello.java
If you are doing pair programming, also submit the file
.V= PARTNER .
The first argument to submit is the name of the class volume,
the second argument is the name of the project,
and the rest are names of files to be submitted.
.H 1 "Verifying the submit"
To check on the files you submitted,
look in the directory
.VCODE* 1 \*[SUBMITDIR] .
You won't actually be able to read the files,
but you can verify the filenames.
Check to make sure that you have submitted all the files that
should be submitted.
.P
In order to verify that your submit actually worked, 
create a new directory in your personal file space,
or choose an existing test submit directory and use
.V= rm
to delete any existing files in that.
Then copy the files you submitted from your
working directory into the new directory.
Do not copy other files.
Did everything work as expected\(??
.P
You may use any system to which you have access as your development
system.
However, you 
.E= must
test your program on one of the Linux servers or lab workstations
prior to submitting it.
.E= "Graders will only use
.V= \*[UNIXHOST]
to do the grading.
.br
.ne 5
.H 1 "Automating checkin and submit"
You will note that the
.V= Makefile
has two targets
.V= ci
and
.V= submit .
The purpose of
.V= make
is to automate routine boring tasks.
So try checking in everything all at once
and then submitting it\(::
.DS
.TVCODE 1 "\*[PROMPT] " "gmake ci"
.TVCODE 1 "\*[PROMPT] " "gmake submit"
.DE
Note that when this is automated, you don't run the risk of
forgetting a file when you submit.
.H 1 "WARNING"
The time to figure out how to do it is
.E= NOT
the day the first real assignment is due.
Excuses sent late on the due date will be rejected and your
assignment will score 
.E= ZERO .
There is no excuse for not knowing how to use submit and/or 
the Unix workarounds if the script does not work.
Assignments submitted via email will not be accepted.
They only way an assignment will be submitted is via Unix
on or before the due date.
You may submit an assignment as many times as you want
.E= BEFORE
the due date in order to ensure that something is submitted
if there are last minute problems.
.H 1 "Miscellaneous"
This section applies to 
.E= all
labs and programs submitted during the quarter.
If you choose to do pair programming,
read the requirements in the subdirectory of the syllabus.
.P
The
.V= README
file should contain your name and username,
the name of the host you used to do the development,
and any other necessary comments, such as the source of
any code you did not write yourself.
To find out the name of the host you are currently using,
use the command
.V= hostname .
.P
You must also follow some basic source code formatting requirements
that are checked up on by the script
.V= checksource .
You can locate it in the same manner as you did
.V= cid
above.
.E= "Reading assignment\(::"
.V= \*[COURSEDIR]/Coding-style/ .
.H 1 "Prerequisites\(:) Java and Unix"
This course assumes you have had experience with Java and Unix.
If not, you should read the first seven chapters of 
.E= "Java by Dissection"
.=V [ http://www.lulu.com/javabydissection ]
and begin working with Unix
(you need a Unix reference book).
This paragraph is just a slight roadmap to bring up your Java
skills if you have had a prerequisite course that used C or C++,
or used some operating system other than Unix.
.P
UCSC has a subscription to Safari Books Online
.=V [ http://proquest.safaribooksonline.com/ ],
which is maintained by the O'Reilly publishers
.=V [ http://oreilly.com/ ].
You may read their books online for free,
provided you use a UCSC computer.
Recommended readings\(::
.RI `` "Learning the Unix Operating System" '',
.RI `` "Managing Projects with GNU Make" '',
.RI `` "Java in a Nutshell" ''.
.H 1 "Pair programming"
If you are doing pair programming,
carefully read over the summary in
.V= cmps012b-wm/Syllabus/pair-programming .
Note especially carefully the format of the
.V= PARTNER
file.
Use the
.V= partnercheck
script to check your
.V= PARTNER 
file before submitting it.
.H 1 "What to submit"
Submit the files
.V= \&.cshrc ,
.V= \&.bashrc ,
.V= \&.bash_profile ,
.V= README ,
.V= Makefile ,
and
.V= hello.java .
.P
There is a subdirectory called
.V= \&.score
which contains instructions to the grader.
Note that because it begins with a dot,
it is ``hidden'', and so will not show up as part of the output of the
.V= ls
command,
unless the
.V= -a
option is used.
Similarly,
there is another directory called
.V= \&.files ,
which is also hidden.
Neither of these show up if you are using a browser.
.P
Do
.E= not
submit any of the files generated by the script in this directory.
However, you may want to do a pre-grade in a private directory
of your own in order to guess at what score you might receive.
Look for a similar directory in future labs and programs.
.H 1 "More on \f[CB]rc\f[P] (dot) files"
Figure \*[Figure_BASHRC_SH] (page \*[Page_BASHRC_SH])
shows some commands that you might want to incorporate into your
.V= \[ti]/.bashrc
file.
They show how to customize the environment,
make new convenience commands available,
customize the prompt, etc.
The 
.V= man (1)
pages for
.V= bash (1)
and
.V= tcsh (1)
will provide more information and details.
This section is informational only and is not part of
this lab.
.P
If you are not sure which shell you prefer using,
and your default is
.V= /bin/tcsh ,
you can switch to 
.V= bash
temporarily just by typing the command
.V= bash
at the command prompt.
To permanently make the change,
use the command
.V= chsh .
.P
My suggestion is that you make 
.V= bash
your default shell,
unless you have a strong preference for
.V= tcsh .
Shell scripts are almost exclusively written in 
.V= bash
or
.V= sh ,
and 
.V= make
always calls
.V= /bin/sh
to process its commands.
So if your interactive shell is
.V= bash ,
you only need to know one shell.
And there are a few things that are difficult to do in
.V= tcsh .
.P
Refer to Tom Christiansen's article
``Csh Programming Considered Harmful''\(::
.VTCODE* 1 http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/
.H 1 "\f[CB]RCS\f[P]"
It is a good idea to keep many backup copies of your work.
.V= RCS
is a good utility to keep track of backup copies.
If you don't have backups,
you will have to depend on the IT department
to recover yesterday's copy.
Murphy's law says that the most important changes won't be in
that copy.
The corollary also says that you will lose your files so close
to the due date that IC won't get your backups back to you in time.
In this case, 
you will get a 0 on the assignment for not submitting anything.
.P
Note that the code above has a magic string in it\(::
.V= \[Do]Id\[Do] \|.
These track your development progress.
For the initial checkin, do the following\(::
.DS
.TVCODE 1 "\*[PROMPT] " "mkdir RCS"
.TVCODE 1 "\*[PROMPT] " "ci -zLT -s- -t- -m- -u hello.java"
.TVCODE 1 "RCS/hello.java,v  <--  hello.java"
.TVCODE 1 "initial revision: 1.1"
.TVCODE 1 "done"
.DE
Now you have your initial version.
Look at the 
.V= man
page for
.V= ci
for all of the options.
You will also want to read the
.V= co 
page.
The options were\(::
.V= -zLT
causes the time stamp to be in local time instead of UTC,
.V= -s-
sets the state to \-,
.V= -t-
suppresses the descriptive text,
.V= -m-
suppresses the log message,
and
.V= -u
checks in the file unlocked, thus not destroying the source.
.P
.ne 7v
Unfortunately, 
the file is now read-only,
so you may want to make locking non-strict\(::
.DS
.TVCODE 1 "\*[PROMPT] " "rcs -U hello.java
.TVCODE 1 "RCS file: RCS/hello.java,v"
.TVCODE 1 "done"
.TVCODE 1 "\*[PROMPT] " "chmod u+w hello.java"
.TVCODE 1 "\*[PROMPT] " "ls -la hello.java"
.TVCODE 1 "-rw-r--r--  1 foobar  user  465 Sep 14 18:42 hello.java"
.DE
Oops, you forgot to put your name and username at the top of the file.
Edit the comment on the first line to reflect your name and username.
Every file you submit must have a comment on the first line
with your name and username in it.
Add in your name and username.
Now check in another copy to make a backup.
.DS
.TVCODE 1 "\*[PROMPT] " "ci -zLT -s- -t- -m- -u hello.java"
.TVCODE 1 "RCS/hello.java,v  <--  hello.java"
.TVCODE 1 "new revision: 1.2; previous revision: 1.1"
.TVCODE 1 "done"
.DE
Use 
.V= cat
to look at the new version of your file.
.P
There are some alternatives to
.V= RCS \(::
.V= SCCS
(very old).
.V= CVS
(more flexible but more complicated).
.V= SVN
(some people like using this).
There are also some others.
.H 1 "Recovering lost files"
If you are keeping files in an
.V= RCS
subdirectory,
you may recover them using the
.V= co
command.
For example
.VTCODE* 1 "co -r1.9 hello.java"
will recover version 1.9 of the file
.V= hello.java
from the archive.
.P
To see what versions of
.V= hello.java
you have in the archive, use the command
.VTCODE* 1 "rlog hello.java"
.P
If you want to see the differences between, say, versions 1.7 and 1.11,
use the command
.VTCODE* 1 "rcsdiff -r1.7 -r1.11 hello.java"
.P
Whenever you create a new file, 
either the first or last line should be a comment with the
.V= \[Do]Id\[Do]
code in it, as in
.VTCODE* 1 "// \[Do]Id\[Do]"
After doing this, a check-in will automatically edit it to something
like
.VTCODE* 1 \
"// \[Do]Id: hello.java,v 1.12 2014-03-24 17:32:36-07 - - \[Do]"
which shows the name of the file,
the veersion,
and the date and time of check-in.
The ``-07'' at the end of the time indicates the number of
hours west of Greenwich Mean Time (GMT), 
aka Universal Time Co\[:o]rdinated (UTC).
.DS
\&
.B1
.SP
.ft CR
.nf
.eo
.pso cat -n .files/hello.java | expand
.ec
.fi
.ft R
.SP
.B2
.FG "\f[CB].files/hello.java\f[P]" "" 0 HELLOJAVA
.DE
.DS
\&
.B1
.SP
.ft CR
.nf
.eo
.pso cat -n .files/Makefile | expand
.ec
.fi
.ft R
.SP
.B2
.FG "\f[CB].files/Makefile\f[R]" "" 0 MAKEFILE
.DE
.DS
\&
.B1
.SP
.ft CR
.nf
.eo
.pso cat -n bashrc.sh | expand
.ec
.fi
.ft R
.SP
.B2
.FG "\f[CB]bashrc.sh\f[R]" "" 0 BASHRC_SH
.DE
.FINISH
