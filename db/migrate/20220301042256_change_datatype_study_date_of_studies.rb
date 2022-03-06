class ChangeDatatypeStudyDateOfStudies < ActiveRecord::Migration[6.1]
  def change
    change_column :studies, :study_date, :string
  end
end
