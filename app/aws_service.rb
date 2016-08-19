require_relative 'kinesis'

class AwsService

  def initialize

  end

  def self.check_aws_credentials
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
  end

  def self.aws_config
    Aws.config.update({
      region: ENV['AWS_REGION'] || 'us-east-1',
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    })
  end

end
