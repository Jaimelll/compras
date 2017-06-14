ActiveAdmin.register Phase do

  ActiveAdmin.register Activity do
  belongs_to :phase
  end

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
permit_params :nomenclatura, :descripcion,:moneda, :valor,:expediente


menu priority: 5, label: "Procesos"

filter :expediente, :as => :select, :collection =>
     Formula.where(product_id:16).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}


index :title => 'Lista de Procesos' do

column("nomenclatura") do |phase|

   link_to "#{phase.nomenclatura} ", admin_phase_activities_path(phase)
end

 column("descripcion") do |phase|
  phase.descripcion.capitalize

 end
 column("moneda") do |phase|
     if phase.moneda then
        Formula.where(product_id:7,orden:phase.moneda).select('nombre as dd').first.dd.to_s
      end
  end
column("valor")  do |phase|
   number_with_delimiter(phase.valor.to_int, delimiter: ",")
 end
 column("expediente")do |phase|
     if phase.expediente and phase.expediente>0 then

        Formula.where(product_id:16, orden:phase.expediente).
         select('nombre as dd').first.dd

       else
           "s/d"
       end
   end
  actions
end

form :title => 'Edicion Procesos' do |f|

    f.inputs  do
 f.input :nomenclatura , :input_html => { :style =>  'width:30%'}
 f.input :descripcion ,:label => 'Descripcion del bien o servicio'
 f.input :moneda, :as => :select, :collection =>
          Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

 f.input :valor,:label => 'Valor estimado DPC', :as => :string, :input_html => { :style =>  'width:30%'}
 f.input :expediente, :input_html => { :style =>  'width:60%'}, :as => :select, :collection =>
   Formula.where(product_id:16).order('nombre').map{|u| [u.nombre+"-"+u.descripcion, u.orden]}


  f.actions




    end #de inputs
end #de form

show :title => ' Proceso'  do

    attributes_table  do

      row :nomenclatura
      row :descripcion
      row :moneda do |phase|
          if phase.moneda and phase.moneda>0 then

             Formula.where(product_id:7, orden:phase.moneda).
              select('nombre as dd').first.dd

            else
                "s/d"
            end
        end
        row "Valor estimado PAC" do |phase|

           number_with_delimiter(phase.valor, delimiter: ",")

          end
          row :expediente do |phase|

             if  phase.expediente and  phase.expediente>0 then

                Formula.where(product_id:16, orden: phase.expediente).
                 select('nombre as dd').first.dd

               else
                   "s/d"
               end
          end
  end #de attributes_table

end # de show













sidebar "Procesos Links" , only: :index do


  ul do
    li link_to "Programa de presentaciones de propuestas ", reports_comment4_path(format: :pdf,  :param1=> 1)
  li link_to "Historial Presentaciones de propuestas ", reports_comment4_path(format: :pdf,  :param1=> 2)

  end


end



end
