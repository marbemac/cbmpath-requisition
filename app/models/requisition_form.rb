# == Schema Information
#
# Table name: requisition_forms
#
#  collection_date                      :date
#  created_at                           :datetime         not null
#  doctor2_id                           :integer
#  doctor2_name                         :string(255)
#  doctor_id                            :integer
#  doctor_name                          :string(255)
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
#  patient_sex                          :string(255)
#  patient_ssn                          :string(255)
#  patient_state                        :string(255)
#  patient_zipcode                      :string(255)
#  special_requests                     :text
#  specimens                            :text             default("{}")
#  updated_at                           :datetime         not null
#  user_id                              :integer
#

require 'double_bag_ftps'

class RequisitionForm < ActiveRecord::Base
  serialize :icd9_codes, JSON
  serialize :medical_history, JSON
  serialize :specimens, JSON
  serialize :general_fields, JSON

  belongs_to :doctor
  belongs_to :doctor2, :class_name => 'Doctor'
  belongs_to :patient
  belongs_to :user

  accepts_nested_attributes_for :patient

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

  def send_via_sftp
    #begin
    file = File.open("/tmp/#{created_at.to_i}_#{id}.txt","w") do |f|
      f.write(to_json)
    end
    ftps = DoubleBagFTPS.new
    ftps.debug_mode = true
    ftps.ssl_context = DoubleBagFTPS.create_ssl_context(:verify_mode => OpenSSL::SSL::VERIFY_NONE)
    ftps.connect('us1.hostedftp.com')
    ftps.login("marbemac@gmail.com", "cbm3905sftp")
    ftps.passive = true
    ftps.puttextfile("/tmp/#{created_at.to_i}_#{id}.txt")
    ftps.quit()
    #rescue
    #  Emailer.deliver_ftp_fail(id)
    #end
  end

  def as_json(options)
    data = {
        :id => id,
        :created_at => created_at,
        :collection_date => collection_date,
        :form_type => form_type,
        :icd9_codes => icd9_codes,
        :patient => {
            :id => id,
            :first_name => patient_first_name,
            :middle_name => patient_middle_name,
            :last_name => patient_last_name,
            :date_of_birth => patient_date_of_birth,
            :sex => patient_sex,
            :ssn => patient_ssn,
            :address => patient_address,
            :city => patient_city,
            :state => patient_state,
            :zipcode => patient_zipcode
        },
        :insurance => {
            :type => patient_insurance_type,
            :name => patient_insurance_name,
            :group_number => patient_insurance_group_number,
            :policy_number => patient_insurance_policy_number,
            :phone => patient_insurance_phone,
            :date_of_birth => patient_insurance_date_of_birth,
            :relation => patient_insurance_relation,
            :insured_empoloyer => patient_insurance_insured_employer,
            :insured_name => patient_insurance_insured_name,
            :insured_work_phone => patient_insurance_insured_work_phone,
        },
        :client => {
            :id => user.id,
            :cbm_id => user.cbm_user_identifier,
            :name => user.practice_name
        },
        :doctor1 => {
            :id => doctor.id,
            :cbm_id => doctor.cbm_doctor_identifier,
            :name => doctor.name
        },
        :general_fields => general_fields,
        :laboratory_tests => laboratory_tests,
        :medical_history => medical_history,
        :special_requests => special_requests,
        :specimens => specimens
    }

    if doctor2
      data[:doctor2] = {
          :id => doctor2.id,
          :cbm_id => doctor.cbm_doctor_identifier,
          :name => doctor.name
      }
    else
      data[:doctor2] = nil
    end

    data
  end
end
