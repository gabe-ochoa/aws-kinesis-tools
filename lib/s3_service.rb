require_relative '../app/kinesis'
require_relative '/aws_service'

class S3Service

  def initialize
    AwsService.aws_config
    @s3_bucket = Aws::S3::Client.new(options = {})
  end

  def get_s3_bucket_arn(bucket)

  end

end
