ActiveAdmin.register Item do


  ActiveAdmin.register Detail do
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
menu priority: 8, label: "PAC buscar"

 #action_item :encargo, only: :index do
#  link_to 'Encargo',encargo_admin_post_path
#  end



action_item :view, only: :show do
          link_to 'Ir a PACs', admin_items_path()
    end









    scope :ACFFAA, :default => true do |items|
      @vaf=current_admin_user.periodo
         items.where(ejecucion:4,exped2:@vaf).order('pac')
   end

     scope :todos, :default => true do |items|

           items.order('pac')
      end
     scope :Ejercito, :default => true do |items|
        @vaf=current_admin_user.periodo
          items.where(obac:1).where(exped2:@vaf).order('pac')
     end
     scope :Marina, :default => true do |items|
      @vaf=current_admin_user.periodo
          items.where(obac:2).where(exped2:@vaf).order('pac')
     end
     scope :FAP, :default => true do |items|
      @vaf=current_admin_user.periodo
          items.where(obac:3).where(exped2:@vaf).order('pac')
     end

     scope :Otros, :default => true do |items|
    @vaf=current_admin_user.periodo
          items.where("obac > 3").where(exped2:@vaf).order('pac')
     end
     scope :AF_2018, :default => true do |items|

          items.where(ejecucion:4,exped2:4).order('pac')
     end
     scope :AF_2017, :default => true do |items|

          items.where(ejecucion:4,exped2:3).order('pac')
     end

     scope :AF_2016, :default => true do |items|

          items.where(ejecucion:4,exped2:2).order('pac')
     end

     scope :AF_2015, :default => true do |items|

          items.where(ejecucion:4,exped2:1).order('pac')
     end
     scope :ACFFAA_filtro, :default => true do |items|
         @vaf=current_admin_user.periodo
          items.where(ejecucion:4,exped2:@vaf).where('modalidad<3').order('pac')
    end









filter :pac, label:'PAC'
filter :descripcion
filter :certificado


filter :exped, label:'Expediente', :as => :select, :collection =>
     Formula.where(product_id:16).order('nombre ASC').map{|u| ["#{u.nombre}", u.orden]}
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
filter :fuente,  :as => :select, :collection =>
      Formula.where(product_id:8).order('orden ASC').map{|u| ["#{u.descripcion}", u.orden]}


index :title => 'Lista de PACs' do


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


column("exped")do |item|
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
   column("descripcion") do |item|

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
localiz='file:///W:/SG%20ACFFAA/Oenlace/Proyectos/H5.mpp'

link_to item.descripcion, localiz, download: 'Bibliotecas\Documentos\H5 '

  end

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
#  column("dependencia") do |item|
#            if item.dependencia and item.dependencia>0 then
#           Formula.where(product_id:5, orden:item.dependencia).
#            select('nombre as dd').first.dd
#          else
#            "s/d"
#          end
#  end


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

    column("estimado", :class => 'text-right') do |item|
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
               Formula.where(product_id:11).order('orden').map{|u| [u.nombre, u.orden]}

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
         f.input :cuadrante, :as => :select, :collection =>
            Formula.where(product_id:13).map{|u| [u.nombre, u.orden]}
         f.input :mesconvoca, :label => 'Fecha de Convocatoria SEACE' ,:as =>:string, :input_html => { :style =>  'width:30%'}
          f.input :solicita, :label => 'Fecha solicitada OBAC' ,:as =>:string, :input_html => { :style =>  'width:30%'}
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
                    Formula.where(product_id:11).order('orden').map{|u| [u.nombre, u.orden]}
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
         row :cuadrante do |item|
             if item.cuadrante and item.cuadrante>0 then

                Formula.where(product_id:13, orden:item.cuadrante).
                 select('nombre as dd').first.dd

               else
                   "s/d"
               end
           end

           row "Fecha de convocatoria SEACE" do |item|
              item.mesconvoca
            end
            row "Fecha solicitada OBAC" do |item|
               item.solicita
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
