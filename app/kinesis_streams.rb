require_relative "kinesis_tools"
require_relative '../lib/aws_service'

class KinesisStream

  def initialize(options = {})
    AwsService.aws_config
    @stream ||= Aws::Kinesis::Client.new(options)
    @stream_name
  end

  def create(stream_name, shard_count)
    options = {
        stream_name: stream_name, # required
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

  def describe_stream(stream_name)

    options = (
      {
        stream_name: stream_name, # required
      }
    )
    @stream.describe_stream(options)
  end

  def describe_shard(stream_name, starting_shard_id)

    options = (
      {
        stream_name: stream_name, # required
        limit: 1,
        exclusive_start_shard_id: starting_shard_id
      }
    )
    @stream.describe_stream(options)['stream_description']
  end

  def split_shard(stream_name, shard_id)
    options = (
      {
        stream_name: stream_name, # required
        shard_to_split: shard_id, # required
        new_starting_hash_key: get_new_starting_hash_key(stream_name, shard_id), # required
      }
    )
    @stream.split_shard(options)
  end

  def get_new_starting_hash_key(stream_name, shard_id)
    shard_info = describe_shard(stream_name, shard_id)
    old_ending_hash_key = shard_info['shards'][0]['hash_key_range']['ending_hash_key']
    new_starting_hash_key = old_ending_hash_key.to_i/2
    new_starting_hash_key.to_s
  end

end
