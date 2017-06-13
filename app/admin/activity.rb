ActiveAdmin.register Activity do
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
              :obs, :admin_user_id, :phase_id,:moneda,
              :created_at,:updated_at,:plan


#scope :PAC, :default => true do |activities|
#   activities.where(phase_id:params[:phase_id])
#end

filter :pfecha

index :title => "Lista de Actividades Procesos"  do

column("Actividad", :sortable => :phase_id) do |activity|
  n1=Formula.where(product_id:12,orden:activity.actividad).
          select('descripcion as dd').first.dd.capitalize

                    link_to "#{n1} ",  admin_phase_activity_path(params[:phase_id],activity)
end
column("pfecha") do |activity|
  if activity.pfecha then
    activity.pfecha.strftime("%d-%m-%Y")
  else
    "s/d"
  end
end
column("plan") do |activity|
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

  end
end
  actions


end
end
