class AddInsuranceAddressToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :insurance_address, :string
    add_column :patients, :insurance_city, :string
    add_column :patients, :insurance_state, :string
    add_column :patients, :insurance_zipcode, :string

    add_column :requisition_forms, :patient_insurance_address, :string
    add_column :requisition_forms, :patient_insurance_city, :string
    add_column :requisition_forms, :patient_insurance_state, :string
    add_column :requisition_forms, :patient_insurance_zipcode, :string
  end
end
