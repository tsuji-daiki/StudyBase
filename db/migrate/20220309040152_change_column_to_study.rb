class ChangeColumnToStudy < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :studies, :profiles
    remove_index :studies, :profile_id
    remove_reference :studies, :profile
  end
end
