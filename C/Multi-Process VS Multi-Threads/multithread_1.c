#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <sys/ipc.h>
#include "util.h"
#include <pthread.h>

int t;
pthread_mutex_t mut=PTHREAD_MUTEX_INITIALIZER;

void *dap (void *cnt);



int main (int argc , char *argv[])
{	
	int count = strtol(argv[1],NULL,10);
	t=count;
	int k=argc-2;
	pthread_t id;
	for(int j=0; j<argc-2; j++)
	{	
		//pthread_t id;
		pthread_create(&id,NULL,dap,(void *) argv[j+2]);
		
	}

pthread_join(id,NULL);
pthread_mutex_destroy(&mut);

 return 0;
}


void *dap(void *cnt)
{
	
	char *mycnt=(char *)cnt;
	
	for(int x=0; x<t; x++)
	{
	pthread_mutex_lock(&mut);
	display(mycnt);
	pthread_mutex_unlock(&mut);
	}
	pthread_exit(NULL);
		
}



