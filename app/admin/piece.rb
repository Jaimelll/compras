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
             :admin_user_id, :canti_dem,:sele,
             :prop_obac, :invi_dem,:invi_dpc, :presenta,:admitido,
             :resulta, :version,:tipo_postor, :motivo,:proceso,
             :pasan,
             :ep, :mgp, :fap, :ccffaa

             action_item :view, only:[:show,:new,:index]do
               if params[:phase_id] then
             nn=Phase.where(id:params[:phase_id]).
                      select('proceso as dd').first.dd
                   link_to "Ir a -#{nn}", admin_phase_path(params[:phase_id])
               end
              end




filter :descripcion
index :title => "Lista de Items"  do

column("codigo")
column("descripcion")
column('Postores DPC') do |item|
  item.cantidad
end

column('Postores DEM') do |item|
  item.canti_dem
end
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
             f.input :moneda, :as => :select, :collection =>
                      Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

             f.input :presupuestado,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :referencial,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :adjudicado,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :estado, :as => :select, :collection =>
                      Formula.where(product_id:17).map{|u| [u.nombre.capitalize, u.orden]}


             f.input :postor, :input_html => { :style =>  'width:30%'}

             f.input :ep,:label => 'Monto Adjudicado EP', :as => :string, :input_html => { :style =>  'width:30%'}
             f.input :mgp,:label => 'Monto Adjudicado MGP', :as => :string, :input_html => { :style =>  'width:30%'}
             f.input :fap,:label => 'Monto Adjudicado FAP', :as => :string, :input_html => { :style =>  'width:30%'}
             f.input :ccffaa,:label => 'Monto Adjudicado CCFFAA', :as => :string, :input_html => { :style =>  'width:30%'}
             
             f.input :sele,:label => 'Nuevo proceso', :as => :select, :collection =>
                     Phase.where('convocatoria>1').map{|u| [u.nomenclatura.downcase, u.id]}


             f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
              f.input :prop_obac,:label => 'Propuestos por OBAC', :input_html => { :style =>  'width:30%'}
              f.input :canti_dem,:label => 'Invitados por DEM', :input_html => { :style =>  'width:30%'}
              f.input :cantidad,:label => 'Invitados por DPC', :input_html => { :style =>  'width:30%'}
              f.input :presenta,:label => 'Se presentan', :input_html => { :style =>  'width:30%'}
              f.input :admitido,:label => 'Admitidos', :input_html => { :style =>  'width:30%'}
              f.input :pasan, :label => 'Pasan evaluacion ET y EE',:input_html => { :style =>  'width:30%'}
              f.input :resulta,:label => 'Resultado', :as => :select, :collection =>
                       Formula.where(product_id:31).map{|u| [u.nombre.capitalize, u.orden]}

              f.input :version,:label => 'Version de Manual', :as => :select, :collection =>
                       Formula.where(product_id:32).map{|u| [u.nombre.capitalize, u.orden]}

              f.input :tipo_postor,:label => 'Tipo de postor', :as => :select, :collection =>
                       Formula.where(product_id:33).map{|u| [u.nombre.capitalize, u.orden]}

              f.input :motivo, :label => 'Motivo de no admision',:input_html => { :style =>  'width:30%'}



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

                  row "Monto Adjudicado EP" do |phase|
                    phase.ep
                  end
                  row "Monto Adjudicado MGP" do |phase|
                    phase.mgp
                  end
                  row "Monto Adjudicado FAP" do |phase|
                    phase.fap
                  end
                  row "Monto Adjudicado CCFFAA" do |phase|
                    phase.ccffaa
                  end

                  row 'Nuevo proceso' do |detail|
                    if detail.sele then
                     Phase.where(id: detail.sele).
                           select('nomenclatura as dd').first.dd.downcase
                    end
                   end
                  row :prop_obac
                  row 'Cantidad de Invitados por DEM' do |detail|
                    detail.canti_dem
                  end

                  row 'Cantidad de Invitados por DPC' do |detail|
                    detail.cantidad
                  end

                  row :presenta
                  row :admitido
                  row :pasan

                  row 'Resultado' do |detail|
                  if detail.resulta and detail.resulta>0 then

                     Formula.where(product_id:31, orden:detail.resulta).
                      select('nombre as dd').first.dd

                    else
                        "s/d"
                    end
                end


                row 'Manual version' do |detail|
                if detail.version and detail.version>0 then

                   Formula.where(product_id:32, orden:detail.version).
                    select('nombre as dd').first.dd

                  else
                      "s/d"
                  end
              end

              row 'Tipo de postor' do |detail|
              if detail.tipo_postor and detail.tipo_postor>0 then

                 Formula.where(product_id:33, orden:detail.tipo_postor).
                  select('nombre as dd').first.dd

                else
                    "s/d"
                end
            end







                  row :motivo

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
                 n32=Formula.where(product:16,orden:n11).
                           select('orden as dd').first.dd
                   @vobac=" "
                  if n32>0 then
                   Item.where(exped:n32).order('obac').each do |nobac|
                    @sobac=Formula.where(product_id:1,orden:nobac.obac)
                    .select('nombre as dd').first.dd
                     @vobac=@vobac+ @sobac+"-"+nobac.pac+","
                     end
                     end


              ul do
                li "PROCESO :   "+nn
                li "EXPEDIENTE :  "+n31
                li "OBAC-PAC :  "+ @vobac
                li "DESCRIPCION : "+n2
                li "MONEDA :  "+n3
                li "VALOR ESTIMADO :"+  number_with_delimiter(n4, delimiter: ",").to_s

              end# de ul


            end# de if
            end # de sider


      end#de piece
