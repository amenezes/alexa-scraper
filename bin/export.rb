require 'rubygems'
require 'yaml'
require 'csv'
require 'date'

module Export

  def Export.save(data, format, destination)
    @destination = destination
    case format
    when 'csv' then Export.to_csv(data)
    when 'yaml' then Export.to_yaml(data)
      else
        puts "[!] There's no valid file_type options in <params.yaml>"
        exit
    end
  end

  def Export.get_file(directory, file_format, filter)
    date = Time.new.strftime('%Y-%m-%d')
    filename = "#{directory}/topsites_#{filter}_#{date}.#{file_format}"
  end

  private

  def Export.to_csv(data)
    rank_index = 1
    CSV.open(@destination, 'wb') do |csv|
      data.each do |site|
        csv << [rank_index,site]
        rank_index += 1
      end
    end
  end

  def Export.to_yaml(data)
    rank_index = 1
    File.open(@destination, 'w') { |f|
      f.puts "---"
      data.each do |site|
        f.puts "#{rank_index}: #{site}"
        rank_index += 1
      end
    }
  end

end
