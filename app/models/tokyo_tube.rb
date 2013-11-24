# -*- encoding: utf-8 -*-
class TokyoTube
  def self.scraping(site, url)
    (1..20).each do |page|
      doc = Nokogiri.HTML(open(url + "?page=" + page.to_s, "Accept-Encoding" => "utf-8"))
      doc.search("div[@class='video_box']").each do |thumb|
        thumb.search("a").each_with_index do |a,i|
          break if i == 1
          a.attribute("href").value =~ /\/\d+\//
          id = $&.gsub("/","")
          
          img_tag = a.search("img")
          image_url = img_tag.attribute("src").value
        
          next if ScrapingHistory.exists?(movie_id: id, site: TOKYOTUBE)
          Review.create!(movie_id: id, thumbnail_url: image_url, site: TOKYOTUBE )
          ScrapingHistory.create!(movie_id: id, site: TOKYOTUBE )
        end
      end
    end
  end
end
