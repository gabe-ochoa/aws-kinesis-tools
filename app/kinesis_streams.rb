require_relative "kinesis_tools"
require_relative '../lib/aws_service'

class KinesisStream

  def initialize(options = {})
    AwsService.aws_config
    @stream ||= Aws::Kinesis::Client.new(options)
    @stream_name
  end

  def create(name, shard_count)
    options = {
        stream_name: name, # required
        shard_count: shard_count # required
    }

    @stream.create_stream(options)
  end

  def add_tag(stream_name, tag)
    key = tag.keys
    options = {
      stream_name: stream_name, # required
      tags: { # required
        key.first => tag[key.first]
      }
    }
    @stream.add_tags_to_stream(options)
  end

  def describe_stream(name)

    options = (
      {
      stream_name: name, # required
      }
    )
    @stream.describe_stream(options)
  end

  def describe_shard(name, starting_shard_id)

    options = (
      {
      stream_name: name, # required
      limit: 1,
      exclusive_start_shard_id: starting_shard_id
      }
    )
    @stream.describe_stream(options)['stream_description']
  end

  def split_shard(stream_name, shard_id, starting_hash)
    shard = describe_shard(shard_id)

  end

end
