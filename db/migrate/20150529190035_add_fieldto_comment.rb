class AddFieldtoComment < ActiveRecord::Migration
  def up
    add_column :posts, :is_anonymous, :boolean, :default => false
    add_column :comments, :is_anonymous, :boolean, :default => false
  end

  def down
  end
end
