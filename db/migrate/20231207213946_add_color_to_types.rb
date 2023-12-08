class AddColorToTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :types, :color, :string
  end
end
