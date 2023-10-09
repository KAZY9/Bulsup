class CreateMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :meals do |t|
      t.integer :information_id, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
