ActiveAdmin.register Phase do

  ActiveAdmin.register Activity do
  belongs_to :phase
  end

  ActiveAdmin.register Piece do
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
permit_params :nomenclatura, :descripcion,:moneda, :valor,:expediente,
              :admin_user_id, :periodo, :convocatoria, :sele3, :proceso

menu priority: 10, label: "Procesos"



scope :AF_2017, :default => true do |phases|
     phases.where(periodo:3).where.not(expediente:0)
end

scope :AF_2016, :default => true do |phases|
phases.where(periodo:2).where.not(expediente:0)
end

scope :AF_2015, :default => true do |phases|
phases.where(periodo:1).where.not(expediente:0)
end

scope :Todos, :default => true do |phases|
     phases
end


scope :Otros, :default => true do |phases|

     phases.where(expediente:0).order('id')
end
scope :Auditados, :default => true do |phases|
     phases.where(sele3:2)
end



filter :nomenclatura
filter :convocatoria
filter :descripcion
filter :expediente, :as => :select, :collection =>
     Formula.where(product_id:16).order('nombre ASC').map{|u| ["#{u.nombre}", u.orden]}

 filter :sele, label:'Direccion', :as => :select, :collection =>
          Formula.where(product_id:10).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}





action_item :auditado, only: :show do
        link_to   'Auditado', auditado_admin_phase_path(params[:id]), method: :put
end

action_item :noauditado, only: :show do
        link_to   'No auditado', noauditado_admin_phase_path(params[:id]), method: :put
end

action_item :enproceso, only: :show do
        link_to   'En progreso', enproceso_admin_phase_path(params[:id]), method: :put
end


member_action :auditado, method: :put do
  case current_admin_user.id # a_variable is the variable we want to compare
  when 2,3,10,25 # administrador,roy
        proc=Phase.find(params[:id])
        proc.update(sele3:2)
        redirect_to admin_phase_path(proc)
    end
  end




  member_action :noauditado, method: :put do
    case current_admin_user.id # a_variable is the variable we want to compare
    when 2,3,10,25 # administrador,roy
           proc=Phase.find(params[:id])
           proc.update(sele3:1)
           redirect_to admin_phase_path(proc)
       end
    end

    member_action :enproceso, method: :put do
      case current_admin_user.id # a_variable is the variable we want to compare
      when 2,3,10,25 # administrador,roy
            proc=Phase.find(params[:id])
            proc.update(sele3:3)
            redirect_to admin_phase_path(proc)
        end
      end




index :title => 'Lista de Procesos' do
column("id") do |phase|
   link_to "#{phase.id} ", admin_phase_pieces_path(phase)
end
column("nomenclatura") do |phase|

   link_to "#{phase.nomenclatura} ", admin_phase_activities_path(phase)
end
 column("convocatoria")
 column("descripcion") do |phase|
  phase.descripcion.capitalize

 end
 column("moneda") do |phase|
     if phase.moneda then
        Formula.where(product_id:7,orden:phase.moneda).select('nombre as dd').first.dd.to_s
      end
  end
column("Referencial")  do |phase|
   if phase.valor then
   number_with_delimiter(phase.valor.to_int, delimiter: ",")
   end
 end
 column("expediente")do |phase|
     if phase.expediente and phase.expediente>0 then

        Formula.where(product_id:16, orden:phase.expediente).
         select('nombre as dd').first.dd

       else
           "s/d"
       end
   end
   column("auditado") do |phase|
      if  phase.sele3 and  phase.sele3>0 then

        Formula.where(product_id:29, orden: phase.sele3).
          select('descripcion as dd').first.dd

      else
           "s/d "
      end

   end
  actions
end

form :title => 'Edicion Procesos' do |f|

    f.inputs  do
 f.input :nomenclatura , :input_html => { :style =>  'width:30%'}
 f.input :proceso , :input_html => { :style =>  'width:30%'}
 f.input :convocatoria , :input_html => { :style =>  'width:30%'}
 f.input :descripcion ,:label => 'Descripcion del bien o servicio'
 f.input :moneda, :as => :select, :collection =>
          Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

 f.input :valor,:label => 'Valor Referencial', :as => :string, :input_html => { :style =>  'width:30%'}
 f.input :expediente, :input_html => { :style =>  'width:60%'}, :as => :select, :collection =>
   Formula.where(product_id:16).order('nombre').map{|u| [u.nombre+"-"+u.descripcion, u.orden]}
 f.input :periodo, :as => :select, :collection =>
    Formula.where(product_id:11).order('orden').map{|u| [u.nombre, u.orden]}
  #  f.input :sele3,:label => 'Auditado', :as => :select, :collection =>
  #     Formula.where(product_id:29).order('orden').map{|u| [u.descripcion, u.orden]}
f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
  f.actions




    end #de inputs
end #de form

show :title => ' Proceso'  do

    attributes_table  do

      row :nomenclatura
      row :proceso
      row :convocatoria
      row :descripcion
      row :moneda do |phase|
          if phase.moneda and phase.moneda>0 then

             Formula.where(product_id:7, orden:phase.moneda).
              select('nombre as dd').first.dd

            else
                "s/d"
            end
        end
        row "Valor Referencial" do |phase|

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
          row :periodo do |phase|
             if  phase.periodo and  phase.periodo>0 then
                Formula.where(product_id:11, orden: phase.periodo).
                 select('nombre as dd').first.dd
             else
                   "s/d"
             end

          end
          row "auditado" do |phase|
             if  phase.sele3 and  phase.sele3>0 then
                Formula.where(product_id:29, orden: phase.sele3).
                 select('descripcion as dd').first.dd
             else
                   "s/d"
             end

          end
  end #de attributes_table

end # de show
















end
