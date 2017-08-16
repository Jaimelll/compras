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


column("item") do |contra|
     if contra.item and contra.item>0 then
             Piece.where(id:contra.item).
         select('descripcion as dd').first.dd

       else
           "s/d"
       end
   end
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

            vproce=Contract.where(id:params[:contract_id]).select('proceso as dd').first.dd


             f.input :item, :as => :select, :collection =>
                      Piece.where(phase_id:vproce).order('codigo').map{|u| [u.codigo+'-'+u.descripcion, u.id]}


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

           row :item  do |contra|
                if contra.item and contra.item>0 then
                  pp= Piece.where(id:contra.item).
                    select('descripcion as dd').first.dd

   link_to "#{pp}", admin_contract_packages_path(contra.contract_id)
                  else
                      "s/d"
                  end
              end


                  row :item do |activity|

                  end
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
