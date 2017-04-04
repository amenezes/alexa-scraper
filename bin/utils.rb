#!/usr/bin/env ruby
require 'yaml'
require 'csv'

module Utils

  def self.load_yaml(file)
    unless File.exist?(file)
      puts "[!] a valid file must be specified."
    else
      YAML.load_file("#{file}")
    end
  end

  def self.load_csv(file)
    unless File.exist?(file)
      puts "[!] a valid file must be specified."
    else
      CSV.read("#{file}")
    end
  end

end
