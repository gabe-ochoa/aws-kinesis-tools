# Kinesis Logging Path Tools

This is a ruby cli tool for interacting with Amazon Kinesis, Kinesis Firehose, S3, and Lambda to create a full monitored logging solution for an application.

It was build to be an automated tool for setting up new applications with a full
logging solution that includes storage and offloading to other 3rd-party tool
query tools over http.

                              -> Lambda -> HTTP  
      App -> Kinesis Stream -
                              -> Lambda -> Firehose Stream -> S3

If the permissions are present, CloudWatch monitoring will be set up for each new resource created.

Automated tasks:
- Create a Kinesis Stream
- Increase the shard count of a Kinesis Stream
- Create a Lambda function to pull from a Kinesis stream and send to an HTTP
    endpoint (TODO)
- Create Kinesis Firehose Delivery Stream pointed to a S3 bucket
- Create a Lambda function to pull from a Kinesis Stream and send to a Firehose
    Delivery Stream (TODO)
- Create CloudWatch Alarms for new resources

Dependancies:
- Lambda HTTP
- [AWS Lambda Streams to Firehose](https://github.com/awslabs/lambda-streams-to-firehose)

The Lambda HTTP function expects Kinesis records that are logs adhering to
  the syslog protocol (RFC 5424)[https://tools.ietf.org/html/rfc5424].

## Task Specs

### Create Kinesis Stream
This will create a kinesis stream with a default of 10 shards.

Usage: ruby kinesis.rb create-kinesis-stream <stream_name> <shard_count>

```
def KinesisStream.create(stream_name, shard_count)

  print stream_name, aws_arn
end

```
Inputs:
- Stream Name
- Initial shard count (optional, default: 10)

Outputs:
- Stream Name
- AWS resource ARN

### Increase the shard count of a Kinesis stream
This will increase the shard count of a Kinesis stream. You can split one shard or the whole stream.

Usage: ruby kinesis.rb split-kinesis-stream <stream_name> <shard_id>

```
def KinesisStream.split(stream_name, shard_id)

  print stream_name, stream_status
end
```

Inputs:
- Stream Name
- Initial shard id (optional)

Outputs:
- Stream Name
- Stream status

### Create a Lambda Function to send Kinesis records to HTTP endpoint
This will create a Lambda Function that reads in and then sends the kinesis records to an http endpoint

Usage: ruby kinesis.rb create-lambda-http <lambda_name> <http_url>

```
def Lambda.create_http(lambda_name, http_url)

  print lambda_name, aws_arn
end
```

Inputs:
- Lambda Name
- HTTP URL

Outputs:
- Lambda Name
- AWS ARN

### Create Kinesis Firehose Delivery Stream pointed to a S3 bucket
This will create a Kinesis Firehose Delivery Stream that is pointed at an S3 bucket with a default firehose prefix of the firehose name.

Usage: ruby kinesis.rb create-firehose-stream <firehose_name> <s3_bucket> <firehose_prefix>

```
def KinesisFirehose.create(firehose_name, s3_bucket, firehose_prefix)

  aws_arn
end
```

Inputs:
- Firehose Stream Name
- S3 Bucket
- Firehose prefix

Outputs:
- Firehose AWS ARN

Known Issues:
- Compression format is currently not set

### Create a Lambda function to pull from a Kinesis Stream and send to a Firehose Delivery Stream
This will create a Lambda Function that reads records from a Kinesis Stream and then sends them to a Firehose Delivery Stream.

Usage: ruby kinesis.rb create-lambda-kinesis-firehose <lambda_name> <kinesis_stream_name> <kinesis_firehose_name>

```
def Lambda.create_kinesis_firehose(lambda_name, kinesis_stream_name, kinesis_firehose_name)

  print lambda_name, aws_arn
end
```

Inputs:
- Lambda Name
- Firehose Name
- Kinesis Stream Name

Outputs:
- Lambda Name
- AWS ARN
