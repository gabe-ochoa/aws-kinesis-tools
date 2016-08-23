require_relative "kinesis_tools"
require_relative '../lib/aws_service'

class KinesisStream

  def initialize(options = {})
    AwsService.aws_config
    @stream ||= Aws::Kinesis::Client.new(options)
    @stream_name
  end

  def create(stream_name, shard_count = {})

    if shard_count.nil?
      shard_count = 10
    end

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
    @stream.describe_stream(options)['stream_description']
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

  def split_all_shards(stream_name)
    shards = describe_stream(stream_name)['shards']
    shards.each do |shard|
      split_shard(stream_name, shard['shard_id'])
      # logger.info "Waiting for stream to update"
      while get_stream_status(stream_name) == 'UPDATING'
        sleep 5
      end
    end
  end

  def get_stream_status(stream_name)
    stream_status = describe_stream(stream_name)['stream_status']
  end

  def enable_enhanced_monitoring(stream_name)
    options = (
      {
        stream_name: stream_name, # required
        shard_level_metrics: ["ALL"], # required, accepts IncomingBytes, IncomingRecords, OutgoingBytes, OutgoingRecords, WriteProvisionedThroughputExceeded, ReadProvisionedThroughputExceeded, IteratorAgeMilliseconds, ALL
      }
    )
    @stream.enable_enhanced_monitoring(options)
  end

end
