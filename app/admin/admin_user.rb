ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :categoria




menu  priority: 17,label: "Usuarios"





#actions :all, :if => proc { current_admin_user.categoria == 2 }

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :categoria


    actions

  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :categoria

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :categoria
    end
    if current_admin_user.categoria==2 then
      f.actions
    end
  end








end
