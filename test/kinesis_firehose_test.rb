require_relative "../app/kinesis_firehose"
require_relative "test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class TestKinesisFirehose < Test::Unit::TestCase

  def setup
    @name = 'test-firehose'
    @s3_bucket_name = 'test-s3-bucket'
    @prefix = 'test-app'
    firehose_options = {
      stub_responses: {
        create_delivery_stream: {
          delivery_stream_arn: 'test-arn'
        }
      }
    }
    @kinesis_firehose = KinesisFirehose.new(firehose_options)
    s3_options = {
      stub_responses: {
        list_buckets: {
          buckets: [{name: 'test-firhose-bucket' }] },
        get_object: { body: 's3=firehose-data' },
      }
    }
    @s3_bucket = Aws::S3::Client.new(s3_options)
  end

  def test_create
    @kinesis_firehose.create(@name, @s3_bucket_name, @prefix)
  end

  def test_get_s3_bucket_arn
    @kinesis_firehose.get_s3_bucket_arn(@s3_bucket_name)
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
