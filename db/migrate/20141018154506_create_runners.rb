class CreateRunners < ActiveRecord::Migration
  def change
    create_table :runners do |t|
      t.integer :age
      t.string :gender
      t.integer :fitness

      t.timestamps
    end
  end
end
