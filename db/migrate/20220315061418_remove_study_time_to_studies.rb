class RemoveStudyTimeToStudies < ActiveRecord::Migration[6.1]
  def change
    remove_column :studies, :study_time, :integer
  end
end
