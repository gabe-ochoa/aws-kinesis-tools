require_relative "../../lib/s3_service"
require_relative "../test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class S3ServiceTest < Test::Unit::TestCase

  def setup
    @name = 'test-firhose-bucket'
    s3_options = {
      stub_responses: {
        list_buckets: {
          buckets: [{name: 'test-firhose-bucket' }] },
        get_object: { body: 's3=firehose-data' },
      }
    }
    @s3_bucket = S3Service.new(s3_options)
  end

  def test_create
    @s3_bucket.create(@name)
  end



end
