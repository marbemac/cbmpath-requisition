ActiveAdmin.register Doctor do
  menu :if => proc{ can?(:manage, :all) }

  index do
    column "CBM Doctor ID", :cbm_doctor_identifier
    column :name
    column :user
    default_actions
  end                                 

  filter :searchable_name

  form do |f|                         
    f.inputs "Doctor Information" do
      f.input :cbm_doctor_identifier, label: "CBM User ID"
      f.input :name
      f.input :user
    end                               
    f.actions                         
  end                                 
end                                   
