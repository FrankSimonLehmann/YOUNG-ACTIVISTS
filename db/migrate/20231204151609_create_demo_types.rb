class CreateDemoTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :demo_types do |t|
      t.references :demonstration, null: false, foreign_key: true
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
