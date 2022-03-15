class AddMinuteTimeToStudies < ActiveRecord::Migration[6.1]
  def change
    add_column :studies, :minute_time, :integer
  end
end
