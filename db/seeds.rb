# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.where(email: 'user1@example.com').first
unless user1
  user1 = User.create(:email => 'user1@example.com', :password => 'password',
              :name => 'User 1', :practice_name => 'User 1 Practice',
              :city => 'New York City', :state => 'NY', :zipcode => '10009')
end

patient1 = user1.patients.where(last_name: 'Boggart').first
unless patient1
  patient1 = user1.patients.create(first_name: 'Alfred', last_name: 'Boggart',
                                   middle_name: 'Henry', date_of_birth: Chronic.parse('30 years ago'),
                                   address: '123 Cherry Lane', city: 'New York City', state: 'NY',
                                   zipcode: '10009', sex: 'm', ssn: '193-38-2039',
                                   insurance_date_of_birth: Chronic.parse('30 years ago'),
                                   insurance_group_number: '123', insurance_insured_employer: 'Yeehaw',
                                   insurance_insured_name: 'Alfred Boggart', insurance_insured_work_phone: '55555555',
                                   insurance_name: 'Aetna', insurance_phone: '5555555', insurance_policy_id: '123',
                                   insurance_relation: 'Mom', insurance_type: 'provided')
end

doctor1 = user1.doctors.where(name: 'Mr. Doctor Man').first
unless doctor1
  doctor1 = user1.doctors.create(name: 'Mr. Doctor Man')
end

form1 = user1.requisition_forms.new
form1.patient = patient1
form1.doctor = doctor1
form1.save