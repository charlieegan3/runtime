class AddCertaintyToRatios < ActiveRecord::Migration
  def change
    add_column :ratios, :certainty, :float
  end
end
