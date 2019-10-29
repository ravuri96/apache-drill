# apache-drill

This is regular light weight apache drill docker image which run in **distributed mode**. This image can be used for any enviroments to spinup a Apache Drill in distributed mode.


## To build image:

Clone the repositeroy build the docker image using the commands below:

```
docker build -t apachedrill:${tag_name_which_you_like} .
```

## To start the docker image:

```
docker-compose up -d
```

After starting up the docker container. verify that all services are running.

copy paste the both links in browser and see all the service are running.
http://localhost/8047- Apache drill ui
