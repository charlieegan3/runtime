class CreateRatios < ActiveRecord::Migration
  def change
    create_table :ratios do |t|
      t.float :distance1
      t.float :distance2
      t.float :multiplier

      t.timestamps
    end
  end
end
