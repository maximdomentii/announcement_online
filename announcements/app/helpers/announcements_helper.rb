module AnnouncementsHelper
  class << self
    include Rails.application.routes.url_helpers
  end

  def images_urls announcement
    urls = []
    announcement.images.each do |image|
      urls.push image.source_string
    end

    urls
  end

  def announcement_image_path imageId, annId
    UrlHelpers.announcements_images_path(:id => imageId, :announcement_id => annId)
  end

  def get_most_viewed
    all_ann = Announcement.all
    viewed_ann = all_ann.select {|item| item.clicks > 0}
    viewed_ann.sort_by {|item| -item.clicks}
  end

  def get_most_recent
    all_ann = Announcement.all
    ordered_ann = all_ann.sort {|item1, item2| item2.created_at <=> item1.created_at}
  end

  def get_best_rated
    all_ann = Announcement.all
    rated_ann = all_ann.select {|item| item.ratings.count > 0}
    rated_ann.sort_by {|item| -(item.ratings.sum(:rank) / item.ratings.count)}
  end

end
