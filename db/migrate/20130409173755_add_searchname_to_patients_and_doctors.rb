class AddSearchnameToPatientsAndDoctors < ActiveRecord::Migration
  def change
    add_column :patients, :searchable_name, :string
    add_column :doctors, :searchable_name, :string
    add_index :patients, :searchable_name
    add_index :doctors, :searchable_name
  end
end
