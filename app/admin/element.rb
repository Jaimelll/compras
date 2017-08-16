ActiveAdmin.register Element do
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
              :obs, :admin_user_id, :contract_id,:moneda,
              :created_at,:updated_at,:plan,:inicial


#scope :PAC, :default => true do |activities|
#   activities.where(phase_id:params[:phase_id])
#end

filter :pfecha

index :title => "Lista de Actividades Contratos"  do

column("Actividad", :sortable => :phase_id) do |activity|
  n4=Formula.where(product_id:19,orden:activity.actividad).
          select('orden as dd').first.dd


  n2=Formula.where(product_id:19,orden:activity.actividad).
          select('cantidad as dd').first.dd
  n1=Formula.where(product_id:19,orden:activity.actividad).
          select('descripcion as dd').first.dd.capitalize+
           "-----"+
            "#{Formula.where(product_id:18,orden:n2).
                     select('nombre as dd').first.dd}"


                  link_to "#{n1} ", admin_contract_element_path(params[:contract_id],activity)
end
column("Fecha Final", :sortable => :pfecha) do |activity|
  if activity.pfecha then
    activity.pfecha.strftime("%d-%m-%Y")
  else
    "s/d"
  end
end

column("Fecha Inicial", :sortable => :pfecha) do |activity|
  if activity.inicial then
    activity.inicial.strftime("%d-%m-%Y")
  else
    "s/d"
  end
end

column("Programada", :sortable => :plan) do |activity|
  if activity.plan then
     activity.plan.strftime("%d-%m-%Y")
  else

  "s/d"

   end
end
column("tipo")
column("numero")
column("obs")
column("importe") do |activity|
 number_with_delimiter(activity.importe, delimiter: ",")
end
column("moneda") do |activity|
  if activity.moneda and activity.moneda>0 then

    Formula.where(product_id:7,orden:activity.moneda).select('nombre as dd').first.dd.to_s

  end# de if column
end# de column
actions


end #de index

form :title => 'Edicion Actividad'  do |f|


      f.inputs  do


             f.input :actividad, :as => :select, :collection =>


                 Formula.where(product_id:19).order("numero,descripcion").
                   map{|u| [u.descripcion.capitalize,
                    u.orden]}



             f.input :tipo,:label => 'Documento de recepcion', :input_html => { :style =>  'width:30%'}
             f.input :numero,:label => 'Numero de documento', :input_html => { :style =>  'width:30%'}
             f.input :pfecha, :label => 'fecha final' ,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :inicial, :label => 'fecha inicial' ,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :plan, :label => 'fecha programada final' ,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :importe,:label => 'Importe ',:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :moneda, :as => :select, :collection =>
                      Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

             f.input :obs, :input_html => { :style =>  'width:30%'}
             f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


                   end
            f.actions



        #    no tiene parametros y la ruta no pasa por item

      end #de form

      show :title => ' ACTIVIDAD ' do


                attributes_table do

                nn=Contract.where(id:params[:contract_id]).
                         select('descripcion as dd').first.dd.capitalize


                  row "Ir Lista Actividades Contratos" do |activity|
                    link_to "#{nn}", admin_contract_elements_path(activity.contract_id)
                  end

                  row :actividad do |activity|
                      if activity.actividad and activity.actividad>0 then

                         Formula.where(product_id:19, orden:activity.actividad).
                          select('descripcion as dd').first.dd

                        else
                            "s/d"
                        end
                    end
                  row :tipo
                  row :numero



                  row "fecha final " do |activity|

                     activity.pfecha.strftime("%d-%m-%Y")
                   end

                   row "fecha inicial " do |activity|
                     if activity.inicial then

                        activity.inicial.strftime("%d-%m-%Y")
                     else
                        "s/d"
                      end
                    end


                  row "Fecha Programada Final" do |activity|
                    if activity.plan then
                       activity.plan.strftime("%d-%m-%Y")
                    else
                      Element.where( contract_id:activity.contract_id,id:contract.id).update_all( plan:activity.pfecha )
                      "s/d"
                     end
                   end

                  row :importe do |activity|

                     number_with_delimiter(activity.importe, delimiter: ",")

                    end



                  row :moneda do |detail|
                      if detail.moneda and detail.moneda>0 then

                         Formula.where(product_id:7, orden:detail.moneda).
                          select('nombre as dd').first.dd

                        else
                            "s/d"
                        end
                    end

                  row :obs
                  row :admin_user_id

                end

            end









end
