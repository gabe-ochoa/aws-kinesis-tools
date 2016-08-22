require_relative "../../app/kinesis"
require_relative "../test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class S3ServiceTest < Test::Unit::TestCase

  def setup
    s3_options = {
      stub_responses: {
        list_buckets: {
          buckets: [{name: 'test-firhose-bucket' }] },
        get_object: { body: 's3=firehose-data' },
      }
    }
    @s3_bucket = S3Service.new(s3_options)
  end

  def test_get_s3_bucket_arn


  end



end
