class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :string
    add_column :users, :phone_number, :string
  end
end
