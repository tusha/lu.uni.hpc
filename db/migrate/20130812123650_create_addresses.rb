class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :street
      t.string :number
      t.string :city
      t.string :country
      t.string :index

      t.timestamps
    end
  end
end
