require 'yaml'
require 'csv'

class Utils

  def load_yaml(file)
    if file.empty?
      puts "[!] a valid file must be specified."
    else
      YAML.load_file("#{file}")
    end
  end

  def load_csv(file)
    if file.empty?
      puts "[!] a valid file must be specified."
    else
      CSV.read("#{file}")
    end
  end

end
