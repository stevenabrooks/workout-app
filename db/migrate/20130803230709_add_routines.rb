class AddRoutines < ActiveRecord::Migration
  def up
    create_table :routines do |t|
      t.string :name
      t.string :date
    end
  end

  def down
  end
end
