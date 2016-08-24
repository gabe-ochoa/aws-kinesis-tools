require_relative './kinesis_firehose'
require_relative './kinesis_streams'
require 'aws-sdk'

module KinesisTools

  class LoggingToolset

    def initialize(options = {})
      @firehose ||= KinesisFirehose.new(options)
      @stream = KinesisStream.new(options)
    end

    def create_full_logging_solution(app_name,
        kinesis_shard_count = {},
        s3_bucket
      )

      # create kinesis stream
      @stream.create(app_name + '-stream', kinesis_shard_count)
      # create lambda function to post to sumo

      # create kinesis firehose
      @firehose.create(app_name + '-stream', s3_bucket, app_name)

      # create lambda function to move logs from kinesis to firehose

      # create monitoring

    end

    def create_monitor_alarm

    end

  end

end

# start
# KinesisTools.start
