class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :script_name
      t.string :script
      t.string :comment
      t.integer :tokens, :array=>true
      t.timestamps
    end
  end
end
