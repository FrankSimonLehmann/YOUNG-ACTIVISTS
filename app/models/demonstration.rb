class Demonstration < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :topics, through: :demo_topic
  has_many :types, through: :demo_type
  has_many :demo_type, dependent: :destroy
  has_many :demo_topic, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 48 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
