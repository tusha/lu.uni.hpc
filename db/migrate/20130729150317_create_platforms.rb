class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.datetime :date
      t.string :name
      t.integer :nodes_num
      t.integer :cores_num
      t.integer :cores_free
      t.integer :cores_used
      t.integer :cores_reserved
      t.integer :cores_suspended
      t.string :status

      t.timestamps
    end
  end
end
