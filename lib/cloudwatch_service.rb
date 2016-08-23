require_relative '../app/kinesis_tools'
require_relative './aws_service'

class CloudWatchService

  def initialize(options = {})
    AwsService.aws_config
    @alarm_client = Aws::CloudWatch::Client.new(options)
  end

  def create_metric_alarm(options)
    # Options:
    # http://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_PutMetricAlarm.html
    @alarm_client.put_metric_alarm(options)
  end

end
