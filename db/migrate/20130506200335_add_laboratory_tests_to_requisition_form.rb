class AddLaboratoryTestsToRequisitionForm < ActiveRecord::Migration
  def change
    add_column :requisition_forms, :laboratory_tests, :text, :default => "{}"
  end
end
