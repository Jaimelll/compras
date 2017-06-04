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
              :mesconvoca, :rubro, :admin_user_id, :cuadrante, :expediente,
              :observacion, :exped, :exped2
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










    scope :ACFFAA, :default => true do |items|
         items.where("ejecucion=4").order('pac')
   end

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





filter :pac, label:'PAC'
filter :descripcion
filter :certificado


filter :exped, label:'Expediente', :as => :select, :collection =>
     Formula.where(product_id:16).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :periodo , :as => :select, :collection =>
     Formula.where(product_id:11).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :modalidad , :as => :select, :collection =>
    Formula.where(product_id:4).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :tipo, label:'Mercado', :as => :select, :collection =>
     Formula.where(product_id:6).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :lista,  :as => :select, :collection =>
          Formula.where(product_id:3).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :obac,  :as => :select, :collection =>
      Formula.where(product_id:1,cantidad:1).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}



index do

  column("NoPac", :sortable => :pac) {|item|
    vsec=1
if current_admin_user.id==6 or current_admin_user.id==8 or current_admin_user.id==9 then
  vsec=0
end
if current_admin_user.id==6 and item.obac==2 then
  vsec=1
end

if current_admin_user.id==8 and item.obac==3 then
  vsec=1
end

if current_admin_user.id==9 and (item.obac==1 or item.obac==6) then
  vsec=1
end



   link_to_if vsec==1, "#{item.pac} ", admin_item_path(item) }
#  column("expediente")


column("exped")do |item|
    if item.exped and item.exped>0 then

       Formula.where(product_id:16, orden:item.exped).
        select('nombre as dd').first.dd

      else
          "s/d"
      end
  end

   column("descripcion")



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
  column("dependencia") do |item|
            if item.dependencia and item.dependencia>0 then
           Formula.where(product_id:5, orden:item.dependencia).
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

  #  column("cuadrante") do |item|
  #      if item.cuadrante and item.cuadrante>0 then
  #         Formula.where(product_id:13, orden:item.cuadrante).
  #          select('nombre as dd').first.dd
  #        else
  #            "s/d"
  #        end
  #    end
    #  column("fuente") do |item|
    #      if item.fuente and item.fuente>0 then
    #         Formula.where(product_id:8, orden:item.fuente).
    #          select('nombre as dd').first.dd
    #        else
    #            "s/d"
    #        end
    #    end

    column("certificado") do |item|
     number_with_delimiter(item.certificado, delimiter: ",")
   end

unless current_admin_user.id==6 or current_admin_user.id==8 or current_admin_user.id==9 then

  actions
end

end



form do |f|

    f.inputs "Items" do


       f.input :pac ,:label => 'PAC SEACE', :input_html => { :style =>  'width:30%'}
       f.input :exped,:label => 'Expediente', :as => :select, :collection =>
         Formula.where(product_id:16).order('nombre').map{|u| [u.nombre+"-"+u.descripcion, u.orden]}

       f.input :periodo, :as => :select, :collection =>
               Formula.where(product_id:11).map{|u| [u.nombre, u.orden]}
       f.input :obac, :as => :select, :collection =>
       case current_admin_user.id # a_variable is the variable we want to compare
         when 6   #mgp
            Formula.where(product_id:1,orden:2).map{|u| [u.nombre, u.orden]}
        when 8   #fap
           Formula.where(product_id:1,orden:3).map{|u| [u.nombre, u.orden]}
        when 9   #ep
            Formula.where(product_id:1).where("orden= 1 OR orden = 6 ").map{|u| [u.nombre, u.orden]}
         else
            Formula.where(product_id:1,cantidad:1).map{|u| [u.nombre, u.orden]}
         end


           Formula.where(product_id:1,cantidad:1).map{|u| [u.nombre, u.orden]}

        f.input :lista, :as => :select, :collection =>
           Formula.where(product_id:3).map{|u| [u.descripcion, u.orden]}
        f.input :ejecucion,:label => 'Ejecucion Responsable', :as => :select, :collection =>
        case current_admin_user.id # a_variable is the variable we want to compare
          when 6   #mgp
          Formula.where(product_id:1).where("orden= 2 OR orden = 4").map{|u| [u.nombre, u.orden]}
        when 8   #fap
          Formula.where(product_id:1).where("orden= 3 OR orden = 4").map{|u| [u.nombre, u.orden]}
        when 9   #ep
           Formula.where(product_id:1).where("orden= 1 OR orden = 6 OR orden = 4").map{|u| [u.nombre, u.orden]}


          else
          Formula.where(product_id:1).map{|u| [u.nombre, u.orden]}
          end


            Formula.where(product_id:1).map{|u| [u.nombre, u.orden]}
        f.input :modalidad, :as => :select, :collection =>
           Formula.where(product_id:4).map{|u| [u.nombre, u.orden]}
        f.input :dependencia,:label => 'Dependencia ejecutante OBAC', :as => :select, :collection =>

               case current_admin_user.id # a_variable is the variable we want to compare
                 when 6   #mgp
                  Formula.where(product_id:5,cantidad:2).map{|u| [u.nombre, u.orden]}
                when 8   #fap
                 Formula.where(product_id:5,cantidad:3).map{|u| [u.nombre, u.orden]}
               when 9   #ep
                Formula.where(product_id:5).where("cantidad=1 or cantidad=6").map{|u| [u.nombre, u.orden]}
                 else
                  Formula.where(product_id:5).map{|u| [u.nombre, u.orden]}
                 end


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
        f.input :exped2, :label => 'Año Fiscal', :as => :select, :collection =>
                    Formula.where(product_id:11).map{|u| [u.nombre, u.orden]}
         f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
          f.input :observacion
          case current_admin_user.id # a_variable is the variable we want to compare
          when 1,2,4,6,8,9 #solo gex
              f.actions

            end

    end
  end


  show do
    nn=Item.where(id:params[:id]).
               select('pac as dd').first.dd.capitalize+"-"+
        Item.where(id:params[:id]).
                select('descripcion as dd').first.dd.capitalize

         panel "pac-#{nn}" do

      table_for(item.details.order('pfecha,id')) do |t|

        t.column("Actividad", :sortable => :item_id) {|detail|

          if detail.actividad then
            n4=Formula.where(product_id:12,orden:detail.actividad).
                    select('orden as dd').first.dd
            n2=Formula.where(product_id:12,orden:detail.actividad).
                    select('cantidad as dd').first.dd

             n1=Formula.where(product_id:12,orden:detail.actividad).
                     select('descripcion as dd').first.dd.capitalize+
                      "-----"+
                       "#{Formula.where(product_id:10,orden:n2).
                                select('nombre as dd').first.dd}"
            if n4==25 or n4==15 or n4==17 or n4==26 then
              n5=1
            else
              n5=0
            end

         else
                  n1="s/d"
         end

          # link_to "#{n1} ",  admin_item_detail_path(item,detail) }
          case current_admin_user.id # a_variable is the variable we want to compare
              when 1,2,4 #gex
                   n3=1
               when 6,8,9 #gex
                 if n2==1 or n2==2 or n5==1 then
                          n3=1
                else
                   n3=2
                end
             when 11 #estudio de mercado
                  if n2==4
                    n3=1
                  else
                    n3=2
                  end
              when 12 # catalogacion
                     if n2==3
                       n3=1
                     else
                       n3=2
                     end
              when 13 #proceso de contrataciones
                        if n2==5
                          n3=1
                        else
                          n3=2
                        end
              when 14 #ejecucion de contratos
                           if n2==6 or n2===7 then
                             n3=1
                           else
                             n3=2
                           end

              else
                   n3=2
            end
     link_to_if n3==1,"#{n1} ",  admin_item_detail_path(item,detail) }






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

sidebar "RESPONSABLE POR EJECUCION", only: :index do
  # prueba ini
    table_for Formula.where(product_id:1)  do
         column("Institucion ") do |formula|
           formula.nombre
         end
         column("pac") do |formula|
           Item.where(ejecucion:formula.orden).count
         end
         column("monto") do |formula|

              number_with_delimiter(Item.where(ejecucion:formula.orden).
              sum(:certificado).to_i, delimiter: ",")
         end
      end

  # prueba ini
  end
  sidebar "EJECUCION ACFFAA", only: :index do
    # prueba ini



        table_for Formula.where(product_id:1,cantidad:1)  do
             column("Institucion 'PAC/(SOLES)'" ) do |formula|
               formula.nombre
             end
             column("EN ACFFAA ") do |formula|
             @vpcu1=   Item.where(ejecucion:4,obac:formula.orden).where("modalidad<3")
                 .where.not('id IN(?)',Detail.where(actividad:61).select("item_id"))
               @vpcu1.count.to_s+ "/("+
                  number_with_delimiter(@vpcu1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"
             end




            column("Ejecucion Contractual") do |formula|
                @vpcu2= Item.where(ejecucion:4,obac:formula.orden).where("modalidad<3")
                .where('id IN(?)',Detail.where(actividad:61).select("item_id"))
                 @vpcu2.count.to_s+ "/("+
                   number_with_delimiter(@vpcu2.sum(:certificado).to_i, delimiter: ",").to_s+ ")"
              end


















end

    # prueba ini
end
end
