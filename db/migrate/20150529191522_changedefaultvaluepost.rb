class Changedefaultvaluepost < ActiveRecord::Migration
  def up
    change_column :posts, :like, :integer, :default => []
    change_column :comments, :like, :integer, :default => []
    change_column :posts, :dislike, :integer, :default => []
    change_column :comments, :dislike, :integer, :default => []
  end

  def down
  end
end
