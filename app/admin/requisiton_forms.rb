ActiveAdmin.register RequisitionForm do
  scope_to :current_user, :unless => proc{ can?(:manage, :all) }
  actions :index

  action_item do
    link_to('New Gyn Form', new_requisition_form_path(:type => "gyn"))
  end
  action_item do
    link_to('New General Form', new_requisition_form_path(:type => "general"))
  end
  action_item do
    link_to('New GI Form', new_requisition_form_path(:type => "gi"))
  end

  index do
    column :patient_id
    column :patient_name do |b|
      "#{b.patient.first_name} #{b.patient.last_name}"
    end
    column :doctor_name
    column :collection_date
    column "# of Specimens" do |b|
      b.specimens.length
    end
    column do |b|
      (link_to("View HTML", requisition_form_path(b)) + '   ' + link_to("View PDF", requisition_form_path(b, :format => :pdf), :target => "_blank")).html_safe
    end
  end

  filter :patient_first_name
  filter :patient_last_name
  filter :patient_date_of_birth
  filter :collection_date
  filter :doctor_name, :as => :select, :collection => proc { can?(:manage, :all) ? Doctor.all : current_user.doctors }
  filter :doctor2_name, :as => :select, :collection => proc { can?(:manage, :all) ? Doctor.all : current_user.doctors }, :label => "Additional Doctor Name"
  filter :patient_insurance_type
  filter :patient_insurance_name
end
