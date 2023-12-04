class AddColumnToDemonstration < ActiveRecord::Migration[7.1]
  def change
    add_column :demonstrations, :active, :boolean, default: true
  end
end
