class ChangeColumnToProfile < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :profiles, :studies
    remove_index :profiles, :study_id
    remove_reference :profiles, :study
  end
end
