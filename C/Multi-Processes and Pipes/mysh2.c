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
	char *split[50]={NULL};
	int i = 0;	
	

		
	do{
		
		pid_t newpid = fork();


		if (newpid<0)
		{
			printf("error\n");
			exit(0);
			
		}
		else if (newpid==0)
		{
			execvp(split[0],split);
			exit(0);
		}
		else
		{
			wait(NULL);
		}
		
		
		printf("$ ");
		scanf("%[^\n]%*c",inp);
		
		char *tk = strtok(inp," ");
			
		while (tk!=NULL)
		{
			split[i]=tk;			
			i++;
			tk=strtok(NULL," ");
		}

		for ( int k=i; k<50; k++)
		{
			split[k]=NULL;		
		}

		i=0;

		if(strcmp(split[0],"cd")==0)
		{
			chdir(split[1]);
		}

	}while (strcmp(ex,inp)!=0);




	return 0;
}
