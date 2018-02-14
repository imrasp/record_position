class CreateParts < ActiveRecord::Migration[5.1]
  def change
    create_table :parts do |t|
      t.references :aircraft, foreign_key: true
      t.string :name
      t.string :description
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
