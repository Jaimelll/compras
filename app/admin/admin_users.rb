#admin/admin_users.rb
ActiveAdmin.register AdminUser do
  permit_params :email, :categoria, :password, :password_confirmation
  

  index do
    selectable_column
    id_column
    column :email
    column :categoria
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :categoria
      f.input :password, as: :password, input_html: { autocomplete: "new-password" }
      f.input :password_confirmation, as: :password, input_html: { autocomplete: "new-password" }
    end
    f.actions
  end

  # Controlar la lógica de actualización
  controller do
    def update
      if params[:admin_user][:password].blank? && params[:admin_user][:password_confirmation].blank?
        params[:admin_user].delete(:password)
        params[:admin_user].delete(:password_confirmation)
      end
      super
    end
  end
end
