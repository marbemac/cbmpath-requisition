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
  has_many :requisition_forms

  attr_accessible :first_name, :last_name, :middle_name, :date_of_birth,
                  :address, :city, :state, :zipcode, :sex, :ssn,
                  :insurance_date_of_birth, :insurance_group_number,
                  :insurance_insured_employer, :insurance_insured_name,
                  :insurance_insured_work_phone, :insurance_name,
                  :insurance_phone, :insurance_policy_id, :insurance_relation,
                  :insurance_type, :user_id

  before_save :update_searchable_name

  def update_searchable_name
    if first_name_changed? || last_name_changed? || !persisted?
      self.searchable_name = "#{first_name} #{last_name}".parameterize
    end
  end

  def self.to_search_json(results)
    results.map do |result|
      {
          :value => "#{result.first_name} #{result.last_name}",
          :data => {
              :id => result.id
          }
      }
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end