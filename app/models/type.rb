class Type < ApplicationRecord
  has_many :demonstrations, through: :demo_type
  validates :name, presence: true, inclusion: { in: %w[rally bike speech march sitin online hungerstrike boycott strikes artisticprotest] }
end
