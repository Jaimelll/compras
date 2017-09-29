ActiveAdmin.register Formula do

menu false
permit_params  :nombre, :descripcion,  :orden,
   :cantidad, :admin_user_id, :product_id,
     :numero, :acti




      action_item :view, only: :show do
        link_to 'Ir a Productos', admin_products_path()
      end

      member_action :af, method: :put do
        case current_admin_user.id # a_variable is the variable we want to compare
        when 2,3,13,14 # administrador,roy, dpc, dec

         @vaf=Formula.where(product_id:11,cantidad:1).select('numero as dd').first.dd
         @num=Formula.where(product_id: 11, orden:@vaf).
                select('id as dd').first.dd
        Formula.where( product_id:11 ).update_all( cantidad:0 )
        Formula.where( product_id:11 ,orden:@vaf).update_all( cantidad:1 )

    #cambiar a encargo
    @num=Formula.where(product_id: 15, orden:1).
           select('id as dd').first.dd
    Formula.where( product_id:15 ).update_all( cantidad:0 )
    Formula.where( product_id:15 ,orden:1).update_all( cantidad:1 )
    redirect_to admin_dashboard_path


        end
      end



      member_action :encargo, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:1).update_all( cantidad:1 )
        redirect_to admin_grafico_path
      end

      member_action :corporativa, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:2).update_all( cantidad:1 )
        redirect_to admin_grafico_path
      end

      member_action :autorizado, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:3).update_all( cantidad:1 )
        redirect_to admin_grafico_path
      end

      member_action :dec, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
               select('id as dd').first.dd
       Formula.where( product_id:15 ).update_all( cantidad:0 )
      Formula.where( product_id:15 ,orden:4).update_all( cantidad:1 )
       redirect_to admin_grafico_path
      end

      member_action :excluido, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
                select('id as dd').first.dd
        Formula.where( product_id:15 ).update_all( cantidad:0 )
        Formula.where( product_id:15 ,orden:5).update_all( cantidad:1 )
        redirect_to admin_grafico_path
      end

      member_action :dpc, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
               select('id as dd').first.dd
       Formula.where( product_id:15 ).update_all( cantidad:0 )
      Formula.where( product_id:15 ,orden:6).update_all( cantidad:1 )
      redirect_to admin_grafico_path
      end

      member_action :dem, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
               select('id as dd').first.dd
       Formula.where( product_id:15 ).update_all( cantidad:0 )
      Formula.where( product_id:15 ,orden:7).update_all( cantidad:1 )
       redirect_to admin_grafico_path
      end

      member_action :gex, method: :put do
         @num=Formula.where(product_id: 15, orden:1).
               select('id as dd').first.dd
       Formula.where( product_id:15 ).update_all( cantidad:0 )
      Formula.where( product_id:15 ,orden:8).update_all( cantidad:1 )
       redirect_to admin_grafico_path
      end

#grafico0
member_action :dpc2, method: :put do
   @num=Formula.where(product_id: 15, orden:9).
         select('id as dd').first.dd
 Formula.where( product_id:15 ).update_all( numero:0 )
Formula.where( product_id:15 ,orden:9).update_all( numero:1 )
 redirect_to admin_grafico0_path
end

member_action :dec2, method: :put do
   @num=Formula.where(product_id: 15, orden:10).
         select('id as dd').first.dd
 Formula.where( product_id:15 ).update_all( numero:0 )
Formula.where( product_id:15 ,orden:10).update_all( numero:1 )
 redirect_to admin_grafico0_path
end


member_action :indica, method: :put do
  @num=Formula.where(product_id: 15, orden:11).
         select('id as dd').first.dd
 Formula.where( product_id:15 ).update_all( cantidad:0 )
  Formula.where( product_id:15 ,orden:11).update_all( cantidad:1 )
  redirect_to admin_grafico_path
end





filter :nombre
filter :descripcion
filter :cantidad
filter :numero
filter :orden
filter :acti


      index do
        column("nombre")do |formula|
          link_to "#{formula.nombre}", admin_products_path()
        end
        column("descripcion")
        column("orden")
        column("cantidad")
        column("numero")
        column("acti")
          actions
      end








          form do |f|


               nn=Product.where(id:params[:product_id]).
                        select('nombre as dd').first.dd.capitalize
              f.inputs "#{nn}" do
              f.input :product_id, :label => 'Producto' ,
                       :input_html => { :value => params[:product_id]}, :as => :hidden
              f.input :nombre, :input_html => { :style =>  'width:30%'}
              f.input :descripcion
              f.input :orden, :input_html => { :style =>  'width:30%'}
              f.input :cantidad, :input_html => { :style =>  'width:30%'}
              f.input :numero, :input_html => { :style =>  'width:30%'}
              f.input :acti, :input_html => { :style =>  'width:30%'}
              f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
           end
              f.actions
        end



show do


          attributes_table do

            nn=Product.where(id:params[:product_id]).
                     select('nombre as dd').first.dd.capitalize

            row :product_id do |formula|
              link_to "#{nn}", admin_product_formulas_path(formula.product_id)
            end
            row :nombre
            row :descripcion
            row :orden
            row :cantidad
            row :numero
            row :acti
            row :admin_user_id
          end

      end






end
