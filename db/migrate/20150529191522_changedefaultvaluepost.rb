class Changedefaultvaluepost < ActiveRecord::Migration
  def up
    remove_column :posts, :like
    remove_column :comments, :like
    remove_column :posts, :dislike
    remove_column :comments, :dislike

    add_column :posts, :like, :integer
    add_column :comments, :like, :integer
    add_column :posts, :dislike, :integer
    add_column :comments, :dislike, :integer
  end

  def down
  end
end
