class AddSizeToGears < ActiveRecord::Migration[5.0]
  def change
    add_reference :gears, :size, foreign_key: true
  end
end
