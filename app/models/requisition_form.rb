# == Schema Information
#
# Table name: requisition_forms
#
#  collection_date                      :date
#  created_at                           :datetime         not null
#  doctor2_id                           :integer
#  doctor2_name                         :string(255)
#  doctor2_req_id                       :integer
#  doctor_id                            :integer
#  doctor_name                          :string(255)
#  doctor_req_id                        :integer
#  form_type                            :string(255)
#  general_fields                       :text             default("{}")
#  icd9_codes                           :text
#  id                                   :integer          not null, primary key
#  laboratory_tests                     :text             default("{}")
#  medical_history                      :text             default("{}")
#  patient_address                      :string(255)
#  patient_city                         :string(255)
#  patient_date_of_birth                :date
#  patient_first_name                   :string(255)
#  patient_id                           :integer
#  patient_insurance_date_of_birth      :date
#  patient_insurance_group_number       :string(255)
#  patient_insurance_insured_employer   :string(255)
#  patient_insurance_insured_name       :string(255)
#  patient_insurance_insured_work_phone :string(255)
#  patient_insurance_name               :string(255)
#  patient_insurance_phone              :string(255)
#  patient_insurance_policy_number      :string(255)
#  patient_insurance_relation           :string(255)
#  patient_insurance_type               :string(255)
#  patient_last_name                    :string(255)
#  patient_middle_name                  :string(255)
#  patient_req_id                       :integer
#  patient_sex                          :string(255)
#  patient_ssn                          :string(255)
#  patient_state                        :string(255)
#  patient_zipcode                      :string(255)
#  special_requests                     :text
#  specimens                            :text
#  updated_at                           :datetime         not null
#  user_id                              :integer
#

class RequisitionForm < ActiveRecord::Base
  serialize :icd9_codes, JSON
  serialize :medical_history, JSON
  serialize :specimens, JSON
  serialize :general_fields, JSON

  belongs_to :doctor
  belongs_to :doctor2, :class_name => 'Doctor'
  belongs_to :patient
  belongs_to :user

  accepts_nested_attributes_for :doctor, :doctor2, :patient

  attr_protected :user_id

  after_create :copy_patient_doctors

  def copy_patient_doctors
    if patient
      self.patient_first_name = patient.first_name
      self.patient_last_name = patient.last_name
      self.patient_middle_name = patient.middle_name
      self.patient_sex = patient.sex
      self.patient_date_of_birth = patient.date_of_birth
      self.patient_ssn = patient.ssn

      self.patient_address = patient.address
      self.patient_city = patient.city
      self.patient_state = patient.state
      self.patient_zipcode = patient.zipcode

      self.patient_insurance_type = patient.insurance_type
      self.patient_insurance_name = patient.insurance_name
      self.patient_insurance_insured_name = patient.insurance_insured_name
      self.patient_insurance_group_number = patient.insurance_group_number
      self.patient_insurance_date_of_birth = patient.insurance_date_of_birth
      self.patient_insurance_insured_employer = patient.insurance_insured_employer
      self.patient_insurance_relation = patient.insurance_relation
      self.patient_insurance_policy_number = patient.insurance_policy_number
      self.patient_insurance_phone = patient.insurance_phone
      self.patient_insurance_insured_work_phone = patient.insurance_insured_work_phone
    end

    if doctor
      self.doctor_name = doctor.name
    end

    if doctor2
      self.doctor2_name = doctor2.name
    end

    save
  end
end
