ActiveAdmin.register Formula do

menu false
permit_params  :nombre, :descripcion,
      :orden, :cantidad, :admin_user_id, :product_id




      action_item :view, only: :show do
        link_to 'Ir a Productos', admin_products_path()
      end




      member_action :encargo, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:1).update_all( cantidad:1 )
        redirect_to admin_dashboard_path
      end

      member_action :corporativa, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:2).update_all( cantidad:1 )
        redirect_to admin_dashboard_path
      end

      member_action :autorizado, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:3).update_all( cantidad:1 )
        redirect_to admin_dashboard_path
      end

      member_action :mgp, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:4).update_all( cantidad:1 )
        redirect_to admin_dashboard_path
      end

      member_action :corporativo, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:5).update_all( cantidad:1 )
        redirect_to admin_dashboard_path
      end








          form do |f|
          if params[:id] then
              n1=Formula.where(id:params[:id]).
                       select('product_id as dd').first.dd.to_i
               nn=Product.where(id:n1).
                        select('nombre as dd').first.dd.capitalize
            f.inputs "#{nn}" do
               f.input :product_id, :label => 'Producto', :as => :select, :collection =>
                      Product.all.order('nombre ASC').map{|u| [u.nombre, u.id]}

               f.input :nombre, :input_html => { :style =>  'width:30%'}
               f.input :descripcion
               f.input :orden, :input_html => { :style =>  'width:30%'}
               f.input :cantidad, :input_html => { :style =>  'width:30%'}
               f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


               end
              f.actions
          else

               nn=Product.where(id:params[:product_id]).
                        select('nombre as dd').first.dd.capitalize
           f.inputs "#{nn}" do
              f.input :product_id, :label => 'Producto' ,
                       :input_html => { :value => params[:product_id]}, :as => :hidden
              f.input :nombre, :input_html => { :style =>  'width:30%'}
              f.input :descripcion
              f.input :orden, :input_html => { :style =>  'width:30%'}
              f.input :cantidad, :input_html => { :style =>  'width:30%'}
              f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
           end
              f.actions
        end
end


show do


          attributes_table do
        if params[:id] then
                n1=Formula.where(id:params[:id]).
                         select('product_id as dd').first.dd.to_i
                 nn=Product.where(id:n1).
                          select('nombre as dd').first.dd.capitalize
        else
            nn=Product.where(id:params[:product_id]).
                     select('nombre as dd').first.dd.capitalize
            end
            row :product_id do |formula|
              link_to "#{nn}", admin_product_path(formula.product_id)
            end
            row :nombre
            row :descripcion
            row :orden
            row :cantidad
            row :obs
            row :admin_user_id
          end

      end







end
