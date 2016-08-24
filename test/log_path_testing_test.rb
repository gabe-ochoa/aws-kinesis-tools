require_relative "../app/log_path_testing"
require_relative "test_helper"
require "test/unit"
require 'mocha/test_unit'
require 'pry'
require 'webmock/test_unit'

class TestLoadTest < Test::Unit::TestCase

  def setup
    @tester ||= LogPathTesting.new()
    @num_records = "100000"
    @total_time_interval = '60'
    @timeslice = '1'
    @timesliced_data = File.read("test/fixtures/timesliced_data")

    @socket = mock('tcp_socket')
    @socket.stubs(:write)
    @socket.stubs(:remote_address).returns(Addrinfo.tcp('127.0.0.1', 514))
    TCPSocket.stubs(:new).returns(@socket)
  end

  def test_records_per_timeslice
    assert_equal("1666", @tester.records_per_timeslice(@num_records, @total_time_interval, @timeslice))
  end

  # def test_timeslice_data
  #   data_path = "test/fixtures/data.csv"
  #   records_per_slice = '8'
  #   assert_equal(@timesliced_data.gsub("\n",''),
  #     @tester.timeslice_data(data_path, records_per_slice))
  # end

  def test_send_data
    @tester.send_data(@timesliced_data, @socket, @timeslice)
    @socket.expects(:write).with do |received|
        syslog_message = received.lines[1]
        p = SyslogProtocol.parse(syslog_message)
        p.content.end_with?(message) &&
        p.hostname == Socket.gethostname
      end
  end

  def test_socket_open

    tester = LogPathTesting.new
    assert_equal(@socket, tester.socket_open(socket: @socket))

    tester = LogPathTesting.new
    assert_equal(@socket, tester.socket_open(remote_ip_address: '127.0.0.1', remote_ip_port: 8675309))

  end

end


# CSV.open("test/fixtures/data.csv", "wb") do |csv|
#   CSV.read('/Users/gabe/Downloads/search-results-2016-08-24T11-22-07.185-0700.csv')[1..100].each do |row|
#     csv << row
#   end
# end
