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
end
