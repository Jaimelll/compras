ActiveAdmin.register Movement do
  menu  false


  permit_params :fechap, :estado, :creada,
       :observ, :sheet_id, :admin_user_id


  index :title => 'Lista de Detalles' do

         column("Fecha", :sortable => :fechap) do |deta|
            if deta.fechap then
               deta.fechap.strftime("%d-%m-%Y")
            end
          end
          column("estado")

         column("Fecha Creacion", :sortable => :creada) do |deta|
           if  deta.creada then
               deta.creada.strftime("%d-%m-%Y")
           end
         end

         column("observ")



           actions
       end

       form :title => 'Edicion Detalle'  do |f|


               f.inputs  do


                f.input :fechap, :label => 'fecha' ,:as =>:string, :input_html => { :style =>  'width:30%'}

                 f.input :estado, :input_html => { :style =>  'width:30%'}
                   f.input :creada, :label => 'Fecha Creacion' ,:as =>:string, :input_html => { :style =>  'width:30%'}
                 f.input :observ
                 f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden

                        f.actions

                 end

       end
       show :title => ' Detalle'  do

             attributes_table  do




             row "Fecha" do |deta|
                deta.fechap
             end
             row :estado
             row "Fecha Creacion" do |deta|
                deta.creada
             end

               row :observ




             end
           end









  end
