# Project 5

## Part 1 - Semantic Versioning

- CD Project Overview
  - (what are you doing, why, what tools)
  
  I am trying to use semantic versioning in conjunction with my Docker image that is being automatically built and pushed to DockerHub as a part of my
workflow. Currently, the image is always tagged with the version `latest` (i.e., no past versions are kept, and they are always overwritten when an updatedimage is pushed due to having the same tag). Semantic versioning would allow for all previous and current images to be recorded in DockerHub, in turn increasing traceability by allowing the user to view changes that have been made over time. `git` `tagging` will be used to generate the tags, and the `docker/metadata-action` will be used to tag the Docker image. Once this has been accomplished, I will set up a webhook to automatically trigger a script
that pulls the most recent Docker image and uses it to build a container whenever the workflow to update the image is triggered. Currently, the user must
pull the image and build the container using it manually every single time the image is updated. Using a webhook would automate the process and save the
user time.

- How to generate a `tag` in `git` / GitHub

  First, add your changes using `git add <file_names>`. Then, commit the changes using `git commit`. Then tag the commit using `git tag -a v#.#.#`. Finally to push the tagged commit, use `git push origin v#.#.#`.
  
- Behavior of GitHub workflow
  - what does it do and when

  The GitHub workflow is triggered whenever a push is made to the `main` branch or a tagged commit is pushed. It builds a new Docker image from the Dockerfile in this repository and pushes it to DockerHub. The image in DockerHub will be tagged with `latest`, the full version number (major, minor, and patch), and a shortened version number (major and minor).
  
- Link to Docker Hub repository (as additional proof)

  DockerHub Repo: [l30n1das/ceg3120-proj4](https://hub.docker.com/repository/docker/l30n1das/ceg3120-proj4/general)

### Resources

- [GitHub - docker/metadata-action](https://github.com/docker/metadata-action)
- [Docker - Manage Tag Labels](https://docs.docker.com/build/ci/github-actions/manage-tags-labels/)

## Part 2 - Deployment

- How to install Docker to your instance

  ```bash
  sudo apt-get remove docker docker-engine docker.io containerd runc
  
  sudo apt-get update
  
  sudo apt-get install \
    ca-certificates \
    curl \
    gnupg
    
  sudo mkdir -m 0755 -p /etc/apt/keyrings
  
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  
  echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  sudo apt-get update
  
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  
  sudo docker run hello-world
  ```
  
- Container restart script
  - Justification & description of what it does
  - Where it should be on server (if someone were to use your setup)

  The container restart script stops the currently running container, removes it, pulls the latest image from the Docker repository, and runs a new container with that image. Because this process has to be completed every single time an update is made to the image, it can become rather time consuming and tedious. Scripting it, however, increases efficiency as the number of commands to be run manually is significantly reduced. Furthermore, using a script collects all the commands that need to be run in one location, simplifying completely automating the process via webhooks. Ideally, `root` should be the owner of the script; and it should be placed somewhere accessible only by `root` as the script should only be executable by admins (who would already have access to the `root` user). I personally put it in `/etc/scripts/` as that is where other configuration files can be found.
  
- Setting up a `webhook` on the server
  - How to install [adnanh's `webhook`](https://github.com/adnanh/webhook) to server
  - How to start the `webhook`
    - since our instance's reboot, we need to handle this

  Ran `sudo apt-get install webhook`
  
  Created `/etc/systemd/system/webhook.service`. It is a service (i.e. it is run whenever the system starts up) that automatically starts the webhook.
  
  Created `/etc/webhook/hooks.json`. It contains details about the webhook as well as the path of the script to be executed when it is triggered.
  
  Previously created `/etc/scripts/restart.sh`. It is the script ran when the webhook is triggered. It recreates a docker container with the pulled image.
  
  `journalctl -xfe _SYSTEMD_UNIT=webhook.service` can be run to view the logs.
  
  These files can be found with the `deployment` directory.
  
- `webhook` task definition file
  - Description of what it does
  - Where it should be on server (if someone were to use your setup)
- How to configure GitHub OR DockerHub to message the listener 
- RECORD your whole workflow process - from `commit` and `push` to your server getting a fresh image

### Resources

- [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [adnanh's `webhook`](https://github.com/adnanh/webhook)
- [CI/CD with Webhook: Webhook service](https://hub.analythium.io/docs/shinyproxy-webhook/#:~:text=system%20prune%20%2Df-,Webhook%20service,-%23)
- [Using GitHub actions and `webhook`s](https://levelup.gitconnected.com/automated-deployment-using-docker-github-actions-and-webhooks-54018fc12e32)
- [Using DockerHub and `webhook`s](https://blog.devgenius.io/build-your-first-ci-cd-pipeline-using-docker-github-actions-and-webhooks-while-creating-your-own-da783110e151)
  - Note: this has been the method focused on in lecture
