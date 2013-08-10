class AddBodyweighToRoutine < ActiveRecord::Migration
  def change
    add_column :routines, :bodyweight, :integer
  end
end
