# -*- encoding: utf-8 -*-
class Asg
  def self.scraping(site, url)
    (1..20).each do |page|
      doc = Nokogiri.HTML(open(url + "?page=" + page.to_s))
      doc.search("img[@class='shift-left']").each do |thumb|
        image_url = thumb.attribute("src").value.gsub(/\d+$/,"")
        thumb.parent.attribute("href").value =~ /mcd=.*/
        id = $&.gsub("mcd=","")
        
        next if ScrapingHistory.exists?(movie_id: id, site: ASG )
        Review.create!(movie_id: id, thumbnail_url: image_url, site: ASG )
        ScrapingHistory.create!(movie_id: id, site: ASG )
      end
    end
  end
end
