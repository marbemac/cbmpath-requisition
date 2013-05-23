class AddCbmUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cbm_user_identifier, :integer
  end
end
