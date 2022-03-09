class ChangeColumnToPost < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :posts, :profiles
    remove_index :posts, :profile_id
    remove_reference :posts, :profile
  end
end
