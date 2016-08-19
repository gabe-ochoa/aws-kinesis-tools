require_relative "../app/kinesis"
require_relative "test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class TestKinesis < Test::Unit::TestCase

  def setup
    access_key = ENV['AWS_ACCESS_KEY_ID']
    secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']

    @creds_hash = {
      access_key_id: access_key,
      secret_access_key: secret_access_key
    }

  end

  def test_create
    KinesisTools.start
  end

  def test_check_aws_credentials
    creds_hash = {
      access_key_id: 'foo',
      secret_access_key: 'bar'
    }
    assert_equal(creds_hash,KinesisTools.load_aws_credentials)
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
