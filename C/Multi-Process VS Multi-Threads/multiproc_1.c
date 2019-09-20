#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <sys/ipc.h>
#include <semaphore.h>
#include <sys/sem.h>
#include "util.h"


int main (int argc , char *argv[])
{	
	int count = strtol(argv[1],NULL,10);

	//semaphores declaration
	struct sembuf UP = {0,1,0};
	struct sembuf DOWN = {0,-1,0};
	int semphore;
	semphore=semget(IPC_PRIVATE,1,0600);
	semop(semphore,&UP,1);

	
	pid_t child;


	for(int j=0; j<argc-2; j++)
	{	
		

		child=fork();
		


		if(child==0)
		{	
						
			//dispaly section using DOWN() at the beggining and UP() at the end of crtitical section
			for(int t=0; t<count; t++)
			{
				semop(semphore,&DOWN,1);
				
				
				display(argv[j+2]);

				semop(semphore,&UP,1);
				
			}
			
			exit(0);
		}
		
		
	}


		if(child>0)
		{
				
			waitpid(child,NULL,0);

		}

			//destroy semphore
			semctl(semphore,0,IPC_RMID);
			
  return 0;
}
