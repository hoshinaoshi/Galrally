# -*- encoding: utf-8 -*-
class Spankwire
  def self.scraping(site, url)
    (1..20).each do |page|
      doc = Nokogiri.HTML(open(url + "/categories/Straight/Asian/Submitted/40?page=" + page.to_s ))
      doc.search("div[@class='title-video'] a").each do |thumb|
        id = thumb.attribute("href").value
        img_url = ""
        doc.search("a[@href='"+ id +"'] img").each do |img|
          img_url = img.attribute("src").value
          break
        end
        id =~ /(\d)*\/$/
        id = $&.gsub("/","")
        
        next if ScrapingHistory.exists?(movie_id: id, site: SPANKWIRE )
        Review.create!(movie_id: id, thumbnail_url: img_url, site: SPANKWIRE )
        ScrapingHistory.create!(movie_id: id, site: SPANKWIRE )
      end
    end
  end
end
