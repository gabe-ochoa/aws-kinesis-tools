require_relative "../app/kinesis_firehose"
require_relative "test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class TestKinesisFirehose < Test::Unit::TestCase

  def setup
    @name = 'test-firehose'
    @s3_bucket = 'test-s3-bucket'
    @prefix = 'test-app'
    options = {
      stub_responses: {
        create_delivery_stream: {
          delivery_stream_arn: 'test-arn'
        }
      }
    }
    @kinesis_firehose = KinesisFirehose.new(options)
  end

  def test_create
    binding.pry
    @kinesis_firehose.create(@name, @s3_bucket, @prefix)
  end

  # def test_get_s3_bucket_arn
  #   @kinesis_firehose.get_s3_bucket_arn(@s3_bucket)
  # end

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
