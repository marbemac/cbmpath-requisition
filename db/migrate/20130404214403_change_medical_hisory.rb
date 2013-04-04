class ChangeMedicalHisory < ActiveRecord::Migration
  def change
    change_column :requisition_forms, :medical_history, :text, :default => "{}"
  end
end
