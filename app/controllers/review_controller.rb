# -*- encoding: utf-8 -*-
class ReviewController < ActionController::Base
  http_basic_authenticate_with :name => "review", :password => "pass", :only => [:index]
  layout 'review'
  def index
    name = Digest::MD5.hexdigest( params[:name].to_s )
    pass = Digest::MD5.hexdigest( params[:pass].to_s )

    redirect_to top_index_path and return unless AdminUser.exists?(name: name, pass: pass)
    @reviews = Review.get_all
  end

  def create
    # 古いものを更新
    Show.update_all(new_flag: false)
    
    # チェックしたものを新着素材として登録。チェックが完了したら全て削除する。
    Review.check(params[:check])
    
    # DELETE_LIMITの件数が超えたら削除
    Show.over_delete

    redirect_to "/"
  end
end
