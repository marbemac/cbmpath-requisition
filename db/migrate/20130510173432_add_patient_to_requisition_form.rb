class AddPatientToRequisitionForm < ActiveRecord::Migration
  def change
    add_column :requisition_forms, :patient_first_name, :string
    add_column :requisition_forms, :patient_last_name, :string
    add_column :requisition_forms, :patient_middle_name, :string
    add_column :requisition_forms, :patient_sex, :string
    add_column :requisition_forms, :patient_date_of_birth, :date
    add_column :requisition_forms, :patient_ssn, :string

    add_column :requisition_forms, :patient_address, :string
    add_column :requisition_forms, :patient_city, :string
    add_column :requisition_forms, :patient_state, :string
    add_column :requisition_forms, :patient_zipcode, :string

    add_column :requisition_forms, :patient_insurance_type, :string
    add_column :requisition_forms, :patient_insurance_name, :string
    add_column :requisition_forms, :patient_insurance_insured_name, :string
    add_column :requisition_forms, :patient_insurance_group_number, :string
    add_column :requisition_forms, :patient_insurance_date_of_birth, :date
    add_column :requisition_forms, :patient_insurance_insured_employer, :string
    add_column :requisition_forms, :patient_insurance_relation, :string
    add_column :requisition_forms, :patient_insurance_policy_number, :string
    add_column :requisition_forms, :patient_insurance_phone, :string
    add_column :requisition_forms, :patient_insurance_insured_work_phone, :string
  end
end
