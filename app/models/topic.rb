class Topic < ApplicationRecord
  validates :name, inclusion: { in: %w[war freedom racism education enviorment climate frank] }
end
