class Topic < ApplicationRecord
  has_many :demonstrations, through: :demo_topic
  validates :name, presence: true, inclusion: { in: %w[war freedom racism education enviorment climate frank lgbtq legislation] }
end
