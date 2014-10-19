class CreateDistances < ActiveRecord::Migration
  def change
    create_table :distances do |t|
      t.string :identifier
      t.float :value

      t.timestamps
    end
  end
end
