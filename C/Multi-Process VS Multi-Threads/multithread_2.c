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
int c=0;
int k=0;
pthread_mutex_t mut=PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mut2=PTHREAD_MUTEX_INITIALIZER;
void *dap (void *cnt);
void *dap2(void *l);


int main (int argc , char *argv[])
{	
	int count = strtol(argv[1],NULL,10);
	t=count;
	int k=argc-2;
	pthread_t id;
	for(int j=0; j<argc-2; j++)
	{	
		//pthread_t id;
		pthread_create(&id,NULL,dap2,(void *) k);
		pthread_create(&id,NULL,dap,(void *) argv[j+2]);		
	}
		
		
pthread_join(id,NULL);
pthread_mutex_destroy(&mut);
pthread_mutex_destroy(&mut2);
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


void *dap2(void *l)
{
	int *myl=(int *) l;
	pthread_mutex_lock(&mut);
	init();
	c++;
	pthread_mutex_unlock(&mut);
	
	pthread_mutex_lock(&mut2);
	if(c==k)
	{pthread_mutex_unlock(&mut2);
	pthread_exit(NULL);}
	
}
