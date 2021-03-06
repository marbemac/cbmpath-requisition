# == Schema Information
#
# Table name: users
#
#  address                :string(255)
#  cbm_user_identifier    :integer
#  city                   :string(255)
#  created_at             :datetime         not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  id                     :integer          not null, primary key
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  name                   :string(255)
#  practice_name          :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0)
#  state                  :string(255)
#  updated_at             :datetime         not null
#  zipcode                :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :practice_name,
                  :address, :city, :state, :zipcode, :cbm_user_identifier

  validates_presence_of :cbm_user_identifier

  has_many :patients
  has_many :doctors
  has_many :requisition_forms

  before_create :use_practice_name

  def use_practice_name
    self.name  = practice_name
  end
end
