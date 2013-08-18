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
#  insurance_policy_number      :string(255)
#  insurance_relation           :string(255)
#  insurance_type               :string(255)
#  last_name                    :string(255)
#  middle_name                  :string(255)
#  searchable_name              :string(255)
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
                  :insurance_phone, :insurance_policy_number, :insurance_relation,
                  :insurance_type, :user_id, :insurance_address, :insurance_city,
                  :insurance_state, :insurance_zipcode

  before_save :update_searchable_name

  def update_searchable_name
    if first_name_changed? || last_name_changed? || !persisted?
      self.searchable_name = "#{first_name} #{last_name}".parameterize
    end
  end

  #= p.input :first_name
  #= p.input :middle_name
  #= p.input :last_name
  #          .checkboxes
  #== p.collection_radio_buttons :sex, ['M', 'F'], :to_s, :to_s do |b|
  #  - b.label { b.radio_button + b.text.html_safe }
  #  = p.input :date_of_birth, as: :date
  #  = p.input :ssn
  #  = p.input :address
  #  = p.input :city
  #  = p.input :state
  #  = p.input :zipcode
  #            .small-6.columns.insurance-info.bl
  #  .checkboxes
  #  == p.collection_radio_buttons :insurance_type, ['Self', 'Insurance'], :to_s, :to_s do |b|
  #    - b.label { b.radio_button + b.text.html_safe }
  #    = p.input :insurance_name
  #              .row
  #              .small-6.columns
  #    = p.input :insurance_insured_name
  #    = p.input :insurance_group_number
  #    = p.input :insurance_date_of_birth
  #    = p.input :insurance_insured_employer
  #              .small-6.columns
  #    = p.input :insurance_relation, collection: %w(Self Spouse Child Other), prompt: "Select Relation"
  #    = p.input :insurance_policy_number
  #    = p.input :insurance_insured_work_phone
  #    = p.input :insurance_phone

  def self.to_search_json(results)
    results.map do |result|
      {
          :value => "#{result.first_name} #{result.last_name}",
          :data => {
              :id => result.id,
              :first_name => result.first_name,
              :middle_name => result.middle_name,
              :last_name => result.last_name,
              :sex => result.sex,
              :date_of_birth => result.date_of_birth ? result.date_of_birth.strftime("%Y/%-m/%-d").split('/') : nil,
              :ssn => result.ssn,
              :address => result.address,
              :city => result.city,
              :state => result.state,
              :zipcode => result.zipcode,
              :insurance_type => result.insurance_type,
              :insurance_name => result.insurance_name,
              :insurance_group_number => result.insurance_group_number,
              :insurance_date_of_birth => result.insurance_date_of_birth ? result.insurance_date_of_birth.strftime("%Y/%-m/%-d").split('/') : nil,
              :insurance_insured_name => result.insurance_insured_name,
              :insurance_insured_employer => result.insurance_insured_employer,
              :insurance_relation => result.insurance_relation,
              :insurance_policy_number => result.insurance_policy_number,
              :insurance_insured_work_phone => result.insurance_insured_work_phone,
              :insurance_phone => result.insurance_phone,
              :insurance_insured_address => result.insurance_address,
              :insurance_insured_city => result.insurance_city,
              :insurance_insured_state => result.insurance_state,
              :insurance_insured_zipcode => result.insurance_zipcode,
          }
      }
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end
