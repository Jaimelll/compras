ActiveAdmin.register Movement do
  menu  false


  permit_params :fechap, :estado, :creada,
       :observ, :sheet_id,
       :codigo, :descripcion,:sele1, :sele2,
       :admin_user_id


       action_item :actualiza,only: :show do
             link_to 'Actualiza Ficha', ficha_admin_sheet_movement_path(params[:sheet_id],params[:id]), method: :put
       end

       member_action :ficha, method: :put do

         per=Sheet.where(id:params[:sheet_id]).count
         vc1=Movement.where(estado:1,id:params[:id]).count
         vc2=Movement.where(estado:2,id:params[:id]).count
           if vc1+vc2>0 and per>0 then
              Formula.where( product_id:22 ,orden:1).update_all( cantidad:1 )
              redirect_to admin_sheet_movement_path(params[:sheet_id],params[:id])
          end
       end




       filter :estado, label:'Actividad', :as => :select, :collection =>
                Formula.where(product_id:38).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}




  index :title => 'Lista de Detalles' do

         column("Fecha", :sortable => :fechap) do |deta|
            if deta.fechap then
               deta.fechap.strftime("%d-%m-%Y")
            end
          end
          column("Actividad") do |deta|
            if deta.estado and deta.estado>0 then

               Formula.where(product_id:38, orden:deta.estado).
                select('nombre as dd').first.dd

              else
                  "s/d"
              end
          end





         column("observ")
         column("descripcion")
         column("codigo")
         column("Resolucion") do |deta|
           deta.sele1
         end


           actions
       end

       form :title => 'Edicion Detalle'  do |f|


               f.inputs  do


                f.input :fechap, :label => 'fecha' , as: :datepicker, :input_html => { :style =>  'width:30%'}


                 f.input :estado, :label => 'Actividad', :as => :select, :collection =>
                    Formula.where(product_id:38).order('orden ASC').map{|u| [u.nombre, u.orden]}
                 f.input :observ
                 f.input :codigo
                 f.input :descripcion
                 f.input :sele1, :label => 'Resolucion', :input_html => { :style =>  'width:30%'}
                 f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden

                        f.actions

                 end

       end
       show :title => ' Detalle'  do

             attributes_table  do




             row "Fecha" do |deta|
                deta.fechap
             end

             row "Actividad" do |deta|
               if deta.estado and deta.estado>0 then

                  Formula.where(product_id:38, orden:deta.estado).
                   select('nombre as dd').first.dd

                 else
                     "s/d"
                 end
             end



               row :observ
               row :codigo
               row :descripcion
               row "Resolucion" do |deta|
                 deta.sele1
               end


             end
           end



           sidebar "Datos de la Ficha" do
             if params[:sheet_id] then
               Sheet.where(id:params[:sheet_id]).each do |ficc|
            vestado= Formula.where(product_id:36, orden:ficc.vigencia).
                       select('nombre as dd').first.dd


                 ul do

                    li "Creacion:         "+ficc.creada.to_s
                    li "Revisada:         "+ficc.revisada.to_s
                    li "Codigo revision:  "+ficc.codigo_revision
                    li "Descripcion:      "+ficc.descripcion
                    li "Resolucion:      "+ficc.numero
                    li "Estado:          "+vestado
                 end
               end

             if Formula.where( product_id:22 ,orden:1).select("cantidad as dd").first.dd==1 then
               Movement.where(id:params[:id]).each do |activ|
                Sheet.where(id:params[:sheet_id]).update_all( revisada:activ.fechap,
                    codigo_revision:activ.codigo,
                    descripcion:activ.descripcion,
                    numero:activ.sele1)
                    #actualiza activo en estado
                     vc1=Movement.where(estado:1,id:params[:id]).count
                     if vc1>0 then
                       Sheet.where(id:params[:sheet_id]).update_all( creada:activ.fechap,
                          codigo_ficha:activ.codigo,
                          descripcion_original:activ.descripcion)
                     end
                    Formula.where( product_id:22 ,orden:1).update_all( cantidad:0 )
                end
              end


           end# de if
           end # de sider







  end
