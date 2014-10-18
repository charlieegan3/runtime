class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.integer :distance
      t.time :racetime
      t.references :user, index: true

      t.timestamps
    end
  end
end
