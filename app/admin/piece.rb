ActiveAdmin.register Piece do
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


permit_params :codigo, :descripcion,:cantidad, :moneda,:presupuestado,
             :referencial, :adjudicado,:estado, :postor,:phase_id,
             :admin_user_id

filter :descripcion
index :title => "Lista de Items"  do

column("codigo")
column("descripcion")
column("cantidad")
column("moneda") do |activity|
  if activity.moneda and activity.moneda>0 then

    Formula.where(product_id:7,orden:activity.moneda).select('nombre as dd').first.dd.to_s

  end# de if column
end# de column

column("presupuestado") do |piece|
 number_with_delimiter(piece.presupuestado, delimiter: ",")
end
column("referencial") do |piece|
 number_with_delimiter(piece.referencial, delimiter: ",")
end
column("adjudicado") do |piece|
 number_with_delimiter(piece.adjudicado, delimiter: ",")
end
column("estado") do |activity|
  if activity.estado and activity.estado>0 then

    Formula.where(product_id:17,orden:activity.estado).select('nombre as dd').first.dd.to_s

  end# de if column
end# de column




actions


end #de index




form :title => 'Edicion Item'  do |f|


      f.inputs  do



             f.input :codigo, :input_html => { :style =>  'width:30%'}
             f.input :descripcion, :input_html => { :style =>  'width:30%'}
             f.input :cantidad, :input_html => { :style =>  'width:30%'}
             f.input :moneda, :as => :select, :collection =>
                      Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

             f.input :presupuestado,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :referencial,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :adjudicado,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :estado, :as => :select, :collection =>
                      Formula.where(product_id:17).map{|u| [u.nombre.capitalize, u.orden]}


             f.input :postor, :input_html => { :style =>  'width:30%'}

             f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


                   end
            f.actions



        #    no tiene parametros y la ruta no pasa por item

      end #de form

      show :title => ' ITEM ' do


                attributes_table do

                nn=Phase.where(id:params[:phase_id]).
                         select('nomenclatura as dd').first.dd.capitalize


                  row "Ir Lista de Items" do |activity|
                    link_to "#{nn}", admin_phase_pieces_path(piece.phase_id)
                  end


                  row :codigo
                  row :descripcion

                  row :cantidad


                   row :moneda do |detail|
                       if detail.moneda and detail.moneda>0 then

                          Formula.where(product_id:7, orden:detail.moneda).
                           select('nombre as dd').first.dd

                         else
                             "s/d"
                         end
                     end

                  row :presupuestado do |activity|

                     number_with_delimiter(piece.presupuestado, delimiter: ",")

                    end
                    row :referencial do |activity|

                       number_with_delimiter(piece.referencial, delimiter: ",")

                      end
                      row :adjudicado do |activity|

                         number_with_delimiter(piece.adjudicado, delimiter: ",")

                        end
                        row :estado do |detail|
                            if detail.estado and detail.estado>0 then

                               Formula.where(product_id:17, orden:detail.estado).
                                select('nombre as dd').first.dd

                              else
                                  "s/d"
                              end
                          end


                  row :postor
                  row :admin_user_id

                end

            end


            sidebar "Datos del Proceso" do
              if params[:phase_id] then
                 nn=Phase.where(id:  params[:phase_id]).
                          select('nomenclatura as dd').first.dd.downcase
                  n1=Phase.where(id:  params[:phase_id]).
                           select('moneda as dd').first.dd
                 n11=Phase.where(id:  params[:phase_id]).
                          select('expediente as dd').first.dd

                  n2= Phase.where(id:params[:phase_id]).
                           select('descripcion as dd').first.dd.capitalize
                  n3=Formula.where(product:7,orden:n1).
                        select('nombre as dd').first.dd.capitalize

                  n31=Formula.where(product:16,orden:n11).
                       select('nombre as dd').first.dd.capitalize
                  n4=Phase.where(id:  params[:phase_id]).
                                select('valor as dd').first.dd.to_s

              ul do
                li "PROCESO :   "+nn
                li "DESCRIPCION : "+n2
                li "MONEDA :  "+n3
                li "VALOR ESTIMADO :"+  number_with_delimiter(n4, delimiter: ",").to_s
                li "EXPEDIENTE :  "+n31
              end# de ul


            end# de if
            end # de sider


      end#de piece
