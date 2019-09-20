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
#include <sys/shm.h>

int main (int argc , char *argv[])
{	
	int count = strtol(argv[1],NULL,10);

	//semaphores declaration
	struct sembuf UP = {0,1,0};
	struct sembuf DOWN = {0,-1,0};
	int semphore,semphore2;
	semphore=semget(IPC_PRIVATE,1,0600);
	semphore2=semget(IPC_PRIVATE,1,0660);	
	semop(semphore2,&UP,1);

	//shared memory creation and attach
	int mid = shmget(IPC_PRIVATE,sizeof(int),0630);
	int *shrd = (int*) shmat(mid,NULL,0);
	*shrd=0;


	pid_t child;



	for(int j=0; j<argc-2; j++)
	{	
		

		child=fork();
		


		if(child==0)
		{	
			//init() and check if all init() are done so do UP() to semphore to continue to display section,using DOWN and UP to smphore2 for crit section
			semop(semphore2,&DOWN,1);
			init();
			++(*shrd);
			if(*shrd==argc-2)
			{	
				semop(semphore,&UP,1);
			}
			semop(semphore2,&UP,1);

			
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

			//detach shared memory,destroy shared memory,destroy semphores
			shmdt((void*) shrd);
			shmctl(mid,IPC_RMID,0);
			semctl(semphore2,0,IPC_RMID);
			semctl(semphore,0,IPC_RMID);
			
  return 0;
}
