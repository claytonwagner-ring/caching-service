# Steps to build and run Caching Service

# Dockerfile
This file is used to build a Docker image to run caching service and pushed to Docker hub using Drone pipeline
The following environment variables are mentioned in the Dockerfile
- REDIS_URL: Redis_url of the app hosted on heroku
- REDIS_PASSWORD: Redis_password of the app hosted on heroku
- REDIS_PORT: Redis_port of the app on Heroku
- SERVER_PORT: An environment variable for the PORT

# Deploy.sh
Shell Script to install heroku-cli, create an app on Heroku, install heroku-redis-plugin, add redis add-on to the created app, and configure redis

# .drone.yml
A pipeline script for drone to build and publish Docker Image from Dockerfile to Docker Hub and to deploy the docker image to Heroku when changes are pushed to master branch.

# STEPS
1. Set up accounts on Heroku, Drone.io, and GitHub
2. Link your GitHub with drone and drone does a sync of repositories, activate the specific repository for drone ci builds
3. Run the Deploy.sh to install heroku-cli, create app, install heroku-redis plugin, add redis add-on to app and get the Redis_url of the app hosted on the heroku
4. Configure the obtained parameters(redis_url, redis_password, redis_port), and server_port as build arguments in drone pipeline (.drone.yml) which get's exposed as environment variables in the container and used by cachingservice.py to connect to the redis service running on heroku. 
5. commit the files to GitHub, drone triggers a pipeline which builds the Dockerfile and pushes to Dockerhub which later gets deployed to heroku
