class RemoveTimeFromRuns < ActiveRecord::Migration
  def change
    remove_column :runs, :time
  end
end
