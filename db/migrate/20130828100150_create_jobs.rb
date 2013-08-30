class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :user_id
      t.integer :script_id
      t.integer :tokens, :array => true
      t.string :optional_params, :array => true
      t.integer :output_id

      t.timestamps
    end
  end
end
