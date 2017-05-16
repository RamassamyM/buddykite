class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :gear, foreign_key: true
      t.text :reviews
      t.integer :rating
      t.date :start_at
      t.date :end_at
      t.string :infos

      t.timestamps
    end
  end
end
