class AddHourTimeToStudies < ActiveRecord::Migration[6.1]
  def change
    add_column :studies, :hour_time, :integer
  end
end
