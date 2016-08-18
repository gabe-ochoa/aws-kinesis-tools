require_relative "../app/kinesis"
require_relative "test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class TestKinesis < Test::Unit::TestCase

  def setup

  end

  def test_create
    KinesisTools.start
  end

  def test_aws_credentials
    KinesisTools.aws_credentials
  end

  def test_load_aws_credentials
    KinesisTools.load_aws_credentials
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
