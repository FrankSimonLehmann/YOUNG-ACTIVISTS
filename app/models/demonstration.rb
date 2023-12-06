class Demonstration < ApplicationRecord
  include PgSearch::Model
  before_validation :full_address
  pg_search_scope(
    :search_by_title_and_description,
    against: {
      title: 'A',
      description: 'B'
    },
    using: {
      tsearch: { prefix: true }
    }
  )
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_location?

  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :demo_type, dependent: :destroy
  has_many :demo_topic, dependent: :destroy
  has_many :topics, through: :demo_topic
  has_many :types, through: :demo_type

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 48 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def full_address
    "#{location}, #{postcode}, #{city}"
  end
end
