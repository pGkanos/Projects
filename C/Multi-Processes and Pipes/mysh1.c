#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

int main (int argc , char *argv[])
{	
	
	char inp[256];
	char ex[] = "exit";
	
		
	do{
		
		pid_t newpid = fork();
		if (newpid<0)
		{
			printf("error\n");
			exit(0);
			
		}
		else if (newpid==0)
		{
			
			execlp(inp,inp,NULL);
			exit(0);
		}
		else
		{
		

			wait(NULL);
			
			
		}
		printf("$ ");
		scanf("%s",inp);

	}while (strcmp(ex,inp)!=0);




	return 0;
}
