class Changedefaultvaluepost < ActiveRecord::Migration
  def up
    change_column :posts, :like, :integer, array: true, :default => []
    change_column :comments, :like, :integer,array: true,  :default => []
    change_column :posts, :dislike, :integer,array: true,  :default => []
    change_column :comments, :dislike, :integer,array: true,  :default => []
  end

  def down
  end
end
