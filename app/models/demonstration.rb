class Demonstration < ApplicationRecord
  include PgSearch::Model
  before_validation :full_address
  pg_search_scope(
    :search_by_title_and_description,
    against: {
      title: 'A',
      description: 'B'
    },
    associated_against: {
      topics: [:name],
      types: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }
  )
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :demo_types, dependent: :destroy
  has_many :demo_topics, dependent: :destroy
  has_many :topics, through: :demo_topics
  has_many :types, through: :demo_types
  has_many :users, through: :bookmarks

  has_one_attached :photo

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 70 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def full_address
    "#{location}, #{postcode}, #{city}"
  end

  def has_long_word_title?
    title.split.any? { |word| word.length > 8 }
  end

  def has_long_word_description?
    description.split.any? { |word| word.length > 8 }
  end

  def has_long_word_location?
    location.split.any? { |word| word.length > 8 }
  end
end
