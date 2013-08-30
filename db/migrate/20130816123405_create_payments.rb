class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :transaction_id
      t.string :params
      t.string :send_money
      t.integer :user_id

      t.timestamps
    end
  end
end
