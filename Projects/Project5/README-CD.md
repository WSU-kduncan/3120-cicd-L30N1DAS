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
- Behavior of GitHub workflow
  - what does it do and when

### Resources

- [GitHub - docker/metadata-action](https://github.com/docker/metadata-action)
- [Docker - Manage Tag Labels](https://docs.docker.com/build/ci/github-actions/manage-tags-labels/)
