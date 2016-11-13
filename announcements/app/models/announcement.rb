class Announcement < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :ratings, dependent: :destroy
  validates :title, :description, :valid_to, :category_id, presence: true

  after_initialize do |announcement|
    announcement.valid_to ||= Date.tomorrow if new_record?
  end
end
