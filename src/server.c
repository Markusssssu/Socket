#include "server.h"

void error(const char *msg) 
{
  perror(msg);
  exit(1);
}

int main(int argc, char *argv[])
{
   if(argc < 2) 
  {
    fprintf(stderr,"Port not provided. Program terminated\n");
    exit(1);
  }
  
  int sockfd, newsockfd, portno, n;
  char buffer[255];

  struct sockaddr_in serv_add, cli_addr;
  socklen_t clilen;

  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if(sockfd < 0) 
  {
    error("Error opening Socket.");
  }

  bzero((char *) &serv_add, sizeof(serv_add));
  portno = atoi(argv[1]);

  serv_add.sin_family = AF_INET;
  serv_add.sin_addr.s_addr = INADDR_ANY;
  serv_add.sin_port = htons(portno);

  if(bind(sockfd, (struct sockaddr *) &serv_add, sizeof(serv_add)) < 0)
    error("Binding failed.");
  
  listen(sockfd, 5);
  clilen = sizeof(cli_addr);

  newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);

  if(newsockfd < 0) 
    error("Error on Accept");

  while(1)
  {
    bzero(buffer, 256);
    n = read(newsockfd, buffer, 255);
    if(n < 0)
      error("Error on reading.");
    printf("Client : %s\n", buffer);
    bzero(buffer, 255);
    fgets(buffer, 255, stdin);

    n = write(newsockfd, buffer, strlen(buffer));  
    if(n < 0) 
      error("Error on Writing");

    int i = strncmp("Bye", buffer, 3);
    if(i == 0) 
    break;

  } 

  close(newsockfd);
  close(sockfd);

  return 0;
}



