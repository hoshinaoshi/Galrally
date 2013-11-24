# -*- encoding: utf-8 -*-
class TopController < ActionController::Base
  include Jpmobile::ViewSelector
  layout 'contents'
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
    respond_to do |format|
      format.html
      format.js
    end
  end
end
