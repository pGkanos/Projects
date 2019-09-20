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
	char *cmd1[50]={NULL};
	char *cmd2[50]={NULL};
	int trspp=0;
	int ml;
	do{	
		char inp[256];
		printf("$ ");
		scanf("%[^\n]%*c",inp);
		trspp=0;

		//split sto | gia to input
		char *tk = strtok(inp,"|");
		
		int k=0;
		i=0;
		while (tk!=NULL)
		{
			split[i]=tk;			
			i++;
			tk=strtok(NULL,"|");
		}
		
		for (k=i; k<50; k++)
		{
			split[k]=NULL;		
		}
		

		//cmd1
		char *tk2 = strtok(split[0]," ");
		i=0;
		while (tk2!=NULL)
		{
			cmd1[i]=tk2;
			i++;
			tk2=strtok(NULL," ");	
		}
		while(i<50)
		{
			cmd1[i]=NULL;
			i=i+1;
		}


	
		//cmd2
		char *tk3 = strtok(split[1]," ");
		i=0;
		while (tk3!=NULL)
		{	
			trspp=1;
			cmd2[i]=tk3;
			i++;
			tk3=strtok(NULL," ");	
		}
		while(i<50)
		{
			cmd2[i]=NULL;
			i=i+1;
		}
		
		
		//cd
		if(strcmp(split[0],"cd")==0)
		{
			chdir(split[1]);
		}
		
		
			int fd[2];
			int pipa = pipe(fd);
		
		if(pipa<0)
		{ 
			perror("pipa");
			exit(0);
		}
		
		//child1
		pid_t newpid = fork();
		
		if (newpid<0)
		{
			perror("fork()\n");
			exit(0);
			
		}
		else if (newpid==0)
		{	
			if(trspp==1)
			{
				close(STDOUT_FILENO);
				dup(fd[1]);
				close(fd[0]);
				close(fd[1]);
			}
			execvp(cmd1[0],cmd1);
			exit(0);
		}
		else{	
		newpid = wait(NULL);



		//child2
		pid_t newpid2 = fork();
		if (newpid2<0)
		{
			perror("fork()\n");
			exit(0);
			
		}
		else if (newpid2==0)
		{	

			if(trspp==1)
			{
				close(STDIN_FILENO);
				dup(fd[0]);
				close(fd[0]);
				close(fd[1]);
				
			}
			
			execvp(cmd2[0],cmd2);
			printf("failed\n");
			exit(0);
		}
		else
		{
			waitpid(newpid2,NULL,0);	
		}
		
		}

			
		
		
	}while (strcmp(ex,inp)!=0);




	return 0;
}
