class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.integer :repetition
      t.integer :weight
      t.integer :lift_id

      t.timestamps
    end
  end
end
