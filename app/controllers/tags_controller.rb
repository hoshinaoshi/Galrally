# -*- encoding: utf-8 -*-
class TagsController < ActionController::Base
  http_basic_authenticate_with :name => "tags", :password => "pass", :only => [:add]
  layout 'review'
  
  def index
    @page = params[:page] || 1
    @tag_id = params[:tag_id]
    if request.smart_phone?
      @shows = Show.newest.where("site <> #{TOKYOTUBE}").page(@page).per(PER_PAGE)
    else
      @shows = Show.newest.page(@page).per(PER_PAGE)
    end
    @shows = @shows.where(tag_id: @tag_id) if @tag_id.present?
    @tags = Tag.get_all
    render :template => "top/index#{ "_smart_phone" if request.smart_phone?}", :layout => 'contents'
  end

  def add
    name = Digest::MD5.hexdigest( params[:name].to_s )
    pass = Digest::MD5.hexdigest( params[:pass].to_s )

    redirect_to top_index_path and return unless AdminUser.exists?(name: name, pass: pass)
    @shows = Show.get_no_set_tag.limit(PER_PAGE)
    @tags = Tag.get_all
  end

  def create
    tag_id = Tag.where( tag: params[:commit] ).first.id
    Show.update_tag(params[:check], tag_id)
    redirect_to "/tags/add?name=galrally&pass=watasihasitujidesu"
  end

  def show
    @page = params[:page] || 1
    @tag_id = params[:id]
    if request.smart_phone?
      @shows = Show.newest.where("site <> #{TOKYOTUBE}").page(@page).per(PER_PAGE)
    else
      @shows = Show.newest.page(@page).per(PER_PAGE)
    end
    @shows = @shows.where(tag_id: @tag_id) if @tag_id.present?
    @tags = Tag.get_all
    render :template => "top/index#{ "_smart_phone" if request.smart_phone?}", :layout => 'contents'
  end
end
