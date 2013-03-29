class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :sex
      t.date :date_of_birth
      t.string :ssn

      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode

      t.string :insurance_type
      t.string :insurance_name
      t.string :insurance_insured_name
      t.string :insurance_group_number
      t.date :insurance_date_of_birth
      t.string :insurance_insured_employer
      t.string :insurance_relation
      t.string :insurance_policy_id
      t.string :insurance_phone
      t.string :insurance_insured_work_phone

      t.integer :user_id

      t.timestamps
    end

    add_index :patients, :user_id
  end
end
