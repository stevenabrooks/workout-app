class CreateLifts < ActiveRecord::Migration
  def change
    create_table :lifts do |t|
      t.integer :routine_id
      t.integer :exercise_id

      t.timestamps
    end
  end
end
