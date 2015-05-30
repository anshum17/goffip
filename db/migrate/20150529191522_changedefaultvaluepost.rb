class Changedefaultvaluepost < ActiveRecord::Migration
  def up
    # remove_column :posts, :like
    # remove_column :comments, :like
    # remove_column :posts, :dislike
    # remove_column :comments, :dislike

    add_column :posts, :like, :text
    add_column :comments, :like, :text
    add_column :posts, :dislike, :text
    add_column :comments, :dislike, :text
  end

  def down
    remove_column :posts, :like
    remove_column :comments, :like
    remove_column :posts, :dislike
    remove_column :comments, :dislike
  end
end
