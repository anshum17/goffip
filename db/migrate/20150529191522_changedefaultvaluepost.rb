class Changedefaultvaluepost < ActiveRecord::Migration
  def up
    remove_column :posts, :like
    remove_column :comments, :like
    remove_column :posts, :dislike
    remove_column :comments, :dislike

    add_column :posts, :like, :integer, array: true, :default => []
    add_column :comments, :like, :integer, array: true,  :default => []
    add_column :posts, :dislike, :integer, array: true,  :default => []
    add_column :comments, :dislike, :integer, array: true,  :default => []
  end

  def down
  end
end
