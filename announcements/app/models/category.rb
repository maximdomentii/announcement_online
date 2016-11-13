class Category < ApplicationRecord
  has_many :announcements
  validates :name, presence: true
end
