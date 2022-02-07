class CreateStudies < ActiveRecord::Migration[6.1]
  def change
    create_table :studies do |t|
      t.integer :study_time
      t.integer :study_date
      t.integer :total_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
