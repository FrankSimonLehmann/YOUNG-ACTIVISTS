class Topic < ApplicationRecord
  has_many :demonstrations, through: :demo_topic
  validates :name, presence: true, inclusion: { in: ["technology", "feminism", "education", "discrimination", "freedom", "alternative-lifestyle", "war", "climate", "LGTBQ", "anti-government", "public-space", "other"] }
end
