class AddDefaultValueToAnonymityCount < ActiveRecord::Migration
  def change
    change_column :users, :anonymity_count, :integer, :default => 0
    change_column :posts, :like, :integer, :default => 0
    change_column :comments, :like, :integer, :default => 0
    add_column :posts, :dislike, :integer, :default => 0
    add_column :comments, :dislike, :integer, :default => 0
    add_column :users, :user_name, :string
  end
end
