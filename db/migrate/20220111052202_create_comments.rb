class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :reply
      t.references :post
      t.references :user
      t.references :parent, foreign_key: { to_table: :comments }

      t.timestamps
    end
  end
end
