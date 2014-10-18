class AddTimeColumnsToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :seconds, :integer
    add_column :runs, :minutes, :integer
    add_column :runs, :hours, :integer
  end
end
