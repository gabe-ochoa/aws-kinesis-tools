require 'aws-sdk'
require 'json'
require 'kinesis_firehose'
require 'kinesis_streams'

module KinesisTools

  class LoggingDeploy

    def initialize

    end

    def create_full_logging_solution(app_name,
        kinesis_shard_count = {},
        s3_bucket,
      )

      # create kinesis stream
      stream = KinesisStream.new
      stream.create(app_name + '-stream', kinesis_shard_count)

      # create lambda function to post to sumo

      # create kinesis firehose
      firehose = KinesisFirehose.new
      firehose.create(app_name + '-stream', s3_bucket, app_name)

      # create lambda function to move logs from kinesis to firehose

      # create monitoring

    end

    def monitoring_options

    end

end

# start
# KinesisTools.start
