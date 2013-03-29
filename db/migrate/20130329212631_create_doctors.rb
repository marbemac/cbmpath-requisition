class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end

    add_index :doctors, :user_id
  end
end
