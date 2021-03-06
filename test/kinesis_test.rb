require_relative "../app/kinesis_tools"
require_relative "../lib/aws_service"
require_relative "test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class TestKinesisTools < Test::Unit::TestCase

  def setup
    AwsService.aws_config
    @name = 'test-app-name'
    options = { stub_responses: true }
    @toolset = KinesisTools::LoggingToolset.new(options)
  end

  def test_create_full_logging_solution
    kinesis_shard_count = '20'
    s3_bucket = 'test-bucket'
    @toolset.create_full_logging_solution(@name, kinesis_shard_count, s3_bucket)
  end

  def test_create_monitor_alarm
    @toolset.setup_kinesis_stream
  end

  # def test_logging_path_load_test
  #   KinesisTools.logging_path_load_test(File.read("path/to/file"))
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
