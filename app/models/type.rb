class Type < ApplicationRecord
  validates :name, presence: true, inclusion: { in: %w[rally bike speech march sitin online hungerstrike boycott strikes frank artisticprotest] }
end
