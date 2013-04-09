# == Schema Information
#
# Table name: doctors
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#  user_id    :integer
#

class Doctor < ActiveRecord::Base
  belongs_to :user
  has_many :requisition_forms

  attr_accessible :name, :user_id

  before_save :update_searchable_name

  def update_searchable_name
    if name_changed? || !persisted?
      self.searchable_name = name.parameterize
    end
  end

  def self.to_search_json(results)
    results.map do |result|
      {
          :value => result.name,
          :data => {
              :id => result.id
          }
      }
    end
  end
end