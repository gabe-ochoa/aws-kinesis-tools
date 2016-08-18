require_relative "../app/kinesis_firehose"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class TestKinesisFirehose < Test::Unit::TestCase

  def setup
    @name = 'test-firehose'
    @s3_bucket = 'test-s3-bucket'
    @prefix = 'test-app'
    @kinesis_firehose = KinesisFirehose.new
  end

  def test_create

    @kinesis_firehose.create(@name, @s3_bucket, @prefix)
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
