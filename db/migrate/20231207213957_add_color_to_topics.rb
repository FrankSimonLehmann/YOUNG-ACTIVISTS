class AddColorToTopics < ActiveRecord::Migration[7.1]
  def change
    add_column :topics, :color, :string
  end
end
