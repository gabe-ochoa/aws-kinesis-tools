# Kinesis Tools

This is a ruby cli tool for interacting with Amazon Kinesis and Amazon Kinesis Firehose.

It was build to be an automated tool for setting up new applications with a full
  logging solution that includes storage and offloading to other 3rd-party tool
  query tools over http.
                              -> Lambda -> HTTP  
      App -> Kinesis Stream -
                              -> Lambda -> Firehose Stream -> S3

Automated tasks:
- Create a Kinesis Stream (TODO)
- Increase the shard count of a Kinesis Stream
- Create a Lambda function to pull from a Kinesis stream and send to an HTTP
    endpoint (TODO)
- Create Kinesis Firehose Delivery Stream pointed to a S3 bucket (TODO)
- Create a Lambda function to pull from a Kinesis Stream and send to a Firehose
    Delivery Stream (TODO)

Dependancies:
- [AWS CLI Tool](https://aws.amazon.com/cli/)
- Lambda HTTP
- [AWS Lambda Streams to Firehose](https://github.com/awslabs/lambda-streams-to-firehose)

The Lambda HTTP function expects Kinesis records that are logs adhering to
  the syslog protocol (RFC 5424)[https://tools.ietf.org/html/rfc5424].
