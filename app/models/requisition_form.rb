# == Schema Information
#
# Table name: requisition_forms
#
#  created_at       :datetime         not null
#  doctor2_id       :integer
#  doctor_id        :integer
#  icd9_codes       :text
#  id               :integer          not null, primary key
#  medical_history  :text
#  patient_id       :integer
#  special_requests :text
#  specimens        :text
#  updated_at       :datetime         not null
#  user_id          :integer
#

class RequisitionForm < ActiveRecord::Base
  serialize :icd9_codes, JSON
  serialize :medical_history, JSON
  serialize :specimens, JSON

  has_one :doctor
  has_one :doctor2
  has_one :patient
  belongs_to :user
end
