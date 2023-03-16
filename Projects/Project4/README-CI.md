# Project 4

## Part 1 - Dockerize it

- CI Project Overview
  
  I am trying to use a Dockerfile to create a docker image that runs a custom webserver using apache2 (httpd). This is a tedious and time-consuming process to complete manually every time a webserver is to be run on a system, and efficiency can be raised by taking the time to create a docker image once and reusing it when a webserver is to be run. The reason for using a Dockerfile is to automate the process of the creating a docker image as the number of commands needed can be quite large and the commands themselves quite long. In addition, a Dockerfile allows commands to be modified relatively easily since it can just be re-run without having to manually run all the commands again.

- Run Project Locally
  - how to install docker + dependencies (WSL2, for example)

    Installed [Docker Desktop for Mac with Intel chip](https://docs.docker.com/desktop/install/mac-install/)

  - how to build the container from the `Dockerfile`

    Ran `docker build -t proj4-webserver .` in my `Project4` directory

  - how to run the container

    `docker run -d --name proj4-webserver1 -p 80:80 proj4-webserver`

  - how to view the project running in the container (open a browser...go to IP and port...)
  - Resources

    [httpd](https://hub.docker.com/_/httpd)  
    [How to dockerize Apache httpd websites example](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-dockerize-Apache-httpd-web-servers)
