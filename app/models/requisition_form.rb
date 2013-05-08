# == Schema Information
#
# Table name: requisition_forms
#
#  collection_date  :date
#  created_at       :datetime         not null
#  doctor2_id       :integer
#  doctor_id        :integer
#  form_type        :string(255)
#  general_fields   :text             default("{}")
#  icd9_codes       :text
#  id               :integer          not null, primary key
#  laboratory_tests :text             default("{}")
#  medical_history  :text             default("{}")
#  patient_id       :integer
#  special_requests :text
#  specimens        :text             default("{}")
#  updated_at       :datetime         not null
#  user_id          :integer
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
end
