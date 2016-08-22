require_relative "kinesis"
require_relative '../lib/aws_service'

class KinesisFirehose

  def initialize(options = {})
    AwsService.aws_config
    @firehose ||= Aws::Firehose::Client.new(options)
  end

  def create(name, s3_bucket, prefix)
    options = {
      delivery_stream_name: name,
      s3_destination_configuration: {
        compression_format: "ZIP",
        role_arn: "arn:aws:iam:::", # required
        bucket_arn: "arn:aws:s3:::#{s3_bucket}", # required
        prefix: prefix,
        cloud_watch_logging_options: {
          enabled: true
        }
      }
    }

    @firehose.create_delivery_stream(options)
  end


end
