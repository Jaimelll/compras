ActiveAdmin.register Item do
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


permit_params :pac, :periodo,:obac, :lista,:ejecucion,
              :modalidad, :dependencia, :tipo, :descripcion, :cantidad,
              :certificado, :constancia, :moneda, :fuente, :seleccion,
              :mesconvoca, :rubro, :admin_user_id, :cuadrante, :expediente

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
menu priority: 4, label: "PACs"

 #action_item :encargo, only: :index do
#  link_to 'Encargo',encargo_admin_post_path
#  end



action_item :view, only: :show do
          link_to 'Ir a PACs', admin_items_path()
    end

#member_action :encargo do
#  Formula.where( product_id:15 ).update_all( cantidad:0 )
#  Formula.where( product_id:15 ,orden:1).update_all( cantidad:1 )
#end



scope :todos, :default => true do |items|
  items.order('pac')
end
scope :Ejercito, :default => true do |items|
  items.where(obac:1).order('pac')
end
scope :Marina, :default => true do |items|
  items.where(obac:2).order('pac')
end
scope :FAP, :default => true do |items|
  items.where(obac:3).order('pac')
end

scope :Otros, :default => true do |items|
  items.where("obac > 3").order('pac')
end

scope :ACFFAA, :default => true do |items|
  items.where("ejecucion=4").order('pac')
end


filter :pac, label:'PAC'
filter :certificado


filter :periodo , :as => :select, :collection =>
     Formula.where(product_id:11).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :modalidad , :as => :select, :collection =>
    Formula.where(product_id:4).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :tipo, label:'Mercado', :as => :select, :collection =>
     Formula.where(product_id:6).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}



index do

  column("NoPac", :sortable => :pac) {|item|
    link_to "#{item.pac} ", admin_item_path(item) }
  column("periodo")do |item|
      if item.periodo and item.periodo>0 then

         Formula.where(product_id:11, orden:item.periodo).
          select('nombre as dd').first.dd

        else
            "s/d"
        end
    end


  column("obac") do |item|
          if item.obac and item.obac>0 then
         Formula.where(product_id:1, orden:item.obac).
          select('nombre as dd').first.dd
        else
          "s/d"
        end
    end


  column("lista") do |item|
      if item.lista and item.lista>0 then

         Formula.where(product_id:3, orden:item.lista).
          select('nombre as dd').first.dd

        else
            "s/d"
        end
    end

  column("ejecucion") do |item|
      if item.ejecucion and item.ejecucion>0 then
         Formula.where(product_id:1, orden:item.ejecucion).
          select('nombre as dd').first.dd
        else
              "s/d"
        end
    end

    column("cuadrante") do |item|
        if item.cuadrante and item.cuadrante>0 then
           Formula.where(product_id:13, orden:item.cuadrante).
            select('nombre as dd').first.dd
          else
              "s/d"
          end
      end
      column("fuente") do |item|
          if item.fuente and item.fuente>0 then
             Formula.where(product_id:8, orden:item.fuente).
              select('nombre as dd').first.dd
            else
                "s/d"
            end
        end

    column("certificado") do |item|
     number_with_delimiter(item.certificado, delimiter: ",")
   end
    actions


end



form do |f|

    f.inputs "Items" do


       f.input :pac ,:label => 'PAC SEACE', :input_html => { :style =>  'width:30%'}
       f.input :expediente, :as => :select, :collection =>
         Formula.where(product_id:16).map{|u| [u.descripcion, u.orden]}
       f.input :periodo, :as => :select, :collection =>
               Formula.where(product_id:11).map{|u| [u.nombre, u.orden]}
       f.input :obac, :as => :select, :collection =>
           Formula.where(product_id:1,cantidad:1).map{|u| [u.nombre, u.orden]}
        f.input :lista, :as => :select, :collection =>
           Formula.where(product_id:3).map{|u| [u.descripcion, u.orden]}
        f.input :ejecucion,:label => 'Ejecucion Responsable', :as => :select, :collection =>
            Formula.where(product_id:1).map{|u| [u.nombre, u.orden]}
        f.input :modalidad, :as => :select, :collection =>
           Formula.where(product_id:4).map{|u| [u.nombre, u.orden]}
        f.input :dependencia,:label => 'Dependencia ejecutante', :as => :select, :collection =>
            Formula.where(product_id:5).map{|u| [u.nombre, u.orden]}
        f.input :tipo, :label => 'Mercado', :as => :select, :collection =>
           Formula.where(product_id:6).map{|u| [u.nombre, u.orden]}
         f.input :descripcion ,:label => 'Descripcion del bien o servicio'
         f.input :cantidad, :input_html => { :style =>  'width:30%'}
         f.input :cuadrante, :as => :select, :collection =>
            Formula.where(product_id:13).map{|u| [u.nombre, u.orden]}
         f.input :mesconvoca, :label => 'Fecha de Convocatoria SEACE' ,:as =>:string, :input_html => { :style =>  'width:30%'}
         f.input :seleccion,:label => 'Tipo de seleccion', :as => :select, :collection =>
             Formula.where(product_id:14).map{|u| [u.nombre, u.orden]}
         f.input :certificado,:label => 'Valor estimado PAC', :as => :string, :input_html => { :style =>  'width:30%'}
        #f.input :moneda, :as => :select, :collection =>
        #    Formula.where(product_id:7).map{|u| [u.nombre, u.orden]}
        f.input :fuente,:label => 'Fuente de financiamiento', :as => :select, :collection =>
             Formula.where(product_id:8).map{|u| [u.descripcion, u.orden]}
        #f.input :ccp , :label => 'No certificado presupuestal', :input_html => { :style =>  'width:30%'}
        #f.input :cpr , :label => 'No constacia de prevision de recurso', :input_html => { :style =>  'width:30%'}
        f.input :rubro, :as => :select, :collection =>
            Formula.where(product_id:9).map{|u| [u.nombre, u.orden]}
         f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
        f.actions
    end
  end


  show do
    nn=Item.where(id:params[:id]).
               select('pac as dd').first.dd.capitalize

         panel "pac-#{nn}" do

      table_for(item.details.order('pfecha')) do |t|

        t.column("Actividad", :sortable => :item_id) {|detail|
          if detail.actividad then
            n2=Formula.where(product_id:12,orden:detail.actividad).
                    select('cantidad as dd').first.dd

             n1=Formula.where(product_id:12,orden:detail.actividad).
                     select('descripcion as dd').first.dd.capitalize+
                      "-----"+
                       "#{Formula.where(product_id:10,orden:n2).
                                select('nombre as dd').first.dd}"



         else
                  n1="s/d"
         end
                 link_to "#{n1} ",  admin_item_detail_path(item,detail) }
        t.column("tipo")
        t.column("numero")
        t.column("pfecha")
        t.column("importe") do |detail|
         number_with_delimiter(detail.importe, delimiter: ",")
       end
        t.column("moneda") do |detail|
          if detail.moneda then
            Formula.where(product_id:7,orden:detail.moneda).select('nombre as dd').first.dd.to_s

          end
        end
        t.column("obs")


      end

    end

    strong { link_to 'Agregar actividad', new_admin_item_detail_path(item) }


end

sidebar "MONTOS" do
  ul do
      li Formula.where(product_id:1).where(orden:1).
                    select('nombre as dd').first.dd + " = " +

(number_with_delimiter(( Item.where(obac:1).sum('certificado')) , delimiter: ",", separator: ".")).to_s

      li Formula.where(product_id:1).where(orden:2).
                      select('nombre as dd').first.dd + " = " +
(number_with_delimiter(( Item.where(obac:2).sum('certificado')) , delimiter: ",", separator: ".")).to_s
      li Formula.where(product_id:1).where(orden:3).
                        select('nombre as dd').first.dd + "  = " +
(number_with_delimiter(( Item.where(obac:3).sum('certificado')) , delimiter: ",", separator: ".")).to_s
    li  "TOTAL = " +
(number_with_delimiter(( Item.sum('certificado')) , delimiter: ",", separator: ".")).to_s

li Formula.where(product_id:1).where(orden:4).
                  select('nombre as dd').first.dd + "  = " +
(number_with_delimiter(( Item.where(ejecucion:4).sum('certificado')) , delimiter: ",", separator: ".")).to_s



    end
  end




end
