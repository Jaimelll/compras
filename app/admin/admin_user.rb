ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :categoria, :periodo


  member_action :af2, method: :put do
     @vaf=current_admin_user.periodo
     @cid=current_admin_user.id

     @num=Formula.where(product_id: 11, orden:@vaf).
            select('numero as dd').first.dd

     AdminUser.where(id: @cid).update_all( periodo: @num )
      redirect_to admin_dashboard_path
   end

#menu  priority: 17,label: "Usuarios"

menu false

#actions :all

  index  do
    if current_admin_user.categoria==2 then
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :categoria
    column :periodo

    actions

  end
end

  filter :email
  filter :categoria

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      if current_admin_user.categoria==2 then
         f.input :categoria
         f.input :periodo
      end
       f.actions
  end

end

show :title => ' Usuario'  do

    attributes_table  do





      row :email
      row :password
      row :password_confirmation
      if current_admin_user.categoria==2 then
      row :categoria
      row :periodo
      end

  end #de attributes_table

end # de show





end
