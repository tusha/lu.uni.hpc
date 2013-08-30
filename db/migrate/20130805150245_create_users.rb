class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname, :null =>false
      t.string :lastname, :null => false
      t.string :username, :null => false
      t.string :kind  
      t.string :email, :null => false
      t.string :phonenumber
      t.string :mobile
      t.string :password_salt, :null => false
      t.integer :id_account
      t.integer :id_address
      t.boolean :isactive
      t.integer :loginretries
      t.string :secretquestion
      t.string :secretanswer
      t.datetime :lastlogindate
      t.string :persistence_token
      t.string :crypted_password
      t.string :role

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :persistence_token
    add_index :users, :lastlogindate
  end
end
