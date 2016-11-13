module RatingsHelper
  def get_rating announcement
    ratings = []
    announcement.ratings.each do |rating|
      ratings.push rating.rank if rating.id != nil
    end

    (ratings.sum / ratings.size).round if ratings.size > 0
  end
end
