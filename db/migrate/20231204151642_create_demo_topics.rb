class CreateDemoTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :demo_topics do |t|
      t.references :demonstration, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
