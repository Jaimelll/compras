ActiveAdmin.register Package do
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






permit_params :item, :moneda,:adjudicado,
                :presupuestado,:contract_id, :admin_user_id


filter :descripcion



index :title => "Lista de Items"  do

column("item")
column("moneda") do |activity|
  if activity.moneda and activity.moneda>0 then

    Formula.where(product_id:7,orden:activity.moneda).select('nombre as dd').first.dd.to_s

  end# de if column
end# de column
column("adjudicado") do |piece|
 number_with_delimiter(piece.adjudicado, delimiter: ",")
end
column("presupuestado") do |piece|
 number_with_delimiter(piece.presupuestado, delimiter: ",")
end




actions


end #de index




form :title => 'Edicion Item'  do |f|


      f.inputs  do



             f.input :item, :input_html => { :style =>  'width:30%'}

             f.input :moneda, :as => :select, :collection =>
                      Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}


             f.input :adjudicado,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :presupuestado,:as =>:string, :input_html => { :style =>  'width:30%'}

 f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
                   end
            f.actions



        #    no tiene parametros y la ruta no pasa por item

      end #de form

      show :title => ' ITEM ' do

         attributes_table do


                  row :item

                   row :moneda do |detail|
                       if detail.moneda and detail.moneda>0 then

                          Formula.where(product_id:7, orden:detail.moneda).
                           select('nombre as dd').first.dd

                         else
                             "s/d"
                         end
                     end



                      row :adjudicado do |activity|

                         number_with_delimiter(activity.adjudicado, delimiter: ",")

                        end

                        row :presupuestado do |activity|

                           number_with_delimiter(activity.presupuestado, delimiter: ",")

                          end

                         row :admin_user_id

                  end

end
end #de Package
