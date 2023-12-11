class Removecolumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :topic
    remove_column :users, :type
  end
end
