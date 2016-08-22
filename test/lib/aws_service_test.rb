require_relative "../../app/kinesis"
require_relative "../test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class AwsServiceTest < Test::Unit::TestCase

  def setup

  end

  def test_check_aws_credentials
    KinesisTools.check_aws_credentials
  end

  def test_check_aws_credentials_not_found
    ENV['AWS_ACCESS_KEY_ID'] = nil
    ENV['AWS_SECRET_ACCESS_KEY'] = nil
    assert_equal(nil, KinesisTools.check_aws_credentials)
  end

  def test_aws_config
    KinesisTools.aws_config()
  end


end
