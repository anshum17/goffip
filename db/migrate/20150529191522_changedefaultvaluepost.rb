class Changedefaultvaluepost < ActiveRecord::Migration
  def up
    change_column :posts, :like, :array, :default => []
    change_column :comments, :like, :array, :default => []
    change_column :posts, :dislike, :array, :default => []
    change_column :comments, :dislike, :array, :default => []
  end

  def down
  end
end
