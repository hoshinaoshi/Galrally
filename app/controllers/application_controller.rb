class ApplicationController < ActionController::Base
  layout 'contents'
  protect_from_forgery with: :exception
  # 例外ハンドル
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  #rescue_from ActionController::UnknownAction, :with => :render_404
  rescue_from ActionController::RoutingError, :with => :render_404
  rescue_from Exception, :with => :render_500
  
  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render :file => "#{Rails.root}/public/404.html", :status => 404, :content_type => 'text/html'
  end
  def render_500(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render :file => "#{Rails.root}/public/500.html", :status => 500, :content_type => 'text/html'
  end
end
