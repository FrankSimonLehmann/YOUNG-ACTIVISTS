class AddCollumnsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :topic, :string
    add_column :users, :type, :string
  end
end
