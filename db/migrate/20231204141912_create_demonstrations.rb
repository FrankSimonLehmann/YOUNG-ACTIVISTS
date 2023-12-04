class CreateDemonstrations < ActiveRecord::Migration[7.1]
  def change
    create_table :demonstrations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :location
      t.string :postcode
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.date :start_time
      t.date :end_time
      t.text :extra_info

      t.timestamps
    end
  end
end
