class AddAuthyFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :phone_number, :string
    add_column :users, :authy_id, :string
  end
end
