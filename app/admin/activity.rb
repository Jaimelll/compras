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
              :created_at,:updated_at,:plan,:inicial



              action_item :view, only:[:show,:new,:index]do
                if params[:phase_id] then
              nn=Phase.where(id:params[:phase_id]).
                       select('proceso as dd').first.dd
                    link_to "Ir a -#{nn}", admin_phase_path(params[:phase_id])
                end
               end

#scope :PAC, :default => true do |activities|
#   activities.where(phase_id:params[:phase_id])
#end

filter :pfecha

index :title => "Lista de Actividades Procesos"  do

column("Actividad", :sortable => :phase_id) do |activity|
  n4=Formula.where(product_id:12,orden:activity.actividad).
          select('orden as dd').first.dd


  n2=Formula.where(product_id:12,orden:activity.actividad).
          select('cantidad as dd').first.dd
  n1=Formula.where(product_id:12,orden:activity.actividad).
          select('descripcion as dd').first.dd.capitalize+
           "-----"+
            "#{Formula.where(product_id:10,orden:n2).
                     select('nombre as dd').first.dd}"

                     #para gex
                            if n4==25 or n4==15 or n4==17 or n4==26 or n4==85 or n4==104 then
                           n5=1
                         else
                           n5=0
                         end
                   #para dc
                         if n4==60  or n4==80 then
                           n6=1
                         else
                           n6=0
                         end

                     #para dem
                               if n4==34  or n4==81  or n4==82 then
                                 n7=1
                               else
                                 n7=0
                               end
                     #para dpc
                             if n4==35 or n4==76 or n4==38 or n4==83 or 90 or 91 or 99 then
                                 n8=1
                             else
                                 n8=0
                             end


                   # link_to "#{n1} ",  admin_item_detail_path(item,detail) }
                   case current_admin_user.categoria # a_variable is the variable we want to compare
                   when 1,2,4,5 #gex
                            n3=1
                        when 6,8,9 #gex
                          if n2==1 or n2==2 or n5==1 then
                                   n3=1
                         else
                            n3=2
                         end
                      when 11 #estudio de mercado
                           if n2==4 or n7==1
                             n3=1
                           else
                             n3=2
                           end
                       when 12,28 # catalogacion
                              if n2==3 or n6==1
                                n3=1
                              else
                                n3=2
                              end
                       when 13 #proceso de contrataciones
                                 if n2==5  or n8==1  then
                                   n3=1
                                 else
                                   n3=2
                                 end
                       when 14 #ejecucion de contratos
                                    if n2==5 or n2==6 or n2===7 then
                                      n3=1
                                    else
                                      n3=2
                                    end
                          when 21,22,23 #enlaces
                                               if n2==20  then
                                                 n3=1
                                               else
                                                 n3=2
                                               end

                       else
                            n3=2
                     end
                  link_to_if n3==1 ,"#{n1} ", admin_phase_activity_path(params[:phase_id],activity)
end
column("Fecha ", :sortable => :pfecha) do |activity|
  if activity.pfecha then
    activity.pfecha.strftime("%d-%m-%Y")
  else
    "s/d"
  end
end


column("Documento de recepcion") do |detail|
  detail.tipo
end

column("Numero de documento") do |detail|
  detail.numero
end

column("obs")


actions


end #de index

form :title => 'Edicion Actividad'  do |f|


      f.inputs  do


             f.input :actividad, :as => :select, :collection =>

             case current_admin_user.categoria # a_variable is the variable we want to compare
             when 1,2,4  #admi
                 Formula.where(product_id:12).order("numero,descripcion").
                   map{|u| [u.descripcion.capitalize,
                    u.orden]}
              when 6,8,9  #gex
                    Formula.where(product_id:12)
                      .where("cantidad=1 or cantidad=2 or orden=25 or orden=15
                       or orden=17 or orden=26 or orden=85 or orden=104")
                      .order("numero,descripcion").map{|u| [u.descripcion.capitalize,
                         u.orden]}


             when 7,11     #castaneda,dem
                 Formula.where(product_id:12).order("numero,descripcion").
                   where("cantidad=4 or orden=34 or orden=81  or orden=82")
                   .order("numero,descripcion").map{|u| [u.descripcion.capitalize,
                      u.orden]}
             when 12,28     #dc
                      Formula.where(product_id:12).order("numero,descripcion").
                       where("cantidad=3 or orden=60 or orden=80").
                        map{|u| [u.descripcion.capitalize,
                         u.orden]}
             when 13     #dpc
                           Formula.where(product_id:12).order("numero,descripcion").
                           where("cantidad=5 or orden=35 or orden=76 or orden=38 or orden=83 or orden=90 or orden=91 or orden=99").
                             map{|u| [u.descripcion.capitalize,
                              u.orden]}

             when 14    #dec
                       Formula.where(product_id:12).where("cantidad=5 or cantidad=6 or cantidad=7")
                         .order("numero,descripcion").
                            map{|u| [u.descripcion.capitalize,
                               u.orden]}
              when 21,22,23    #enlaces
                       Formula.where(product_id:12).where("cantidad=20")
                          .order("numero,descripcion").
                           map{|u| [u.descripcion.capitalize,
                          u.orden]}



              end



             f.input :tipo,:label => 'Documento de recepcion', :input_html => { :style =>  'width:30%'}
             f.input :numero,:label => 'Numero de documento', :input_html => { :style =>  'width:30%'}
             f.input :pfecha, :label => 'fecha' , as: :datepicker, :input_html => { :style =>  'width:30%'}
             f.input :importe,:label => 'Importe ',:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :moneda, :as => :select, :collection =>
                      Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

             f.input :obs, :input_html => { :style =>  'width:30%'}
             f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


                   end
            f.actions



        #    no tiene parametros y la ruta no pasa por item

      end #de form

      show :title => ' ACTIVIDAD ' do


                attributes_table do

                nn=Phase.where(id:params[:phase_id]).
                         select('nomenclatura as dd').first.dd.capitalize


                  row "Ir Lista Actividades Procesos" do |activity|
                    link_to "#{nn}", admin_phase_activities_path(activity.phase_id)
                  end

                  row :actividad do |activity|
                      if activity.actividad and activity.actividad>0 then

                         Formula.where(product_id:12, orden:activity.actividad).
                          select('descripcion as dd').first.dd

                        else
                            "s/d"
                        end
                    end
                    row "Documento de recepcion" do |detail|
                       detail.tipo
                    end
                    row "Numero de documento" do |detail|
                       detail.numero
                    end


                  row "fecha  " do |activity|

                     activity.pfecha.strftime("%d-%m-%Y")
                   end



                  row :importe do |activity|

                     number_with_delimiter(activity.importe, delimiter: ",")

                    end



                  row :moneda do |detail|
                      if detail.moneda and detail.moneda>0 then

                         Formula.where(product_id:7, orden:detail.moneda).
                          select('nombre as dd').first.dd

                        else
                            "s/d"
                        end
                    end

                  row :obs
                  row :admin_user_id

                end

            end







sidebar "Datos del Proceso" do
  if params[:phase_id] then
     nn=Phase.where(id:  params[:phase_id]).
              select('nomenclatura as dd').first.dd.downcase
      n1=Phase.where(id:  params[:phase_id]).
               select('moneda as dd').first.dd
     n11=Phase.where(id:  params[:phase_id]).
              select('expediente as dd').first.dd

      n2= Phase.where(id:params[:phase_id]).
               select('descripcion as dd').first.dd.capitalize
      n3=Formula.where(product:7,orden:n1).
            select('nombre as dd').first.dd.capitalize

      n31=Formula.where(product:16,orden:n11).
           select('nombre as dd').first.dd.capitalize
      n4=Phase.where(id:  params[:phase_id]).
                    select('valor as dd').first.dd.to_s
     n32=Formula.where(product:16,orden:n11).
               select('orden as dd').first.dd
       @vobac=" "
      if n32>0 then
       Item.where(exped:n32).order('obac').each do |nobac|
        @sobac=Formula.where(product_id:1,orden:nobac.obac)
        .select('nombre as dd').first.dd
         @vobac=@vobac+ @sobac+"-"+nobac.pac+","
         end
         end


  ul do
    li "PROCESO :   "+nn
    li "EXPEDIENTE :  "+n31
    li "OBAC-PAC :  "+ @vobac
    li "DESCRIPCION : "+n2
    li "MONEDA :  "+n3
    li "VALOR ESTIMADO :"+  number_with_delimiter(n4, delimiter: ",").to_s

  end# de ul













end# de if
end # de sider
end #de register
