class PagesController < ApplicationController
  include AnnouncementsHelper

  def show
    # /contact|about|help/
    if params[:id].match /about|contact|help/
      render params[:id]
    else
      render '/pages/not_found.html.erb', :status => 404
    end
  end

  def home
    render '/pages/home.html.erb'
  end

  def search
    categories = Category.all

    param_category = search_params[:category]
    param_keyword = search_params[:keyword]

    category = nil
    categories.each do |c|
      if c.name == param_category
        category = c
        break
      end
    end

    @announcements = filter_announcements category, param_keyword

    render 'pages/search-result'
  end

  def get_current_user_announcements
    @announcements = current_user.announcements
    render 'pages/user-announcements'
  end

  def most_recent
    @announcements = get_most_recent
    render 'pages/most-recents-ann'
  end

  def most_viewed
    @announcements = get_most_viewed
    render 'pages/most-viewed-ann'
  end

  def best_rated
    @announcements = get_best_rated
    render 'pages/best-rated-ann'
  end

  private

  def search_params
    params.permit(:keyword, :category)
  end

  def filter_announcements(category, param_keyword)
    param_keyword = param_keyword.downcase

    if category != nil
      announcements = category.announcements
      if param_keyword != ''
        announcements = announcements.select {|ann| ann.title.downcase.include? param_keyword  or ann.description.downcase.include? param_keyword}
      end
    else
      announcements = Announcement.all
      if param_keyword != ''
        announcements = announcements.select {|ann| ann.title.downcase.include? param_keyword  or ann.description.downcase.include? param_keyword}
      end
    end

    announcements
  end

end
