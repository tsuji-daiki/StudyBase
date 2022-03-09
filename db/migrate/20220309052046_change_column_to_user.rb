class ChangeColumnToUser < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :users, :profiles
    remove_index :users, :profile_id
    remove_reference :users, :profile
  end
end
