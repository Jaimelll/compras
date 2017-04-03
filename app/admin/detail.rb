ActiveAdmin.register Detail do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
menu false
permit_params :actividad, :tipo,:numero, :pfecha,:importe,
              :obs, :admin_user_id, :item_id

  action_item :view, only: :show do
            link_to 'Ir a PACs', admin_items_path()
      end

    form do |f|
        if params[:id] then
#edit
              n1=Detail.where(id:params[:id]).
                       select('item_id as dd').first.dd.to_i
               nn=Item.where(id:n1).
                          select('pac as dd').first.dd.capitalize
          f.inputs "PAC-#{nn}" do
                 f.input :item_id, :label => 'PAC', :as => :select, :collection =>
                      Item.all.order('pac ASC').map{|u| [u.pac, u.id]}

                 f.input :actividad, :as => :select, :collection =>

                          Formula.where(product_id:12).order("orden").map{|u| [u.descripcion.capitalize++"-----"+
                                         "#{Formula.where(product_id:10,orden:u.cantidad).select('nombre as dd').first.dd}" , u.orden]}




                 f.input :tipo, :input_html => { :style =>  'width:30%'}
                 f.input :numero, :input_html => { :style =>  'width:30%'}
                 f.input :pfecha, :label => 'fecha' ,:as =>:string, :input_html => { :style =>  'width:30%'}
                 f.input :importe,:as =>:string, :input_html => { :style =>  'width:30%'}
                 f.input :moneda, :as => :select, :collection =>
                          Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

                 f.input :obs, :input_html => { :style =>  'width:30%'}
                 f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


                       end
                f.actions
          else
#nuevo
               nn=Item.where(id:params[:item_id]).
                        select('pac as dd').first.dd.capitalize
           f.inputs "#{nn}" do
             f.input :item_id, :label => 'PAC' ,
                      :input_html => { :value => params[:item_id]}, :as => :hidden

             f.input :actividad, :as => :select, :collection =>

                      Formula.where(product_id:12).order("orden").map{|u| [u.descripcion.capitalize+"-----"+
                                     "#{Formula.where(product_id:10,orden:u.cantidad).select('nombre as dd').first.dd}" , u.orden]}
             f.input :tipo, :input_html => { :style =>  'width:30%'}
             f.input :numero, :input_html => { :style =>  'width:30%'}
             f.input :pfecha, :label => 'fecha' ,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :importe,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :moneda, :as => :select, :collection =>
                      Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}
             f.input :obs, :input_html => { :style =>  'width:30%'}
             f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden

                   end
                f.actions
                end
          end

          show do


                    attributes_table do
                  if params[:id] then
                    n1=Detail.where(id:params[:id]).
                             select('item_id as dd').first.dd.to_i
                     nn=Item.where(id:n1).
                                select('pac as dd').first.dd.capitalize

                  else
                    nn=Item.where(id:params[:item_id]).
                             select('pac as dd').first.dd.capitalize

                  end
                      row :item_id do |formula|
                        link_to "PAC-#{nn}", admin_item_path(detail.item_id)
                      end
                      row :actividad
                      row :tipo
                      row :numero
                      row :pfecha
                      row :importe
                      row :moneda

                      row :obs
                      row :admin_user_id

                    end

                end





end
