# Project 5

## Part 1 - Semantic Versioning

- CD Project Overview
  - (what are you doing, why, what tools)
  
  I am trying to use semantic versioning in conjunction with my Docker image that is being automatically built and pushed to DockerHub as a part of my
workflow. Currently, the image is always tagged with the version `latest` (i.e., no past versions are kept, and they are always overwritten when an updated
image is pushed due to having the same tag). Semantic versioning would allow for all previous and current images to be recorded in DockerHub, in turn
increasing traceability by allowing the user to view changes that have been made over time. `git` `tagging` will be used to generate the tags, and the
`docker/metadata-action` will be used tag the Docker image. Once this has been accomplished, I will set up a webhook to automatically trigger a script
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
