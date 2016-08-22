require_relative "kinesis_tools"
require_relative '../lib/aws_service'

class KinesisStream

  def initialize(options = {})
    AwsService.aws_config
    @stream ||= Aws::Kinesis::Client.new(options)
  end

  def create(name, shard_count)
    options = {
        stream_name: name, # required
        shard_count: shard_count # required
    }

    @stream.create_stream(options)
  end

end
