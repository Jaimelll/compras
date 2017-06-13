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

 column("descripcion")
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





end
