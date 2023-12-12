class Type < ApplicationRecord
  has_many :demonstrations, through: :demo_type
  validates :name, presence: true, inclusion: { in: ["physical demo", "collective actions", "digital demonstrations", "creative expressions"] }
end
