#!/bin/sh

docker stop site
docker rm site
docker pull l30n1das/ceg3120-proj4:latest
docker run -d --restart unless-stopped --name site -p 80:80 l30n1das/ceg3120-proj4
