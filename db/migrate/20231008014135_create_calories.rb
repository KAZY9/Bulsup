class CreateCalories < ActiveRecord::Migration[6.1]
  def change
    create_table :calories do |t|
      t.integer :user_id
      t.integer :age, :null => false
      t.string :sex, :null => false
      t.float :height, :null => false
      t.float :weight, :null => false
      t.integer :activity_level, :null => false, default: 2
      t.float :weight_to_gain, :null => false, default: 1
      t.date :start_date, :null => false, default: Date.today
      t.date :end_date, :null => false, default: Date.today + 30
      t.timestamps
    end
  end
end
