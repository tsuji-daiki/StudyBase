class AddProfileIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :profile, foreign_key: true
  end
end
