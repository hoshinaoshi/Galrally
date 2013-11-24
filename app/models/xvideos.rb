# -*- encoding: utf-8 -*-
class Xvideos
  def self.scraping(site, url)
    (0..20).each do |page|
      doc = Nokogiri.HTML(open(url + "/c/day/" + page.to_s + "/asian_woman-32"))
      doc.search("div[@class='thumbBlock']").each do |thumb|
        id = thumb.attribute("id").value.split("_")[1]
        img_tag = thumb.css("img[id='pic_#{id}']")
        if img_tag.blank?
          # 不正文字対策
          thumb.search("script").to_s.encode("UTF-16BE", "UTF-8", :invalid => :replace, :undef => :replace, :replace => '?').encode("UTF-8").split("\'")[1] =~ /http:\/\/.*\.jpg/
          image_url = $&
        else
          img_tag.each do |image|
            image_url = image.attribute("src").value
          end
        end

        next if ScrapingHistory.exists?(movie_id: id, site: XVIDEOS)
        Review.create!(movie_id: id, thumbnail_url: image_url, site: XVIDEOS )
        ScrapingHistory.create!(movie_id: id, site: XVIDEOS )
      end
    end
  end
end
