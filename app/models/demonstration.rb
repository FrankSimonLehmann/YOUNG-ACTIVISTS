class Demonstration < ApplicationRecord
  include PgSearch::Model
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

  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :demo_types, dependent: :destroy
  has_many :demo_topics, dependent: :destroy
  has_many :topics, through: :demo_topics
  has_many :types, through: :demo_types

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 48 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
