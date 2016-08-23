require_relative "../../lib/cloudwatch_service.rb"
require_relative "../test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'

class CloudWatchServiceTest < Test::Unit::TestCase

  def setup
    @service = 'test-kinesis-stream'
    cloudwatch_options = { stub_responses: true }
    @cloudwatch_client = CloudWatchService.new(cloudwatch_options)
    @metric_options = ({
      alarm_name: 'test-alarm-name', # required
      alarm_description: 'test-alarm-description',
      actions_enabled: false,
      ok_actions: ["ResourceName"],
      alarm_actions: ["ResourceName"],
      insufficient_data_actions: ["ResourceName"],
      metric_name: "MetricName", # required
      namespace: "Namespace", # required
      statistic: "SampleCount", # required, accepts SampleCount, Average, Sum, Minimum, Maximum
      dimensions: [
        {
          name: "DimensionName", # required
          value: "DimensionValue", # required
        },
      ],
      period: 1, # required
      unit: "Seconds", # accepts Seconds, Microseconds, Milliseconds, Bytes, Kilobytes, Megabytes, Gigabytes, Terabytes, Bits, Kilobits, Megabits, Gigabits, Terabits, Percent, Count, Bytes/Second, Kilobytes/Second, Megabytes/Second, Gigabytes/Second, Terabytes/Second, Bits/Second, Kilobits/Second, Megabits/Second, Gigabits/Second, Terabits/Second, Count/Second, None
      evaluation_periods: 1, # required
      threshold: 1.0, # required
      comparison_operator: "GreaterThanOrEqualToThreshold" # required, accepts GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold
    })
  end

  def test_create_metric_alarm
    @cloudwatch_client.create_metric_alarm(@metric_options)
  end

end
