require 'rubygems'
require 'nokogiri'
require 'net/http'
require_relative 'export'

class Scraper

  def initialize
    begin
      load_config
    rescue
      puts "[!] <params.yaml> not found!"
      exit
    end
  end

  def load_config
    @params_config = YAML.load_file('config/params.yaml')
    @topsites      = Array.new
  end

  def get_url
    country = @params_config['topsites_filter']
    countries = YAML.load_file('config/countries.yaml')
    if countries.has_value?country
      return "http://www.alexa.com/topsites/countries/#{country}"
    else
      return "#{@params_config['url']}%s/"
    end
  end

  def get_topsites
    page_rank = @params_config['page_rank']
    url = get_url
    if report_exists?(Export.get_file(
                        @params_config['output_dir'],
                        @params_config['file_type'],
                        @params_config['topsites_filter']))
      puts "[*] Hum... I think it's not necessary to update the topsites list."
      puts "[*] If you want to force update change <force_download> option in <params.yaml>."
      exit
    end
    if page_rank_value_is_valid?(page_rank)
      puts "[>] Downloading the list of top sites..."
      run_scraple(page_rank, url)
      puts "[>] The list of top sites was generated on: <#{@params_config['output_dir']}> directory."
    else
      puts "[!] <page_rank> parameter must be >= 0 and minor then 20."
      exit
    end
  end

  def run_scraple(page_rank, url)
    for i in 0..page_rank
      res = make_request(URI(url % i))
      if res.is_a?(Net::HTTPSuccess)
        clear_response(res.body)
        save_report
      else
        puts "[!] Something went wrong with HTTP request."
        puts "[*] http status code: [#{res.code}]"
      end
    end
  end

  def page_rank_value_is_valid?(page_rank)
    if page_rank >= 0 and page_rank <= 19
      return true
    else
      return false
    end
  end

  def make_request(uri=URI(@params_config['url']))
     res = Net::HTTP.get_response(uri)
     if res.is_a?(Net::HTTPRedirection)
       res = make_request(URI(res.header['location']))
     end
     return res
  end

  def save_report
    Export.save(
      @topsites, @params_config['file_type'],
      Export.get_file(
        @params_config['output_dir'],
        @params_config['file_type'],
        @params_config['topsites_filter']))
  end

  def clear_response(page)
    prepage = Nokogiri::HTML(page)
    prepage.xpath(@params_config['parser_expression']).each do |value|
      @topsites << value.text
    end
  end

  def check_presence_of_daily_report(file)
    if file.empty?
      file = Export.get_file(
              @params_config['output_dir'],
              @params_config['file_type'],
              @params_config['topsites_filter'])
    end
    Dir.glob(file)
  end

  def report_exists?(file)
    if Dir.glob(file).size > 0
      true
    else
      false
    end
  end

end
