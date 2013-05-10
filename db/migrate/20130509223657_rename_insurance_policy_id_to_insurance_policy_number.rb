class RenameInsurancePolicyIdToInsurancePolicyNumber < ActiveRecord::Migration
  def change
    rename_column :patients, :insurance_policy_id, :insurance_policy_number
  end
end
