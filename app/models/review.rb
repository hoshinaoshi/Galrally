# -*- encoding: utf-8 -*-
class Review < ActiveRecord::Base
  scope :get_all, where("ID IS NOT NULL")

  # 審査処理
  def self.check(check_array)
    check_array.each do |key,value|
      next if value == REVIEW_UN_CHECKED
      review_data = Review.find(key)
      Show.create!(
        movie_id:      review_data.movie_id,
        thumbnail_url: review_data.thumbnail_url,
        site:          review_data.site,
        scraping_flag: SCRAPING_FLAG_ON,
        new_flag:      NEW_FLAG_NEW
      )
    end
    # 審査し終わったものは削除
    Review.destroy_all("ID IS NOT NULL")
  end
end
