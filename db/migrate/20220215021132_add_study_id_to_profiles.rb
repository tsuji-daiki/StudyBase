class AddStudyIdToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_reference :profiles, :study, foreign_key: true
  end
end
