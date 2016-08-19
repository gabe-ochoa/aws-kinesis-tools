require 'aws-sdk'
require 'json'

module KinesisTools

  def KinesisTools.create_kinesis_stream

  end

  def KinesisTools.check_aws_credentials
    # creds_file_path = ENV['HOME'] + "/.aws/credentials"
    env_found = !(ENV['AWS_ACCESS_KEY_ID'].nil? && ENV['AWS_SECRET_ACCESS_KEY'].nil?)
    file_found = File.exist?(ENV['HOME']+"/.aws/credentials")

    creds_found = file_found || env_found

    if creds_found

      puts "AWS Credentials found!"
    else
      e_message = """
      AWS Credentials files not found in #{ENV['HOME']}.

      Please set the environment variables below:

      export AWS_ACCESS_KEY_ID=<aws_access_key>
      export AWS_SECRET_ACCESS_KEY=<aws_secret_acces_key>
      """
      puts e_message
    end
    creds_hash
  end

  def KinesisTools.start

    # create kinesis stream

    # create lambda function to post to sumo

    # create s3 bucket (if no specified, need a stop check)

    # create kinesis firehose

    # create lambda function to move logs from kinesis to firehose

    # create

  end

end

# start
KinesisTools.start
