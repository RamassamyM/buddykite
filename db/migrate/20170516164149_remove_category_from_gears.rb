class RemoveCategoryFromGears < ActiveRecord::Migration[5.0]
  def change
    remove_reference :gears, :category, foreign_key: true
  end
end
