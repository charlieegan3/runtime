class ChangeDistanceToFloat < ActiveRecord::Migration
  def change
    change_column :runs, :distance, :float
    change_column :runners, :query_distance, :float
  end
end
