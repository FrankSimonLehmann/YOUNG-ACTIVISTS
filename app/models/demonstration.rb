class Demonstration < ApplicationRecord
  include PgSearch::Model
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

  pg_search_scope(
    :global_search,
    associated_against: {
      topics: :name
    },
    using: {
      tsearch: { prefix: true }
    }
  )

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
end
