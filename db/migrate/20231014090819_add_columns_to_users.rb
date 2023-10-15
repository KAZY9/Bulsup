class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :birthdate, :date
    add_column :users, :sex, :string
    add_column :users, :job, :string
  end
end
