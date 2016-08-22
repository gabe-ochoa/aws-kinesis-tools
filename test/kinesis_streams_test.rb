require_relative "../app/kinesis_streams"
require_relative "test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class TestKinesisStream < Test::Unit::TestCase

  def setup
    @name = 'test-kinesis-stream'
    @s3_bucket_name = 'test-s3-bucket'
    @prefix = 'test-app'
    kinesis_options = {
      stub_responses: true
    }
    @kinesis_stream ||= KinesisStream.new(kinesis_options)

  end

  def test_create
    shard_count = 10
    @kinesis_stream.create(@name, shard_count)
  end

  # def test_monitoring_setup
  #
  # end
  #
  # def test_s3_bucket_exists
  #
  # end
  #
  # def method_name
  #
  # end


end
