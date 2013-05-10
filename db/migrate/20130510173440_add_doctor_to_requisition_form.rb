class AddDoctorToRequisitionForm < ActiveRecord::Migration
  def change
    add_column :requisition_forms, :doctor_name, :string
    add_column :requisition_forms, :doctor2_name, :string
  end
end
