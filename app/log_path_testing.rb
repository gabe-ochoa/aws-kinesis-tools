require 'csv'
require 'socket'

class LogPathTesting

  def initialize

  end

  # def load_testing
  #
  #
  # end

  def send_data(data, socket, send_timeslice)
    # send data to endpoint over tcp
    data.each do |timeslice|
      timeslice.each do |line|
        socket.write(line)
        sleep send_timeslice.to_i/timeslice.count
      end
      sleep send_timeslice.to_i
    end
  end

  def socket_open(options)
    uri = options[:remote_ip_address]
    port = options[:remote_ip_port]
    @socket ||= TCPSocket.new(uri, port)
  end

  def socket_close
    @socket.close
  end

  def records_per_timeslice(total_num_records, total_time_interval, timeslice)
    # number of records sent per second over internval (seconds)
    records_per_slice = total_num_records.to_i/(total_time_interval.to_i/timeslice.to_i)
    records_per_slice.to_s
  end

  def timeslice_data(path_to_data, records_per_slice)
    # takes in data in CSV data and returns an array containing an array of
    # records for each timeslice
    sliced_data = []
    data = CSV.read(path_to_data)
    num_slices = (data.count / records_per_slice.to_i)
    puts "num_slices: #{num_slices}"
    starting_record = 0
    puts "New starting_record: #{starting_record}"
    (1..num_slices).each do |s|
      ending_record = starting_record + records_per_slice.to_i
      puts "New ending_record: #{ending_record}"
      single_slice = []
      data[starting_record...ending_record].each do |record|
        single_slice << record[0]
      end
      starting_record = ending_record + 1
      puts "New starting_record: #{starting_record}"
      sliced_data << single_slice
    end
    sliced_data
  end

end
