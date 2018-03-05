ActiveAdmin.register Movement do
  menu  false


  permit_params :fechap, :estado, :creada,
       :observ, :sheet_id,
       :codigo, :descripcion,:sele1, :sele2,
       :admin_user_id


       action_item :actualiza,only: :show do
             link_to 'Actualiza Ficha'
             #, ficha_admin_sheet_movement(params[:sheet_id]), method: :put
       end

       member_action :ficha, method: :put do
              Formula.where( product_id:22 ,orden:1).update_all( cantidad:1 )
              redirect_to admin_sheet_movements_path(params[:sheet_id])
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



           actions
       end

       form :title => 'Edicion Detalle'  do |f|


               f.inputs  do


                f.input :fechap, :label => 'fecha' ,:as =>:string, :input_html => { :style =>  'width:30%'}


                 f.input :estado, :label => 'Actividad', :as => :select, :collection =>
                    Formula.where(product_id:38).map{|u| [u.nombre, u.orden]}
                 f.input :observ
                 f.input :codigo
                 f.input :descripcion
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




             end
           end



           sidebar "Datos de la Ficha" do
             if params[:sheet_id] then
                n1=Sheet.where(id:  params[:sheet_id]).
                         select('creada as dd').first.dd.to_s
                n2=Sheet.where(id:  params[:sheet_id]).
                         select('revisada as dd').first.dd.to_s
                n3=Sheet.where(id:  params[:sheet_id]).
                         select('codigo_revision as dd').first.dd
                n4= Sheet.where(id:  params[:sheet_id]).
                         select('descripcion as dd').first.dd

             ul do
               li "Creacion:         "+n1
               li "Revisada:         "+n2
               li "Codigo revision:  "+n3
               li "Descripcion:      "+n4
             end


           end# de if
           end # de sider







  end
