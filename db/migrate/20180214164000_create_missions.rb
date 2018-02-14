class CreateMissions < ActiveRecord::Migration[5.1]
  def change
    create_table :missions do |t|
      t.references :aircraft, foreign_key: true
      t.string :name
      t.time :starttime
      t.time :endtime

      t.timestamps
    end
  end
end
