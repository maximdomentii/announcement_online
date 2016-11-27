class PagesController < ApplicationController
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
