#!/usr/bin/ruby
# -*- encoding: utf-8 -*-
require "open-uri"
class Scraping
  def self.do
    SCRAPING_URL.each do |site,url|
      case site
      when TOKYOTUBE
        TokyoTube.scraping(site, url)
      when SPANKWIRE
        Spankwire.scraping(site, url)
      when TUBE8
        Tube8.scraping(site, url)
      when XVIDEOS
        Xvideos.scraping(site, url)
      when ASG
        Asg.scraping(site, url)
      end
    end
  end
end
