class CreateRoutes < ActiveRecord::Migration[5.1]
  def change
    create_table :routes do |t|
      t.references :mission, foreign_key: true
      t.integer :timestamp
      t.float :lat
      t.float :lon
      t.float :alt

      t.timestamps
    end
  end
end
