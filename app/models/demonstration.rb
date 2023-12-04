class Demonstration < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  has_many :topics, through: :demo_topic
  has_many :types, through: :demo_type
  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 48 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :location, presence: true
  geocoded_by :location
  validates :start_time, presence: true
  validates :end_time, presence: true
end
