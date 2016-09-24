require_relative 'bin/scraper'

class Application

  def run
    a = Scraper.new
    a.get_topsites
  end
  
end

app = Application.new
app.run
