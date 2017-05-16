class CreateGears < ActiveRecord::Migration[5.0]
  def change
    create_table :gears do |t|
      t.string :address
      t.string :brand
      t.string :model
      t.integer :price
      t.text :description
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
