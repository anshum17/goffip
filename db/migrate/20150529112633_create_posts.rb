class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.references :user
      t.integer :like
      t.integer :type

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
