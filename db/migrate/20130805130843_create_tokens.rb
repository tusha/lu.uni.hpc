class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :quality
      t.integer :generation_num
      t.integer :transform_num
      t.string :kind
      t.decimal :price
      t.boolean :isdefault
      t.timestamps
    end
  end
end
