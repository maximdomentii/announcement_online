module AnnouncementsHelper
  def images_urls announcement
    urls = []
    announcement.images.each do |image|
      urls.push image.source_string
    end

    urls
  end
end
