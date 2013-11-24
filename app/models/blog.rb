# -*- encoding: utf-8 -*-
class Blog < ActiveRecord::Base
  belongs_to :show
  scope :newest, order("created_at DESC")

  def self.get_prev_next_blog_id( current_id )
    next_id = Blog.select( :id ).where(id: (current_id+1..current_id+10)).order("id ASC").first.try(:id)
    prev_id = Blog.select( :id ).where(id: (current_id-10..current_id-1)).order("id DESC").first.try(:id)
    return prev_id,next_id
  end
end
