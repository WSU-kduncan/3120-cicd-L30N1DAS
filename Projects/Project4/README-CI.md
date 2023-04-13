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

  - how to view the project running in the container
    
    Searched `localhost`, `localhost:80`, `127.0.0.1`, or `127.0.0.1:80` in Chrome:
    
    <img width="1440" alt="Screen Shot 2023-03-16 at 2 51 19 AM" src="https://user-images.githubusercontent.com/77419369/225537643-f740fe36-ad2a-4fc5-9ad0-3a2dbd15db08.png">

  - Resources

    [httpd](https://hub.docker.com/_/httpd)  
    [How to dockerize Apache httpd websites example](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-dockerize-Apache-httpd-web-servers)
    
## Part 2 - GitHub Actions and DockerHub

- Process to create public repo in DockerHub

  After creating an account and logging into DockerHub, click the `Repositories` button at the top. Then, click the blue `Create repository` button toward the top right. Enter a Name and Description in the appropriate fields. The name I entered was `ceg3120-proj4`, and the description I entered was `Repository for Project 4 of CEG 3120`. Click `Create`.
  
- How to authenticate with DockerHub via CLI using Dockerhub credentials
  - what credentials would you recommend providing?

  Since access tokens provide greater security than a password due to the ability to limit what permissions they allow and the fact that these tokens can be revoked at any time, it would be ideal to use one as a DockerHub credential. To create one, click on your username toward the top right and select `Account Settings`. Click `Security` in the choices at the left. Click the blue `New Access Token` button. Enter an Access Token Description and choose the Access permissions. Click `Generate`. The Access Token Description I entered was `MacBook Pro` to identify the device for which the token was made, and the Access Permissions I chose were `Read, Write, Delete` as I needed `Read & Write` at the very least to be able to push my image to my repository and included `Delete` as well because I was not sure if I would mess up and need to redo something. Copy the provided personal access token and save it somewhere secure. I pasted it in a file in my `~/.ssh` directory because that's generally where I keep my other secrets.
  
  To authenticate with DockerHub via CLI using the token just generated, first open a terminal. Then, enter the command `docker login`. When prompted for a Username, enter your DockerHub account username. I entered `l30n1das`. When prompted for a Password, paste your token. I got mine from my file in `~/.ssh` and pasted it in.
  
- How to push container image to Dockerhub (without GitHub Actions)

  Ran `docker tag proj4-webserver:latest l30n1das/ceg3120-proj4:1.0` to tag my image to my repository  
  Ran `docker push l30n1das/ceg3120-proj4:1.0` to push the image to my repository
  
- Configuring GitHub Secrets
  - How to set a secret
  - What secret(s) are set for this project
    - Note: do not copy paste your secrets into your documentation

  To set a secret in GitHub at the repository level, click `Settings` at the top of the page while viewing the repository. On the left side, scroll down to the `Security` section and click `Secrets and variables` followed by `Actions`. Click `New repository secret` while on the `Secrets` tab. Enter a Name and paste the Secret into the appropriate fields. Click `Add secret`.
  
  In my case, I set two secrets for this project: one named `DOCKER_USERNAME` that contains my DockerHub account username and the other named `DOCKER_PASSWORD` that contains my `MacBook Pro` Docker token.
  
- Behavior of GitHub workflow
  - what does it do and when
  - what variables in workflow are custom to your project
    - think may need to be changed if someone else is going to use it or you reuse it

  My `proj4` workflow builds an image from the Dockerfile in this directory and pushes that image to DockerHub. It triggers whenever a push is made to the `main` branch of this GitHub repository. The custom variables in my workflow that may need to be changed on a case by case basis besides `name` are the following: `username`, `password`, `images`, `context`, and `tags`.

- Resources

  [Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)  
  [GitHub - publishing images to DockerHub](https://docs.github.com/en/actions/guides/publishing-docker-images#publishing-images-to-docker-hub)  
  [Solution for Docker issue failed to solve: rpc error: code = unknown desc](https://ayeshalshukri.co.uk/category/guides/docker-error-failed-to-solve-with-frontend-dockerfile/)  
  [Github Actions: unable to prepare context](https://stackoverflow.com/questions/60936555/github-actions-unable-to-prepare-context-unable-to-evaluate-symlinks-in-docker)  
  [GitHub Actions - Docker Docs](https://docs.docker.com/ci-cd/github-actions/)

## Part 3 - Diagramming

In the diagram below, some of the edges are colored to reflect their priority. That is, if a node has multiple edges emanating from it and one path must be completed before another, both edges will be colored. Red is used to indicate highest priority (i.e., paths that must be completed first), yellow is used to indicate medium priority (i.e., paths that must be completed second), and green is used to indicate lowest priority (i.e., paths that must be completed last). Black edges indicate paths that are independent of any other paths and can be traversed at any time.

The diagram below is also specific to my project and workflow. For example, it currently reflects the idea that a push must be made to the GitHub repository for the workflow to be triggered. Other events can do so as well, however. Because I did not use them, I did not include them in my diagram to maintain simplicity.

<img width="592" alt="Screen Shot 2023-03-29 at 12 29 12 PM" src="https://user-images.githubusercontent.com/77419369/228606023-7c6b4840-a977-4b11-bc2d-2620a4200c9c.png">

Resources

[yEd](https://www.yworks.com/products/yed)
