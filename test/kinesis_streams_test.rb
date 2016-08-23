require_relative "../app/kinesis_streams"
require_relative "test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class TestKinesisStream < Test::Unit::TestCase

  def setup
    @stream_name = 'test-kinesis-stream'
    @s3_bucket_name = 'test-s3-bucket'
    @prefix = 'test-app'
    kinesis_options = {
      stub_responses: {
        describe_stream: {
          stream_description: {
            stream_name: @stream_name,
            stream_arn: "arn:aws:kinesis:us-east-1:567022000440:stream/#{@stream_name}",
            stream_status: 'ACTIVE',
            shards: [
                {
                    shard_id: 'shardId-000000000000',
                    hash_key_range: {
                        ending_hash_key: '42535295865117307932921825928971026431',
                        starting_hash_key: '0'
                    },
                    sequence_number_range: {
                        starting_sequence_number: '49554816019839546338267739039111513545506971070331092994'
                    }
                },
                {
                    shard_id: 'shardId-000000000001',
                    hash_key_range: {
                        ending_hash_key: '85070591730234615865843651857942052863',
                        starting_hash_key: '42535295865117307932921825928971026432'
                    },
                    sequence_number_range: {
                        starting_sequence_number: '49554816019861847083466269662253049263779619431837073426'
                    }
                }
                ],
            has_more_shards: true,
            retention_period_hours: 123,
            enhanced_monitoring: [
                {
                    shard_level_metrics: [
                        "IncomingBytes", "IncomingRecords", "OutgoingBytes", "OutgoingRecords", "WriteProvisionedThroughputExceeded", "ReadProvisionedThroughputExceeded", "IteratorAgeMilliseconds", "ALL"
                    ]
                },
            ]
          }
        }
      }
    }
    @kinesis_stream ||= KinesisStream.new(kinesis_options)
    @ending_key_hash = "340282366920938463463374607431768211455"
    @starting_key_hash = "297747071055821155530452781502797185024"
    @shard_id = 'shardId-000000000000'
  end

  def test_create
    shard_count = 10
    @kinesis_stream.create(@stream_name, shard_count)
  end

  def test_add_tag
    tag = { 'Foo' => 'bar' }
    @kinesis_stream.add_tag(@stream_name, tag)
  end

  def test_split_shard
    @kinesis_stream.split_shard(@stream_name, @shard_id)
  end

  def test_describe_stream
    @kinesis_stream.describe_stream(@stream_name)
  end

  def test_describe_shard
    kinesis_options = {
      stub_responses: {
        describe_stream: {
          stream_description: {
            stream_name: @stream_name,
            stream_arn: "arn:aws:kinesis:us-east-1:567022000440:stream/#{@stream_name}",
            stream_status: 'ACTIVE',
            shards: [
                {
                    shard_id: 'shardId-000000000000',
                    hash_key_range: {
                        ending_hash_key: '42535295865117307932921825928971026431',
                        starting_hash_key: '0'
                    },
                    sequence_number_range: {
                        starting_sequence_number: '49554816019839546338267739039111513545506971070331092994'
                    }
                }
              ],
            has_more_shards: true,
            retention_period_hours: 123,
            enhanced_monitoring: [
                {
                    shard_level_metrics: [
                        "OutgoingBytes", "OutgoingRecords", "WriteProvisionedThroughputExceeded", "ReadProvisionedThroughputExceeded", "IteratorAgeMilliseconds"
                    ]
                }
            ]
          }
        }
      }
    }
    @kinesis_stream = KinesisStream.new(kinesis_options)
    @kinesis_stream.describe_shard(@stream_name, @shard_id)
  end

  def test_get_new_starting_hash_key
    assert_equal('21267647932558653966460912964485513215',@kinesis_stream.get_new_starting_hash_key(@stream_name, @shard_id))
  end

  def test_split_all_shards
    @kinesis_stream.split_all_shards(@stream_name)
  end

  def get_stream_status
    assert_equal('ACTIVE',(@kinesis_stream.get_stream_status(@stream_name)))
  end

  def test_enable_enhanced_monitoring
    @kinesis_stream.enable_enhanced_monitoring(@stream_name)
  end

end
