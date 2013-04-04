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

  attr_accessible :name
end