ActiveAdmin.register Contract do
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

ActiveAdmin.register Package do
belongs_to :contract
end

ActiveAdmin.register Element do
belongs_to :contract
end



permit_params :numero, :fecha,:descripcion, :obac,:postor,
              :proveedor, :moneda, :adjudicado,
              :presupuestado, :admin_user_id, :periodo, :proceso

menu priority: 6, label: "Contratos"

scope :AF_2017, :default => true do |phases|
     phases.where(periodo:3)
end

scope :AF_2016, :default => true do |phases|
phases.where(periodo:2)
end

scope :AF_2015, :default => true do |phases|
phases.where(periodo:1)
end

scope :Todos, :default => true do |phases|
     phases
end






filter :numero
filter :descripcion

index :title => 'Lista de Contratos' do
column("id") do |contra|
   link_to "#{contra.id} ", admin_contract_packages_path(contra)
end
column("numero") do |contra|

   link_to "#{contra.numero} ", admin_contract_elements_path(contra)
end

column("Fecha ", :sortable => :fecha) do |contra|
  if contra.fecha then
    contra.fecha.strftime("%d-%m-%Y")
  else
    "s/d"
  end
end
 column("descripcion")

column("proceso") do |contra|
     if contra.proceso and contra.proceso>0 then

        Phase.where(id:contra.proceso).
         select('nomenclatura as dd').first.dd

       else
           "s/d"
       end
   end

 column("obac") do |contra|
         if contra.obac and contra.obac>0 then
        Formula.where(product_id:1, orden:contra.obac).
         select('nombre as dd').first.dd
       else
         "s/d"
       end
   end

column("postor")

column("moneda") do |contra|
  if contra.moneda then
    Formula.where(product_id:7,orden:contra.moneda).select('nombre as dd').first.dd.to_s

  end
end
column("adjudicado") do |contra|
 number_with_delimiter(contra.adjudicado, delimiter: ",")
end
column("presupuestado") do |contra|
 number_with_delimiter(contra.presupuestado, delimiter: ",")
end

  actions
end

form :title => 'Edicion Contrato' do |f|

    f.inputs  do
 f.input :numero , :input_html => { :style =>  'width:30%'}
 f.input :fecha, :label => 'fecha ' ,:as =>:string, :input_html => { :style =>  'width:30%'}
 f.input :descripcion ,:label => 'Descripcion del contrato'

  f.input :proceso, :as => :select, :collection =>
    Phase.order('nomenclatura').map{|u| [u.nomenclatura, u.id]}




  f.input :obac, :as => :select, :collection =>
    Formula.where(product_id:1).map{|u| [u.nombre, u.orden]}

 f.input :postor , :input_html => { :style =>  'width:30%'}

 f.input :moneda, :as => :select, :collection =>
          Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

 f.input :adjudicado, :as => :string, :input_html => { :style =>  'width:30%'}
 f.input :presupuestado, :as => :string, :input_html => { :style =>  'width:30%'}

 f.input :periodo, :as => :select, :collection =>
    Formula.where(product_id:11).order('orden').map{|u| [u.nombre, u.orden]}



f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
  f.actions




    end #de inputs
end #de form



show :title => ' Contrato'  do

    attributes_table  do

      row :numero

      row "Fecha " do |contra|
        if contra.fecha then
           contra.fecha.strftime("%d-%m-%Y")
        else
           "s/d"
         end
       end

      row :descripcion

      row :proceso do |contra|
          if contra.proceso and contra.proceso>0 then

             Phase.where(id:contra.proceso).
              select('nomenclatura as dd').first.dd

            else
                "s/d"
            end
        end

      row :obac do |contra|
          if contra.obac and contra.obac>0 then

             Formula.where(product_id:1, orden:contra.obac).
              select('descripcion as dd').first.dd

            else
                "s/d"
            end
        end

    row :postor


      row :moneda do |contra|
          if contra.moneda and contra.moneda>0 then

             Formula.where(product_id:7, orden:contra.moneda).
              select('nombre as dd').first.dd

            else
                "s/d"
            end
        end


        row :adjudicado do |contra|

           number_with_delimiter(contra.adjudicado, delimiter: ",")

          end


          row :presupuestado do |contra|

             number_with_delimiter(contra.presupuestado, delimiter: ",")

            end
            row :periodo do |phase|
               if  phase.periodo and  phase.periodo>0 then
                  Formula.where(product_id:11, orden: phase.periodo).
                   select('nombre as dd').first.dd
               else
                     "s/d"
               end

            end

  end #de attributes_table

end # de show



















end
