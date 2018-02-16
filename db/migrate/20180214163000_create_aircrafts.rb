class CreateAircrafts < ActiveRecord::Migration[5.1]
  def change
    create_table :aircrafts do |t|
      t.string :name
      t.string :drone_type
      t.string :image

      t.timestamps
    end
  end
end
