class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper, CategoriesHelper, CarouselHelper
  before_filter :set_request_urls

  private

  def set_request_urls
    session[:previous_url] = session[:current_url]
    session[:current_url] = request.url
  end
end
