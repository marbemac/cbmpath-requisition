class CreateRequisitionForms < ActiveRecord::Migration
  def change
    create_table :requisition_forms do |t|
      t.integer :doctor_id
      t.integer :doctor2_id
      t.text :icd9_codes
      t.integer :patient_id
      t.integer :user_id
      t.text :medical_history
      t.text :special_requests
      t.text :specimens

      t.timestamps
    end

    add_index :requisition_forms, :user_id
    add_index :requisition_forms, :doctor_id
    add_index :requisition_forms, :doctor2_id
    add_index :requisition_forms, :patient_id
  end
end
