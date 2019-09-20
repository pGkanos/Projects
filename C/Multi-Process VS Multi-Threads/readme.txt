Multiproc_1:
We make a child for every argument we pass
in our program. Every child runs the display ()
but we must be able to control it
one child at a time. This
we succeed with the use of buoys, we commit
that is, the critical piece of code with the user
that we have created in the beginning
program starting with down () and
releasing with up (). Finally we take care of
we destroy the flap we made.

Multiproc_2:
It does exactly that and the above code but
we have introduced init (). To execute first
init () uses shared memory to
we control how many times the processes will run
init () and if init () are as many as argc-2
then we make up () for the display buoy and
then we block the display code like
and before . Note that init () also needs its own
of the buoy so as to avoid parallel
its execution. Finally we destroy all of them
significant.

Multithread_1:
The logic is similar to before just here
uses a function in which init ()
and display (). That's because the threads we make
for each argument they copy its code
function that we will give them by definition
their. To tackle the problem of
run () uses display ()
mutex which we lock before display () and
unlock counts from it. Finally we take care of
we destroy the mutexes.

Multithread_2:
And here the code executes that before but it executes and
init (). We lock and unlock init () to
avoid all of it being executed in parallel
threads. To ensure the completion of
init () before we start display () we create one
second mutex we lock the piece of code
display and only unlock it when it is executed
init () argc-2 times. Finally we destroy everything
mutexes.