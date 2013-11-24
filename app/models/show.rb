# -*- encoding: utf-8 -*-
class Show < ActiveRecord::Base
  has_one :blog
  has_one :tag

  scope :get_all, where("ID IS NOT NULL").order("created_at DESC")
  scope :newest, order("created_at DESC")
  scope :get_scraping_movie, where(scraping_flag: SCRAPING_FLAG_ON)
  scope :get_no_set_tag, where("tag_id IS NULL").order("created_at DESC")
  scope :get_no_blogs, where("blog_id IS NULL").order("created_at DESC")

  # DB要領節約のため、DELETE_LIMIT件を超えたら削除していく。
  def self.over_delete
    shows = Show.get_scraping_movie
    shows_count = shows.length
    if DELETE_LIMIT < shows_count
      # 古い物から削除する。
      delete_data = shows.order("id ASC").limit(shows_count - DELETE_LIMIT).last
      Show.destroy_all("ID <= #{delete_data.id}")
    end
  end
  
  # タグ更新
  def self.update_tag(check_array,tag_id)
    check_array.each do |key,value|
      next if value == REVIEW_UN_CHECKED
      show = Show.find(key)
      show.update_attributes!(tag_id: tag_id)
    end
  end
end
