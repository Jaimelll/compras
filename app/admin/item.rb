ActiveAdmin.register Item do


  ActiveAdmin.register Detail do
  belongs_to :item
end

ActiveAdmin.register Article do
belongs_to :item
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




permit_params :pac, :periodo,:obac, :lista,:ejecucion,
              :modalidad, :dependencia, :tipo, :descripcion, :cantidad,
              :certificado, :constancia, :moneda, :fuente, :seleccion,
              :mesconvoca, :rubro, :admin_user_id, :cuadrante, :expediente,
              :observacion, :exped, :exped2, :solicita, :ccp, :cpr, :sele3
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
menu priority: 8, label: "Buscador PAC"

 #action_item :encargo, only: :index do
#  link_to 'Encargo',encargo_admin_post_path
#  end



action_item :view, only: :show do
          link_to 'Ir a PACs', admin_items_path()
    end









    scope :ACFFAA, :default => true do |items|

    #  $vaf=current_admin_user.periodo
         items.where(ejecucion:4,exped2:current_admin_user.periodo).where('modalidad<3').order('pac')
   end

   scope :"S/EXP", :default => true do |items|
      items.where(ejecucion:4,exped2:current_admin_user.periodo,cuadrante:1).where('modalidad<3').order('pac')
   end

   scope :"C/EXP", :default => true do |items|
      items.where(ejecucion:4,exped2:current_admin_user.periodo,cuadrante:2).where('modalidad<3').order('pac')
   end
   scope :DC, :default => true do |items|
      items.where(ejecucion:4,exped2:current_admin_user.periodo,cuadrante:3).where('modalidad<3').order('pac')
   end
   scope :DEM, :default => true do |items|
      items.where(ejecucion:4,exped2:current_admin_user.periodo,cuadrante:4).where('modalidad<3').order('pac')
   end
   scope :DPC, :default => true do |items|
      items.where(ejecucion:4,exped2:current_admin_user.periodo,cuadrante:5).where('modalidad<3').order('pac')
   end
   scope :FC, :default => true do |items|
      items.where(ejecucion:4,exped2:current_admin_user.periodo,cuadrante:6).where('modalidad<3').order('pac')
   end
   scope :EC, :default => true do |items|
      items.where(ejecucion:4,exped2:current_admin_user.periodo,cuadrante:7).where('modalidad<3').order('pac')
   end
   scope :Autorizados, :default => true do |items|
      items.where(ejecucion:4,exped2:current_admin_user.periodo,modalidad:3).order('pac')
   end

     scope :todos, :default => true do |items|

           items.where(exped2:current_admin_user.periodo).order('pac')
      end











filter :pac, label:'PAC'
filter :descripcion
filter :certificado


filter :exped, label:'Expediente', :as => :select, :collection =>
     Formula.where(product_id:16).order('nombre ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :ejecucion , :as => :select, :collection =>
     Formula.where(product_id:1).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :modalidad , :as => :select, :collection =>
    Formula.where(product_id:4).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :tipo, label:'Mercado', :as => :select, :collection =>
     Formula.where(product_id:6).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :lista,  :as => :select, :collection =>
          Formula.where(product_id:3).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :obac,  :as => :select, :collection =>
      Formula.where(product_id:1,cantidad:1).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
filter :fuente,  :as => :select, :collection =>
      Formula.where(product_id:8).order('orden ASC').map{|u| ["#{u.descripcion}", u.orden]}




index :title => proc {"BUSCADOR PAC "+ Formula.where(product_id:11,orden:current_admin_user.periodo).select('descripcion as dd').first.dd }   do
$vaf=current_admin_user.periodo


  column("NoPac", :sortable => :pac) {|item|
    vsec=1
if current_admin_user.categoria==6 or current_admin_user.categoria==8 or current_admin_user.categoria==9 then
  vsec=0
end
if current_admin_user.categoria==6 and item.obac==2 then
  vsec=1
end

if current_admin_user.categoria==8 and item.obac==3 then
  vsec=1
end

if current_admin_user.categoria==9 and (item.obac==1 or item.obac==6) then
  vsec=1
end


   link_to_if vsec==1, "#{item.pac} ", admin_item_details_path(item)}
#  column("expediente")


column("Exped", sortable: :exped)do |item|
    if item.exped and item.exped>0 then

      exp =Formula.where(product_id:16, orden:item.exped).
        select('nombre as dd').first.dd

      else
        exp =   "s/d"
      end


  vsec=1
if current_admin_user.categoria==6 or current_admin_user.categoria==8 or current_admin_user.categoria==9 then
vsec=0
end
if current_admin_user.categoria==6 and item.obac==2 then
vsec=1
end

if current_admin_user.categoria==8 and item.obac==3 then
vsec=1
end

if current_admin_user.categoria==9 and (item.obac==1 or item.obac==6) then
vsec=1
end
 link_to_if vsec==1, "#{exp } ", admin_item_path(item)
  end


   column("Descripción", sortable: :descripcion) do |item|

   #loca1='//W:/SG ACFFAA/Oenlace/Proyectos/'
   #loca1='\\acffaa-archivo\acffaa$\SG ACFFAA\Oenlace\Proyectos\ '
#  localiz='W:\SG ACFFAA\Oenlace\Proyectos\PACFAP038COLCHONES.mpp'
# vlink='PACFAP038COLCHONES'
# localiz=loca1+vlink+'.mpp'
#link_to item.descripcion,localiz, :target=>"_blank"
#  item.descripcion
#link_to item.descripcion, root_path << localiz, :target=>"_blank"

#  localiz='file:///W:/SG%20ACFFAA/Oenlace/Proyectos/H5.mpp'
#localiz='W:/SG%20ACFFAA/Oenlace/Proyectos/H5.mpp'
#localiz='file:///W:/SG%20ACFFAA/Oenlace/Proyectos/H5.mpp'
#link_to item.descripcion, localiz, download: 'Bibliotecas\Documentos\H5 '

#localiz='http://seguimiento.acffaa.gob.pe:81/proyectos/01%20ADQ.%20VEHICULOS%20DE%20SEGURIDAD%202017.mpp'
#localiz='http://seguimiento.acffaa.gob.pe:81/proyectos/01%20ADQ.%20VEHICULOS%20DE%20SEGURIDAD%202017.mpp'
#link_to item.descripcion, localiz

 item.descripcion.upcase
end

  column("Modalidad", sortable: :modalidad)do |item|
        if item.modalidad and item.modalidad>0 then

        mmod= Formula.where(product_id:4, orden:item.modalidad).
          select('nombre as dd').first.dd

        else
         mmod= "s/d"
        end
        if Article.where(item_id:item.id).count>0 then
           link_to mmod, admin_item_articles_path(item)
        else
          mmod
        end

    end


  column("OBAC", sortable: :obac) do |item|
          if item.obac and item.obac>0 then
         Formula.where(product_id:1, orden:item.obac).
          select('nombre as dd').first.dd
        else
          "s/d"
        end
    end
#  column("dependencia") do |item|
#            if item.dependencia and item.dependencia>0 then
#           Formula.where(product_id:5, orden:item.dependencia).
#            select('nombre as dd').first.dd
#          else
#            "s/d"
#          end
#  end


  column("Fuente de Finan", sortable: :fuente) do |item|
      if item.fuente and item.fuente>0 then

         Formula.where(product_id:8, orden:item.fuente).
          select('nombre as dd').first.dd

        else
            "s/d"
        end
    end
    column("Mercado", sortable: :tipo) do |item|
        if item.tipo and item.tipo>0 then

           Formula.where(product_id:6, orden:item.tipo).
            select('nombre as dd').first.dd

          else
              "s/d"
          end
      end


   column("Estimado(soles)", :class => 'text-right', sortable: :certificado) do |item|
     number_with_delimiter(item.certificado, delimiter: ",")
   end

#unless current_admin_user.categoria==6 or current_admin_user.categoria==8 or current_admin_user.categoria==9 then

#  actions
#end

end



form :title => 'Edicion PACs' do |f|

    f.inputs  do


       f.input :pac ,:label => 'PAC SEACE', :input_html => { :style =>  'width:30%'}
       f.input :exped,:label => 'Expediente', :as => :select, :collection =>
         Formula.where(product_id:16).order('nombre').map{|u| [u.nombre+"-"+u.descripcion, u.orden]}

       f.input :periodo, :as => :select, :collection =>
               Formula.where(product_id:11,acti:1).order('orden').map{|u| [u.nombre, u.orden]}

       f.input :obac, :as => :select, :collection =>
       case current_admin_user.categoria # a_variable is the variable we want to compare
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
        case current_admin_user.categoria # a_variable is the variable we want to compare
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

               case current_admin_user.categoria # a_variable is the variable we want to compare
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
      #   f.input :cuadrante, :as => :select, :collection =>
      #      Formula.where(product_id:13).map{|u| [u.nombre, u.orden]}
         f.input :mesconvoca, :label => 'Fecha de Convocatoria SEACE' , as: :datepicker, :input_html => { :style =>  'width:30%'}

         f.input :seleccion,:label => 'Tipo de seleccion', :as => :select, :collection =>
             Formula.where(product_id:14).map{|u| [u.nombre, u.orden]}
         f.input :certificado,:label => 'Valor estimado PAC', :as => :string, :input_html => { :style =>  'width:30%'}

         f.input :ccp,:label => 'Certificado presupuestal', :as => :string, :input_html => { :style =>  'width:30%'}
         f.input :cpr,:label => 'Constancia de prevision', :as => :string, :input_html => { :style =>  'width:30%'}



        f.input :fuente,:label => 'Fuente de financiamiento', :as => :select, :collection =>
             Formula.where(product_id:8).map{|u| [u.descripcion, u.orden]}
        #f.input :ccp , :label => 'No certificado presupuestal', :input_html => { :style =>  'width:30%'}
        #f.input :cpr , :label => 'No constacia de prevision de recurso', :input_html => { :style =>  'width:30%'}
        f.input :rubro,:label => 'objeto', :as => :select, :collection =>
            Formula.where(product_id:9).map{|u| [u.nombre, u.orden]}
        f.input :exped2, :label => 'Año Fiscal', :as => :select, :collection =>
                    Formula.where(product_id:11,acti:1).order('orden').map{|u| [u.nombre, u.orden]}
         f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden
          f.input :observacion
          case current_admin_user.categoria # a_variable is the variable we want to compare
          when 1,2,4,6,8,9 #solo gex
              f.actions

            end

    end
  end







  show :title => ' PAC'  do

      attributes_table  do
        row "PAC (link actividades)" do |item|

            vsec=1
        if current_admin_user.categoria==6 or current_admin_user.categoria==8 or current_admin_user.categoria==9 then
          vsec=0
        end
        if current_admin_user.categoria==6 and item.obac==2 then
          vsec=1
        end

        if current_admin_user.categoria==8 and item.obac==3 then
          vsec=1
        end

        if current_admin_user.categoria==9 and (item.obac==1 or item.obac==6) then
          vsec=1
        end


           link_to_if vsec==1, "#{item.pac} ", admin_item_details_path(item)
      end
      row "Expediente" do |item|
         item.exped
         if item.exped and item.exped>0 then

            Formula.where(product_id:16, orden:item.exped).
             select('nombre as dd').first.dd

           else
               "s/d"
           end
     end



        row :periodo do |item|
            if item.periodo and item.periodo>0 then

               Formula.where(product_id:11, orden:item.periodo).
                select('nombre as dd').first.dd

              else
                  "s/d"
              end
          end
          row :obac do |item|
              if item.obac and item.obac>0 then

                 Formula.where(product_id:1, orden:item.obac).
                  select('descripcion as dd').first.dd

                else
                    "s/d"
                end
            end
            row :lista do |item|
                if item.lista and item.lista>0 then

                   Formula.where(product_id:3, orden:item.lista).
                    select('descripcion as dd').first.dd

                  else
                      "s/d"
                  end
              end
              row "Responsable de ejecucion" do |item|
                  if item.ejecucion and item.ejecucion>0 then

                     Formula.where(product_id:1, orden:item.ejecucion).
                      select('nombre as dd').first.dd

                    else
                        "s/d"
                    end
                end
                row :modalidad do |item|
                    if item.modalidad and item.modalidad>0 then

                       Formula.where(product_id:4, orden:item.modalidad).
                        select('nombre as dd').first.dd

                      else
                          "s/d"
                      end
                  end
                  row "Responsable de ejecucion" do |item|
                      if item.dependencia and item.dependencia>0 then

                         Formula.where(product_id:5, orden:item.dependencia).
                          select('nombre as dd').first.dd

                        else
                            "s/d"
                        end
                    end

                    row "Mercado" do |item|
                        if item.tipo and item.tipo>0 then

                           Formula.where(product_id:6, orden:item.tipo).
                            select('nombre as dd').first.dd

                          else
                              "s/d"
                          end
                      end


        row :descripcion
        row "Cantidad de items" do |item|
           item.cantidad
         end

           row "Fecha de convocatoria SEACE" do |item|
              item.mesconvoca
            end


            row "Tipo de seleccion" do |item|
                if item.seleccion and item.seleccion>0 then

                   Formula.where(product_id:14, orden:item.seleccion).
                    select('nombre as dd').first.dd

                  else
                      "s/d"
                  end
              end

              row "Valor estimado PAC" do |item|

                 number_with_delimiter(item.certificado, delimiter: ",")

                end

                row "Certificado presupuestal" do |item|

                   number_with_delimiter(item.ccp, delimiter: ",")

                  end
                  row "Constancia de prevision" do |item|

                     number_with_delimiter(item.cpr, delimiter: ",")

                    end




                row "Fuente de financiamiento" do |item|
                    if item.fuente and item.fuente>0 then

                       Formula.where(product_id:8, orden:item.fuente).
                        select('descripcion as dd').first.dd

                      else
                          "s/d"
                      end
                  end
                  row "objeto" do |item|
                      if item.rubro and item.rubro>0 then

                         Formula.where(product_id:9, orden:item.rubro).
                          select('nombre as dd').first.dd

                        else
                            "s/d"
                        end
                    end
                    row "Año Fiscal" do |item|
                        if item.exped2 and item.exped2>0 then

                           Formula.where(product_id:11, orden:item.exped2).
                            select('nombre as dd').first.dd

                          else
                              "s/d"
                          end


                      end

                    row :observacion










      end
    end









sidebar  " RESPONSABILIDAD Obac ", only: :index do
  # prueba ini
    table_for Formula.where(product_id:1).where.not(orden:4).where.not(orden:5).order('numero')    do
   @vaf1=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
        @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
      @ite= Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)").where(exped2:@vaf)
         column("Institucion "+ @vaf1) do |formula|
           formula.nombre
         end
         column("pac") do |formula|
        #   Item.where(ejecucion:formula.orden).where(exped2:@vaf).count
          @ite.where(obac:formula.orden).count
         end
         column("monto") do |formula|

              number_with_delimiter(  @ite.where(obac:formula.orden)
              .sum(:certificado).to_i, delimiter: ",")
         end
      end
       table_for "A"  do


       @ite= Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)").where(exped2:@vaf)
       @vpac=  @ite.count
       @vmonto=  number_with_delimiter(  @ite
         .sum(:certificado).to_i, delimiter: ",").to_s

         column("Total PAC  =")
         column("#{@vpac} ")
         column("#{@vmonto} ")
       end#table
  # prueba ini
  end

  sidebar " RESPONSABILIDAD ACFFAA", only: :index do




        table_for Formula.where(product_id:1,cantidad:1).where.not(orden:5).order('numero')  do
          @vaf1=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
            @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
               @vpcu1=   Item.where(ejecucion:4).where("modalidad<3")
               .where(exped2:@vaf)


             column("Institucion "+ @vaf1 ) do |formula|
               formula.nombre
             end
             column("PAC ") do |formula|



               @vpcu1.where(obac:formula.orden).count
             end

             column("MONTO ") do |formula|




                  number_with_delimiter(@vpcu1.where(obac:formula.orden).sum(:certificado).to_i, delimiter: ",")
             end

        end#table_for
        table_for "A"  do

          @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
        @ite=  Item.where(ejecucion:4).where("modalidad<3")
        .where(exped2:@vaf)
        @vpac=  @ite.count
        @vmonto=  number_with_delimiter(  @ite
          .sum(:certificado).to_i, delimiter: ",").to_s

          column("Total PAC  =")
          column("#{@vpac} ")
          column("#{@vmonto} ")
        end#table















end #de sidebar
end#de item
