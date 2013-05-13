ActiveAdmin.register Patient do
  scope_to :current_user

  actions :index, :edit, :show, :update

  index do
    column :id
    column :name do |b|
      "#{b.first_name} #{b.last_name}"
    end
    column :date_of_birth
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs "Patient Information" do
      f.input :first_name
      f.input :last_name
      f.input :middle_name
      f.input :sex
      f.input :date_of_birth, order: [:month, :day, :year], :prompt => true, :start_year => Time.now.year, :end_year => Time.now.year - 120
      f.input :ssn
      f.input :address
      f.input :city
      f.input :state
      f.input :zipcode
      f.input :insurance_type
      f.input :insurance_name
      f.input :insurance_insured_name, label: "Insured's Name"
      f.input :insurance_group_number, label: "Group Number"
      f.input :insurance_date_of_birth, order: [:month, :day, :year], :prompt => true, :start_year => Time.now.year, :end_year => Time.now.year - 120, label: "Insured's Date of Birth"
      f.input :insurance_insured_employer, label: "Insured's Employer"
      f.input :insurance_relation, collection: %w(Self Spouse Child Other), prompt: "Select Relation", :input_html => {:autocomplete => 'off'}, label: "Relation to Patient"
      f.input :insurance_policy_number, label: "Indsurance Policy ID"
      f.input :insurance_phone, label: "Insured's Work Phone"
      f.input :insurance_insured_work_phone, label: "Insured's Work Number"

    end
    f.buttons
  end
end
