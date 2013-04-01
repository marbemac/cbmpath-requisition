# == Schema Information
#
# Table name: patients
#
#  address                      :string(255)
#  city                         :string(255)
#  created_at                   :datetime         not null
#  date_of_birth                :date
#  first_name                   :string(255)
#  id                           :integer          not null, primary key
#  insurance_date_of_birth      :date
#  insurance_group_number       :string(255)
#  insurance_insured_employer   :string(255)
#  insurance_insured_name       :string(255)
#  insurance_insured_work_phone :string(255)
#  insurance_name               :string(255)
#  insurance_phone              :string(255)
#  insurance_policy_id          :string(255)
#  insurance_relation           :string(255)
#  insurance_type               :string(255)
#  last_name                    :string(255)
#  middle_name                  :string(255)
#  sex                          :string(255)
#  ssn                          :string(255)
#  state                        :string(255)
#  updated_at                   :datetime         not null
#  user_id                      :integer
#  zipcode                      :string(255)
#

class Patient < ActiveRecord::Base
  belongs_to :user
  belongs_to :requisition_form
end