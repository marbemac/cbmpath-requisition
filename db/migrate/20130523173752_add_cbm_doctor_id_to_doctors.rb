class AddCbmDoctorIdToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :cbm_doctor_identifier, :integer
  end
end
