class AddQueryToRunner < ActiveRecord::Migration
  def change
    add_column :runners, :query_distance, :integer
  end
end
