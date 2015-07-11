.so Tmac.mm-etc
.if t .Newcentury-fonts
.INITR* \n[.F]
.SIZE 12 14
.TITLE CMPS-012M Winter\~2014 Lab\~9 "Unix programming"
.RCS "$Id: lab9s-unixprog-stat.mm,v 1.2 2014-05-19 16:09:03-07 - - $"
.PWD
.URL
.GETST* insertion_sort Figure_insertion_sort
.H 1 "Overview"
In this lab you will be introduced to a simple Unix systems
programming problem,
namely printing out statistics about files.
We present the program in the form of a Unix
.V= man (1)
page.
You will also need to read 
.V= man
pages as listed.
.SH=BVL
.MANPAGE=LI "NAME"
l9stat \[em] stat a list of files
.MANPAGE=LI "SYNOPSIS"
\f[CB]l9stat\f[R] \|[\f[I]filename\f[R]\|.\|.\|.]
.MANPAGE=LI "DESCRIPTION"
Each argument is a filename whose statistics are to be printed.
If no filenames are given, the current directory
.=V ( . )
is used.
For each file, 
print the mode,
the file size in bytes ,
the file or link modification time,
and the name.
If a file is a symbolic link, 
the value of the link is also printed.
If the time is more than 180 days from the current time,
the month, day, and year are printed,
otherwise, the month, day, and time.
.MANPAGE=LI "EXIT STATUS"
.VL \n[Pi]
.LI 0
No errors were detected.
.LI 1
Errors were detected and messages printed.
.LE
.MANPAGE=LI "SEE ALSO"
.V= ls (1),
.V= man (1),
.V= stat (1),
.V= lstat (2),
.V= readlink (2),
.V= time (2),
.V= localtime (3),
.V= strerror (3),
.V= strftime (3).
.LE
.H 1 "Notes"
To prepare for writing this lab,
read several 
.V= man (1)
pages which describe the system calls and library functions you need to
use.
The number in parentheses indicates the chapter\(::
(1) User commands,
(2) System calls, and
(3) C library functions.
.ALX 1 ()
.GKLI
The commands
.V= ls (1)
and
.V= stat (1)
show information about files.
The Perl program
.V= l9stat.perl
is a reference implementation,
and your program should produce the same output.
.GKLI
Manual pages can be read using the
.V= man (1)
command.
Each man page is in a particular section,
so, for example, the command
.VTCODE* 1 "man -s 3 printf"
can display the man page for 
.V= printf (3).
The number in parentheses indicates the manual section.
.GKLI
You may use the
.V= x
command from 
.V= /afs/cats.ucsc.edu/courses/cmps012b-wm/bin
(in your path)
to display a man page in a new 
.V= xterm \(::
.VTCODE* 1 "x man -s 3 printf &"
.GKLI
The system call
.V= lstat (2)
provides information about a file (or a link, if it is a link).
The information is in a
.V= "struct stat" ,
and you will use the fields 
.V= st_mode ,
.V= st_size ,
and
.V= st_mtime .
The mode is printed as 6 octal digits,
and the size as 9 decimal digits.
.GKLI
If
.V= lstat
fails, print an error message in the standard format and
continue.
.GKLI
The system call
.V= readlink (2)
will return information about the symbolic link,
if the file is a symbolic link.
If it fails,
assume that the file is not a symlink and ignore the failure.
.GKLI
The system call
.V= time (2)
returns the current time in seconds since the Epoch
(Thu Jan 1 00:00:00 1970 UTC)
as a value of type
.V= time_t .
.GKLI
The C library function
.V= localtime (3)
accepts a value of type
.V= time_t ,
and using the local time,
formats it into a
.V= "struct tm"
suitable for printing.
.GKLI
The C library function
.V= strerror (3)
accepts the variable
.V= errno
and returns a suitable formatted string indicating a reason
for a failed system call.
.GKLI
The C library function
.V= strftime (3)
accepts a format string and a
.V= "struct tm"
and returns a string suitable for printing.
Use the format string
.V= "\[Dq]%b\[VS]%e\[VS]%R\[Dq]"
if the time is within 180 days of the current time
(whether in the past or in the future)
and
.V= "\[Dq]%b\[VS]%e\[VS]\[VS]%Y\[Dq]"
if beyond that time.
The symbol
.=V `` \[VS] ''
is a visible space,
which you should type into your program as an ordinary space.
.V= 
.LE
.H 1 "What to submit"
Submit
.V= README ,
.V= Makefile ,
.V= l9stat.c .
Your
.V= Makefile
must build an executable binary called 
.V= l9stat .
Also, if you are doing pair programming,
submit the required pair programming files.
.FINISH
