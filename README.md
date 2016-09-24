## alexa-scraper
[![Build Status](https://travis-ci.org/amenezes/alexa-scraper.svg?branch=master)](https://travis-ci.org/amenezes/alexa-scraper)
<a href="https://codeclimate.com/github/amenezes/alexa-scraper"><img src="https://codeclimate.com/github/amenezes/alexa-scraper/badges/gpa.svg" /></a>
[![Dependency Status](https://gemnasium.com/badges/github.com/amenezes/alexa-scraper.svg)](https://gemnasium.com/github.com/amenezes/alexa-scraper)

### Table of contents
* [Description](#description)
* [Usage](#usage)  
  * [Standard output sample](#standard-output-sample)  
  * [Dependencies](#dependencies)  
  * [Installation](#installation)  
* [Application Structure](#application-structure)
  * [bin](#bin)
  * [config](#config)
  * [output](#output)

### Description
A easy way to scrape top websites indexed by Alexa(c) an Amazon Company in the
world or by the country.  

Can you get top 500 websites global, available daily free by Amazon, or
top 500 websites for any country [available](http://www.alexa.com/topsites/countries).

### Usage:
```bash
$ ruby alexa-scraper.rb -h  

Usage: alexa-scraper.rb [-h] [-o OUTPUT]  

Headers will get all response headers from Alexa top sites.
optional arguments:
  -h, --help                    show this help message and exit.  
  -o OUTPUT, --output FILENAME  filename with list of sites.    
```

#### Standard output sample:  
```bash
$ ruby a-scraper.rb
[>] Downloading the list of top sites <global>...
[>] The list of top sites was generated on: <output> directory.

```
#### Dependencies  

List of dependencies:  
 - [nokogiri](http://www.nokogiri.org/)

#### Installation

```bash
# First install bundler.  
$ gem install bundler

# After just run bundler.
$ bundle install
```

### Application Structure

#### bin
All ruby classes to scrape top websites from Alexa.

#### config
A file that store a set of minimum resources to scrape and control the
behavior of the script.

#### output  
All data scraped from Alexa and saved in JSON or YAML file.  
