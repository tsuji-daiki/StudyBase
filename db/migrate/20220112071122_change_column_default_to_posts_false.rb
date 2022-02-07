class ChangeColumnDefaultToPostsFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :genre, from: true, to: false
  end
end
