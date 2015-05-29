class CreateEnums < ActiveRecord::Migration
  def change
    create_table :enums do |t|

      t.timestamps
    end
  end
end
