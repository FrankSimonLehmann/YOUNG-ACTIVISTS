class ChangeDateTime < ActiveRecord::Migration[7.1]
  def change
    change_table :demonstrations do |t|
      t.change :start_time, :datetime
      t.change :end_time, :datetime
    end
  end
end
