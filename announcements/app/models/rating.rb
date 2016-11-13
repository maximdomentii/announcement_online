class Rating < ApplicationRecord
  belongs_to :announcement
  validates :rank, :presence => true

  include ActiveModel::Validations
  validates_with ValidateRatingRank
end
