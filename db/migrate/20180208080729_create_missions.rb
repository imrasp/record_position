class CreateMissions < ActiveRecord::Migration[5.1]
  def change
    create_table :missions do |t|
      t.integer :mission_id
      t.string :name

      t.timestamps
    end
  end
end
