require_relative "kinesis.rb"

class KinesisFirehose

  def initialize()
    @firehose = Aws::Firehose::Client.new()

    @firehose.config(
      region: ENV['AWS_REGION_NAME'] || 'us-east-1',
      credentials: KinesisTools::aws_credentials
    )

  end

  def create(name, s3_bucket, prefix)

    options = {
      delivery_stream_name: name,
      compression_format: 'GZIP',
      s3_destination_configuration: {
        role_arn: "RoleARN", # required
        bucket_arn: "BucketARN", # required
        prefix: prefix
      },
      cloud_watch_logging_options: {
        enabled: true
      }
    }

    @firehose.create_delivery_stream(options)
  end


end
