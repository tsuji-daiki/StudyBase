class AddProfileIdToStudies < ActiveRecord::Migration[6.1]
  def change
    add_reference :studies, :profile, foreign_key: true
  end
end
