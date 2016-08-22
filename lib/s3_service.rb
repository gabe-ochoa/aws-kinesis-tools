require_relative '../app/kinesis'
require_relative './aws_service'

class S3Service

  def initialize(options = {})
    AwsService.aws_config
    @s3_client = Aws::S3::Client.new(options = {})
  end

  def create(bucket)

    bucket_options = {
      acl: "private", # accepts private, public-read, public-read-write, authenticated-read
      bucket: bucket, # required
      grant_full_control: "GrantFullControl",
      grant_read: "GrantRead",
      grant_read_acp: "GrantReadACP",
      grant_write: "GrantWrite",
      grant_write_acp: "GrantWriteACP"
    }

    @s3_client.create_bucket(bucket_options)
  end

end
