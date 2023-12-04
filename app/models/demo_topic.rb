class DemoTopic < ApplicationRecord
  belongs_to :demonstration
  belongs_to :topic
end
