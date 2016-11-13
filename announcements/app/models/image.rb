class Image < ApplicationRecord
  belongs_to :announcement
  validates :source_string, :presence => true
end
