class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user
      t.integer :like
      t.references :post
      t.integer :parent_id

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end
