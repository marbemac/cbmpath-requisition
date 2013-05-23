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
    column :id
    column :patient_name do |b|
      "#{b.patient.first_name} #{b.patient.last_name}"
    end
    column :form_type
    column :created_at
    column do |b|
      (link_to("View HTML", requisition_form_path(b)) + '   ' + link_to("View PDF", requisition_form_path(b, :format => :pdf))).html_safe
    end
  end
end
