class Tag < ApplicationRecord
  belongs_to :demonstration
  belongs_to :label
end
