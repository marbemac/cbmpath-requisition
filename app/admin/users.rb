ActiveAdmin.register User do
  menu :if => proc{ can?(:manage, User) }
  #controller.authorize_resource

  index do
    column "CBM User ID", :cbm_user_identifier
    column :email                     
    column :last_sign_in_at
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do
      f.input :cbm_user_identifier, label: "CBM User ID"
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end                                 
end                                   
