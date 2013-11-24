# -*- encoding: utf-8 -*-
class BlogsController < ActionController::Base
  http_basic_authenticate_with :name => "blogs", :password => "pass", :only => [:add]
  layout 'review'
  
  def index
    @page = params[:page] || 1
    @blogs = Blog.newest.page(@page).per(PER_PAGE)
    @tags = Tag.get_all
    render :layout => 'blogs'
  end

  def add
    name = Digest::MD5.hexdigest( params[:name].to_s )
    pass = Digest::MD5.hexdigest( params[:pass].to_s )
    @page = params[:page] || 1

    redirect_to top_index_path and return unless AdminUser.exists?(name: name, pass: pass)
    @shows = Show.get_no_blogs.page(@page).per(PER_PAGE)
  end

  def create
    show = Show.find(params[:check].keys[0])
    blog = show.build_blog
    blog.title = params[:title]
    blog.content = params[:content]
    blog.save
    show.blog_id = blog.id
    show.save 
    redirect_to "/blogs/add?name=galrally&pass=watasihasitujidesu"
  end

  def show
    id = params[:id]
    @blog = Blog.where(id: id).first
    redirect_to "/" and return if @blog.blank?
    @tags = Tag.get_all

    #前後素材の取得
    @prev_id, @next_id = Blog.get_prev_next_blog_id(@blog.id.to_i)

    render :layout => 'blogs'
  end
end
