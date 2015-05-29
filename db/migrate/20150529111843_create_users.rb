class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :fb_link
      t.integer :department
      t.integer :anonymity_count
      t.string :session_token

      t.timestamps
    end
  end
end
