class CreateRouteGps < ActiveRecord::Migration[5.1]
  def change
    create_table :route_gps do |t|
      t.references :mission, foreign_key: true
      t.time :time
      t.float :lat
      t.float :lon
      t.float :alt

      t.timestamps
    end
  end
end
