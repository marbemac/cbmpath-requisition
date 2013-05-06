class AddGeneralFieldsToRequisitionForm < ActiveRecord::Migration
  def change
    add_column :requisition_forms, :general_fields, :text, :default => "{}"
  end
end
