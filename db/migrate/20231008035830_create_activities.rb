class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :level, :null => false
      t.float :index, default: 1.75, null: false
      t.string :activity, null: false
      t.timestamps
    end
  end
end
