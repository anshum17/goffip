class ChangeColumnName < ActiveRecord::Migration
  def up
    rename_column :posts, :type, :post_type
  end

  def down
    rename_column :posts, :post_type, :type
  end
end
