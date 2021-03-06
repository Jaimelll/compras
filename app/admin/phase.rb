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
              :admin_user_id, :periodo, :convocatoria, :sele3, :proceso,
              :sele4, :comite, :postores, :obs,
              :ep, :mgp, :fap, :ccffaa,  :sele5,  :convo
#se puede usar sele3 era para autidados
menu priority: 10, label: "Buscador Procesos"

scope :ACFFAA, :default => true do |phases|

     phases.where(periodo:current_admin_user.periodo).where.not(expediente:0)
end

scope :"Nulo/D/C", :default => true do |phases|
     phases.where(periodo:current_admin_user.periodo,sele:1).where.not(expediente:0)
end

scope :"GEX", :default => true do |phases|
     phases.where(periodo:current_admin_user.periodo,sele:2).where.not(expediente:0)
end
scope :"DC", :default => true do |phases|
     phases.where(periodo:current_admin_user.periodo,sele:3).where.not(expediente:0)
end
scope :"DEM", :default => true do |phases|
     phases.where(periodo:current_admin_user.periodo,sele:4).where.not(expediente:0)
end
scope :"DPC", :default => true do |phases|
     phases.where(periodo:current_admin_user.periodo,sele:5).where.not(expediente:0)
end
scope :"FC", :default => true do |phases|
     phases.where(periodo:current_admin_user.periodo,sele:6).where.not(expediente:0)
end
scope :"EC", :default => true do |phases|
     phases.where(periodo:current_admin_user.periodo,sele:7).where.not(expediente:0)
end




scope :Todos, :default => true do |phases|
    phases.where(periodo:current_admin_user.periodo)
end
#scope :Auditados, :default => true do |phases|
#     phases.where(sele3:2)
#end



filter :proceso
filter :convo, label:'Año Convocatoria', :as => :select, :collection =>
     Formula.where(product_id:11).order('nombre ASC').map{|u| ["#{u.nombre}", u.orden]}

filter :descripcion
filter :expediente, :as => :select, :collection =>
     Formula.where(product_id:16).order('nombre ASC').map{|u| ["#{u.nombre}", u.orden]}

 filter :sele, label:'Etapa', :as => :select, :collection =>
          Formula.where(product_id:10).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :convocatoria, label:'Numero Convocatoria'




#action_item :auditado, only: :show do
#        link_to   'Auditado', auditado_admin_phase_path(params[:id]), method: :put
#end

#action_item :noauditado, only: :show do
#        link_to   'No auditado', noauditado_admin_phase_path(params[:id]), method: :put
#end

#action_item :enproceso, only: :show do
#        link_to   'En progreso', enproceso_admin_phase_path(params[:id]), method: :put
#end


#member_action :auditado, method: :put do
#  case current_admin_user.categoria # a_variable is the variable we want to compare
#  when 2,3,10,25 # administrador,roy
#        proc=Phase.find(params[:id])
#        proc.update(sele3:2)
#      redirect_to admin_phase_path(proc)
#    end
#  end




#  member_action :noauditado, method: :put do
#    case current_admin_user.categoria # a_variable is the variable we want to compare
#    when 2,3,10,25 # administrador,roy
#           proc=Phase.find(params[:id])
#           proc.update(sele3:1)
#           redirect_to admin_phase_path(proc)
#       end
#    end

#    member_action :enproceso, method: :put do
#      case current_admin_user.categoria # a_variable is the variable we want to compare
#      when 2,3,10,25 # administrador,roy
#            proc=Phase.find(params[:id])
#            proc.update(sele3:3)
#            redirect_to admin_phase_path(proc)
#        end
#      end




index :title => proc {"BUSCADOR PROCESOS  "+ Formula.where(product_id:11,orden:current_admin_user.periodo).select('descripcion as dd').first.dd }   do
$vaf=current_admin_user.periodo

column("proceso", :sortable => :proceso) do |phase|
   link_to "#{phase.proceso} ", admin_phase_pieces_path(phase)
end

column("expediente") do |phase|
    if phase.expediente and phase.expediente>0 then

      vexp=Formula.where(product_id:16, orden:phase.expediente).
        select('nombre as dd').first.dd

      else
        vexp=  "s/d"
      end
      link_to vexp, admin_phase_activities_path(phase)
  end
column("Convoca", :sortable => :convo) do |phase|
   if phase.convo and phase.convo>0 then
       vcon=Formula.where(product_id:11, orden:phase.convo).
       select('nombre as dd').first.dd
    else
       vcon=  "s/d"
    end

  end

 column("descripcion") do |phase|
  phase.descripcion.upcase

 end
 column("estado") do |phase|
     if phase.sele3 then
        Formula.where(product_id:20,orden:phase.sele3).select('nombre as dd').first.dd.to_s
     else
        "Nulo/D/C"
     end
  end


 column("Ref/Adju(soles)", :class => 'text-right', sortable: :sele2)  do |phase|
    if phase.sele2 then
 #  vval= phase.valor*Formula.where(product_id:7,orden:phase.moneda,numero:phase.periodo).select('cantidad as dd').first.dd/100

    number_with_delimiter(phase.sele2.to_int, delimiter: ",")
    else
      "s/d"
    end
  end


  # column("auditado") do |phase|
#      if  phase.sele3 and  phase.sele3>0 then

  #      Formula.where(product_id:29, orden: phase.sele3).
  #        select('descripcion as dd').first.dd

  #    else
  #         "s/d "
  #    end

  # end
  actions
end

form :title => 'Edicion Procesos' do |f|

    f.inputs  do

 f.input :nomenclatura , :input_html => { :style =>  'width:30%'}
 f.input :proceso , :input_html => { :style =>  'width:30%'}
 f.input :convocatoria , :input_html => { :style =>  'width:30%'}
 f.input :descripcion ,:label => 'Descripcion del bien o servicio'
 f.input :moneda, :as => :select, :collection =>
          Formula.where(product_id:7,numero:$vaf).map{|u| [u.nombre.capitalize, u.orden]}

 f.input :valor,:label => 'Valor Referencial', :as => :string, :input_html => { :style =>  'width:30%'}
 f.input :expediente, :input_html => { :style =>  'width:60%'}, :as => :select, :collection =>
   Formula.where(product_id:16).order('nombre').map{|u| [u.nombre+"-"+u.descripcion, u.orden]}
 f.input :periodo, :as => :select, :collection =>
    Formula.where(product_id:11,acti:1).order('orden').map{|u| [u.nombre, u.orden]}
    f.input :sele4,:label => 'Especialista encargado', :as => :select, :collection =>
       Formula.where(product_id:34).order('orden').map{|u| [u.nombre, u.orden]}
f.input :admin_user_id, :input_html => { :value => current_admin_user.categoria }, :as => :hidden
f.input :comite ,:label => 'Miembros de comité'
f.input :postores ,:label => 'Lista de postores'
f.input :ep,:label => 'Monto Adjudicado EP', :as => :string, :input_html => { :style =>  'width:30%'}
f.input :mgp,:label => 'Monto Adjudicado MGP', :as => :string, :input_html => { :style =>  'width:30%'}
f.input :fap,:label => 'Monto Adjudicado FAP', :as => :string, :input_html => { :style =>  'width:30%'}
f.input :ccffaa,:label => 'Monto Adjudicado CCFFAA', :as => :string, :input_html => { :style =>  'width:30%'}
f.input :convo,:label => 'Año de Convocatoria' , :as => :select, :collection =>
   Formula.where(product_id:11,acti:1).order('orden').map{|u| [u.nombre, u.orden]}
f.input :sele5,:label => 'Proceso de origen', :as => :select, :collection =>
   Phase.where(periodo:$vaf).order('proceso').map{|u| [u.proceso, u.id]}

  f.actions




    end #de inputs
end #de form

show :title => ' Proceso'  do

    attributes_table  do



      row "Nomenclatura (link items)" do |phase|
        link_to "#{phase.nomenclatura} ", admin_phase_pieces_path(phase)
     end
      row "Proceso (link actividades)" do |phase|
        link_to "#{phase.proceso} ", admin_phase_activities_path(phase)
     end

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
          row "Especialista encargado" do |phase|
             if  phase.sele4 and  phase.sele4>0 then
                Formula.where(product_id:34, orden: phase.sele4).
                 select('nombre as dd').first.dd
             else
                   "s/d"
             end

          end
          row "Miembros de comité" do |phase|
            phase.comite
          end
          row "Lista de postores" do |phase|
            phase.postores
          end
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
          row "Año de Convocatoria" do |phase|
             if  phase.convo and  phase.convo>0 then
                Formula.where(product_id:11, orden: phase.convo).
                 select('nombre as dd').first.dd
             else
                   "s/d"
             end

          end
          row "Proceso de origen" do |phase|
            if  phase.sele5 and  phase.sele5>0 then
              Phase.where(id:phase.sele5).select('proceso as dd').first.dd
            else
                  "s/d"
            end
          end


  end #de attributes_table

end # de show
















end
