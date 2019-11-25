# Apache-drill

Apache drill docker image which run in **distributed mode**. This image can be used for any enviroments to spinup a Apache 

Drill in Distributed mode. Distributed mode needs an external zookeper running available.  

## Getting started 

clone the repository to your local file system.

```
git clone https://github.com/ravuri96/apache-drill.git
cd apache-drill
```

## To build image:

Clone the repo and build the docker image using the commands below:

```
docker build -t apachedrill:latest .
```

## To start the docker image:

```
docker-compose up -d
```

After starting up the docker container. verify that all services are running.

copy paste the link in browser and see all the service are running.
http://localhost/8047- Apache drill ui


## To Pull the Image for dockerhub
  
```
docker pull ravuri96/apache-drill
```
