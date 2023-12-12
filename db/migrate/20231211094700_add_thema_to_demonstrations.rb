class AddThemaToDemonstrations < ActiveRecord::Migration[7.1]
  def change
    add_column :demonstrations, :thema, :string
  end
end
