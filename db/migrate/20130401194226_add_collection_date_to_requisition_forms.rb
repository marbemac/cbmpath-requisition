class AddCollectionDateToRequisitionForms < ActiveRecord::Migration
  def change
    add_column :requisition_forms, :collection_date, :date
  end
end
