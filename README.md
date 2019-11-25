# Apache-drill


## Apache drill Docker Image running in **Distributed Mode**.

 This image can be used for any enviroments to spinup a Apache Drill in Distributed mode. Distributed mode needs an external zookeper running available.  

**prerequisites**

* Apache Drill
* Apache Zookeeper
* Docker installed
* AWS keys or AWS ec2 instance with Iam role attached with read and list permissions.
* AWS S3 bucket

If you are deploying the apache drill to ec2-instance that has iam role attached the 

**Add the below code to your core-site.xml file before build the Docker Image if your are using AWS IAM role to access s3 storage**

```
<?xml version="1.0" encoding="UTF-8" ?>
<configuration>
<property>
    <name>fs.s3a.aws.credentials.provider</name>
    <value>com.amazonaws.auth.InstanceProfileCredentialsProvider</value>
</property>
<property>
    <name>fs.s3a.endpoint</name>
    <value>s3.amazonaws.com</value>
</property>
<property>
    <name>fs.s3a.impl.disable.cache</name>
    <value>true</value>
</property>
<property>
    <name>fs.s3a.connection.maximum</name>
    <value>100</value>
</property>
</configuration>
```

**If you are using a AWS Secret keys and Access keys then copy down the below config to your core-site.xml file before buiding the Docker Image**

```
<?xml version="1.0" encoding="UTF-8" ?>
<configuration>
<property>
    <name>fs.s3a.access.key</name>
    <value>ENTER-YOUR-ACCESS-KEY</value>
</property>
<property>
    <name>fs.s3a.secret.key</name>
    <value>ENTER-YOUR-SECRET-KEY</value>
</property>
<property>
    <name>fs.s3a.endpoint</name>
    <value>s3.amazonaws.com</value>
</property>
<property>
    <name>fs.s3a.connection.maximum</name>
    <value>100</value>
</property>
</configuration>
```

I am living closer to us-east-1 so my s3 endpoint is **s3.amazonaws.com** check your closer s3 endpoint in [AWS Endpoint Search](https://docs.aws.amazon.com/general/latest/gr/rande.html)



## Getting started 

clone the repository to your local file system.


> git clone https://github.com/ravuri96/apache-drill.git

> cd apache-drill


## To build image:

> Clone the repo and build the docker image using the commands below:


> docker build -t apachedrill:latest .


## To deploy the apache drill docker image:


> docker compose up -d



## verify the deployment

> http://localhost/8047 

Apache drill ui


## To Pull the Image for dockerhub

> docker pull ravuri96/apache-drill


## Fun Part

## Querying data from S3 bucket using apache drill.

- Create a s3 bucket 
- Add the **insurance-data.csv** file in the project to s3 bucket.
- enable s3 storage plugin

To enable s3 stroge plugin 

> http://localhost/8047/storage

```
{
  "type": "file",
  "connection": "s3a://your-bucket-name",
  "config": null,
  "workspaces": {
    "tmp": {
      "location": "/tmp",
      "writable": true,
      "defaultInputFormat": null,
      "allowAccessOutsideWorkspace": false
    },
    "root": {
      "location": "/",
      "writable": false,
      "defaultInputFormat": null,
      "allowAccessOutsideWorkspace": false
    }
  },
  "formats": {
    "psv": {
      "type": "text",
      "extensions": [
        "tbl"
      ],
      "delimiter": "|"
    },
    "csv": {
      "type": "text",
      "extensions": [
        "csv"
      ],
      "extractHeader": true,
      "delimiter": ","
    },
    "tsv": {
      "type": "text",
      "extensions": [
        "tsv"
      ],
      "delimiter": "\t"
    },
    "httpd": {
      "type": "httpd",
      "logFormat": "%h %t \"%r\" %>s %b \"%{Referer}i\"",
      "timestampFormat": null
    },
    "parquet": {
      "type": "parquet"
    },
    "json": {
      "type": "json",
      "extensions": [
        "json"
      ]
    },
    "avro": {
      "type": "avro"
    },
    "sequencefile": {
      "type": "sequencefile",
      "extensions": [
        "seq"
      ]
    },
    "csvh": {
      "type": "text",
      "extensions": [
        "csvh"
      ],
      "extractHeader": true,
      "delimiter": ","
    }
  },
  "enabled": true
}

```

**copy the above configuration and paste it in your s3 storage plugin and update it.**

**We have already defined the AWS credentails or IAM Role in core-site.xml so we dont need to define again in storage plugin configuration**

All configurations are done

## Now go to http://localhost/8047/query

```
select * from s3.`insurance-data.csv`;
```

**Happy Drilling..!!!**