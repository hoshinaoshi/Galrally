# -*- encoding: utf-8 -*-
class Tag < ActiveRecord::Base
  scope :get_all, where("ID IS NOT NULL")
end
