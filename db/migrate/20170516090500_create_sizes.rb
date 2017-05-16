class CreateSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :sizes do |t|
      t.string :name
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
