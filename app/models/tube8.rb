# -*- encoding: utf-8 -*-
class Tube8
  def self.scraping(site, url)
    (1..20).each do |page|
      doc = Nokogiri.HTML(open(url + "&page=" + page.to_s))
      doc.search("div[@style='left:0; top:0; display:inline;']").each do |thumb|
        id = ""
        image_url = ""
        thumb.search("a").each do |a|
          id = a.attributes["href"].value.gsub(/http:\/\/www\.tube8\.com\/asian\//,"")
          image_url = ""
          a.search("img").each do |img|
            image_url = img.attribute("src").value
            break
          end
          break
        end

        next if ScrapingHistory.exists?(movie_id: id, site: TUBE8)
        Review.create!(movie_id: id, thumbnail_url: image_url, site: TUBE8 )
        ScrapingHistory.create!(movie_id: id, site: TUBE8 )
      end
    end
  end
end
