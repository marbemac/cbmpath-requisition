class AddTypeToRequisitionForm < ActiveRecord::Migration
  def change
    add_column :requisition_forms, :form_type, :string
  end
end
