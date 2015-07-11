.so Tmac.mm-etc
.if t .Newcentury-fonts
.INITR* \n[.F]
.SIZE 12 14
.TITLE CMPS-012B Spring\~2014 Program\~2 \
"Editor, Doubly-Linked List"
.RCS "$Id: asg2j-edfile-dllist.mm,v 1.20 2014-04-21 18:04:12-07 - - $"
.PWD
.URL
.GETHN* MAN_EDFILE Header_MAN_EDFILE
.de CMD=LI
.   LI "\f[CB]\\$1\f[P] \f[I]\\$2\f[P]"
.   if !'\\$2'' .br
..
.EQ
delim $$
.EN
.H 1 "Overview"
This assignment will make use of doubly-linked lists in order
to implement a very simple line editor after the style of
.V= ed (1).
Data Structures goals\(::
Experience with linked lists and pointers (references),
and file handling.
.H 1 "Program Specification"
.SETR MAN_EDFILE
We present the program specification in the format of a Unix man page.
.SH=BVL
.MANPAGE=LI "NAME"
edfile \- list text editor
.MANPAGE=LI "SYNOPSIS"
.V= edfile
.=V \|[ -e ]
.RI \|[ filename ]
.MANPAGE=LI "DESCRIPTION"
The
.V= edfile
utility reads in lines from files and stores them in a list.
Editing operations make changes to this list.
Eventually the lines are written out to a file.
.MANPAGE=LI "OPTIONS"
Options may appear in any order and may appear as separate
words on the command line or concatenated together.
All options precede all operands.
.VL \n[Pi]
.V=LI -e
Each command is echo printed when it is read in.
.LE
.MANPAGE=LI "OPERANDS"
All operands are filenames.
When the program begins,
all of the lines from the file given on the command line
is read and inserted into the list.
The current line becomes the last line in the list.
If no filename is specified, 
the list starts out empty.
.MANPAGE=LI "COMMANDS"
After all of the files (if any) have been read in,
.V= stdin
is read.
Each line of
.V= stdin
contains one command which is
applied to the list in various ways.
At end of file, the program stops.
The editor can always get to the first line and last line in the
file in $ O ( 1 ) $ time.
It also maintains a pointer to the current line.
Note that there are
.E= no
spaces between the command letter and its operand when an 
operand is permitted.
Empty lines and lines consisting only of white space are ignored.
.P
.VL \n[Pi]
.CMD=LI # anything
Indicates a comment line.
The command is ignored.
Also, any empty line, or any line consisting only of white space,
is ignored.
.CMD=LI \[Do]
The current line is set to the last line in the list.
The new current line is then printed.
.CMD=LI *
All of the lines in the list are printed.
The current line becomes the last line in the list.
.CMD=LI .
The current line is printed.
.CMD=LI 0
The current line is set to the first line in the list.
The new current line is then printed.
.CMD=LI <
The current line is set to the previous line.
The new current line is then printed.
.CMD=LI >
The current line is set to the following line.
The new current line is then printed.
.CMD=LI a inputline
The text following the letter
.E= a
is inserted
.E= after
the current line.
The line just inserted becomes the current line,
which is then printed.
.CMD=LI d
The current line in the list is deleted.
The next line becomes the current line, if any.
Otherwise the last line becomes the current line.
.CMD=LI i inputline
.br
The text following the letter
.V= i
is inserted
.E= before
the current line.
The line just inserted becomes the current line,
which is then printed.
.CMD=LI r filename
.br
The contents of the specified file are read in and inserted 
.E= after
the current line.
The current line becomes the last line inserted.
An error message is printed if the file can not be accessed.
If the operation succeeded,
the number of lines read in is printed.
.CMD=LI w filename
.br
All of the lines in the file are written to the specified file.
The number of lines written is printed.
An error message is printed if the file can not be created.
.LI \f[I](eof)\f[P]
At end of file, quit the program.
This is not a command\(::
it is recognized via EOF on
.V= stdin .
.LE
.MANPAGE=LI "EXIT STATUS"
The following exit status codes are returned\(::
.VL \n[Pi]
.LI 0
No errors were detected.
.LI 1
Invalid commands or options,
or file access errors were detected.
.LE
.H 1 "The Doubly-Linked List"
You will be using the doubly-linked list class
.V= dllist .
The list keeps a sequence of objects in order by relative position
and has special access to the first and last positions in the list
and also another special position known as the current position.
The methods are\(::
.BVL \n[Pi]
.V=LI "public void setposition (position pos);"
Changes the current position to be one of the places specified\(::
the first or last positions in the list,
or the node immediately previous to or immediately following the
current position.
An attempt to move before the first or after the last position
is silently ignored.
.V=LI "public boolean empty();"
Reports on whether the list contains any elements.
Initially it does not.
.V=LI "public String getitem();"
Returns the object at the current position without changing
anything in the list.
Throws 
.V= java.util.NoSuchElementException
if there are no elements in the list.
.V=LI "public int getposition();"
Returns the relative
numerical position of the current element within the list.
The first element is 0.
Throws
.V= java.util.NoSuchElementException
if there are no elements in the list.
.V=LI "public void delete();"
Deletes the object at the current position and makes the following
object the current object.
If it was the last element that was deleted the current position
is now the new last element.
Throws
.V= java.util.NoSuchElementException
if there are no elements in the list.
.V=LI "public void insert (String item, position pos);"
Inserts a new element into the list at the position given.
The element can be inserted at the first or last positions within
the list or immediately previous to or immediately following
the current element.
The element just inserted becomes the new current element.
Throws an
.V= IllegalArgumentException
if an invalid position code is given.
.LE
.H 1 "Implementation Sequence"
This program is large and consists of multiple source files.
It is very important that you follow an implementation sequence
in order to avoid being overwhelmed by its complexity.
Begin with a small subset of the required implementation
and perform each step in sequence.
Make sure that each step is working before you continue on with
the next step.
.P
.ALX 1 ()
.LI
There is a subdirectory called
.V= test
which contains a Perl program called
.V= edfile.perl .
In order to become familiar with the details of what the assignment
requires, play around with this program after reading the 
.V= man
.substring Header_MAN_EDFILE 0 -4
page (section \*[Header_MAN_EDFILE]) above.
Post bug reports to the class newsgroup.
Java code is provided in the subdirectory
.V= code/ .
Note that your main class must not know anything whatever about
linked lists and your linked list class must not know anything
whatever about files, arguments, or user interaction.
.LI
Start with a program that prints its own name as in
.V= edfile.java .
.LI
A utility class
.V= auxlib ,
with useful functions is provided in
.V= auxlib.java .
Remember that normal output is written to
.V= stdout
and error messages
are written to
.V= stderr .
Also remember that the program has to properly return the system
exit code.
.LI
Normally the name of a program comes from 
.V= argv[0] ,
but Java does not have such a concept,
so we need to perform a hack.
This hack does not work when Java is not kept in a jar.
Instead of the prompt printed by the Perl program, use 
.V= auxlib.program_name() .
.LI
Write code to scan the command line argument list and figure
out the options and operands.
Print a stub message, later to be removed,
which states what options were given and what operands were given.
A stub is just a print statement in place of a function call
later to be added.
.LI
Write code to read lines from
.V= stdin
and parse them.
Use a
.V= switch
statement to select the type of line based on the
first character (use
.V= charAt ),
and print error messages for invalid input.
Note that some commands need operands and some don't.
.LI
Write a function to read in lines from a file and use this
function to read in all lines from all files specified on the
command line.
Print out each line as it is read.
.LI
Integrate the
.V= dllist
class into your program.
Each public method of
.V= dllist
should simply be added with a stub body which does nothing
other than print out its name and arguments.
Run
.V= gmake
to verify that you can construct a proper jar.
.LI
Replace each of the stubs in your main class so that they call
the appropriate functions in the linked list class.
Ignore the read and write commands for now.
.LI
Each of the stubs in the case statement are to be replaced by
a simple function call.
The complexity of the command is in the called function.
.LI
To the linked list class,
add a private static inner class to keep track of the data
and four private fields to keep track of the nodes.
See 
.V= dllist.java .
Note that inner classes, when compiled, produce class files with
compound names connected with a dollar sign.
You need not have make file targets for these,
but they must be placed in the jar file as well as the outer 
classes.
.LI
Unfortunately Java uses a dollar sign in these filenames,
which is also a shell metacharacter as well as a
.V= gmake
metacharacter.
To use a dollar sign
.=V ( \[Do] )
inside a make file, it must be doubled,
and to avoid the shell doing something with it, it must be escaped.
So, to refer to the file
.V= dllist\[Do]node.class ,
you must type
.V= dllist\[rs]\[Do]\[Do]node.class .
See the sample
.V= Makefile ,
which you should modify as appropriate.
.LI
Write the functions
.V= insert
and
.V= getitem ,
ignoring the position.
Always insert at the end of the list.
Instrument your code so that each operation prints a message
as to what it is doing.  
Print out the node and its links.
Since
.V= node
does not have a
.V= toString
method,
it will inherit it from
.V= Object
and hence just print its type and id.
Also write
.V= empty
which is trivial.
.LI
Complete
.V= insert
so that it can function at any position in the list.
Also write
.V= setposition .
In order to check for a valid position code,
use a
.V= switch
statement, with the
.V= default
alternative being the one to throw the exception.
.LI
Write code to track the relative numeric position of the current
element.
Write the function
.V= getposition .
.LI
Write 
.V= delete .
.LI
Go back to your main class and implement the read and write commands.
.LI
Finish off anything else that is missing and submit your program.
Actually, you should submit a version of your program as it
improves with each milestone and check your submit.
Note that if you forget to submit a file or submit the wrong version
of a file, your program will not run and you will lose 50% of
the value of the assignment.
.LE
.H 1 "What to Submit"
Submit the files specified below.
Do not submit any files that should be created by your
.V= Makefile .
Filenames must be exactly as given here.
The first line of every file you submit must state your
name and username in a comment.
The second line must contain a comment which originially
contained the string
.V= \[Do]Id\[Do]
before that string was edited by RCS.
.nr Indentfilename \n[Pi]*3
.nr Indentmaketarget \n[Pi]*2
.VL \n[Indentfilename]
.V=LI README
contains your name and username and a statement of which major
parts of the implementation sequence you have completed,
along with a
.E= brief
note to the grader, if such a note is needed.
.V=LI edfile.java
contains your main function, 
scanning code, and file access code.
.V=LI dllist.java
contains the class
.V= dllist
which implements the data structure.
.V=LI auxlib.java
has been written for you and contains various useful functions
involving error messages, exit codes, etc.
You may modify it as appropriate.
.V=LI Makefile
builds the following targets\(::
.VL \n[Indentmaketarget]
.V=LI all:
must be the first target,
and builds the jar file
.V= edfile .
.V=LI clean:
deletes all files generated by
.V= "make all" .
.V=LI spotless:
depends on 
.V= clean
and deletes the jar file.
.V=LI submit:
submits all of the files specified above.
.V=LI ci:
checks in all source files, including the
.V= README
and
.V= Makefile ,
into an RCS subdirectory.
It may assume the script
.V= cid
is in the path.
.LE
.V=LI PARTNER
If you are doing pair programming, follow the instructions in
.V= Syllabus/pair-programming/ .
Do not submit this file if you are working alone.
.LE
.P
.E= IMPORTANT\(::
After you have submitted your files,
verify that you have submitted all of the necessary files and
that they are all the correct version.
See the syllabus and assignment 1 for details of how to do this.
.FINISH
