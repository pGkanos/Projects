PART 1:
In the first SHELL all we do is save
the input given by the user, that is, the command. In
then we create a new child using it
fork (). Then we check using if if we are inside
child and if so then using execlp () we execute it
command given by the user as input by taking as argument
in execlp the table containing the user command.


PART 2:
The second question is an extension of the first
is exactly the same elemental difference now
are the various parameters that the user can enter with
his command. To be able to take note of them
these parameters "break" the table by its command
user every time we find a gap with strtoke () and
we pass each resulting string into a separate position of one
So the new position of the new table contains the first one
position the command and its other parameters. Because
we do not know how many parameters the user will enter from
hereafter we will use execvp () in which
we insert the whole table and not just one element of it.
The basic condition is to put NULL in the empty spaces. THE
cd command is executed only if cd is detected in the pattern
and with the help of chdir () we go to
folder that the user enters by simply giving the path name n
just its folder as an argument to chdir ().


PART 3:
In this SHELL there are precisely its capabilities
preceded by the only difference that it supports and
pipes.On implementation now for the new command that will
run after the first because of the pipe we have to fix
a new child using fork () This child will take as
input beyond the user's command and the first output
This is achieved by using pipe ()
separating commands and their parameters break it
input to two strings one before | and one after and after
break each string separately which we find empty and do
exactly the same as the previous question just twice.