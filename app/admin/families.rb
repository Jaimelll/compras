ActiveAdmin.register Family do


menu false

permit_params :employee_id, :tipo_rela, :ape_nom,
     :fec_nac, :admin_user_id


filter :ape_nom

index :title => 'Lista de Carga Familiar' do



        column("Apellido Nombre", :sortable => :ape_nom) do |fam|
         fam.ape_nom.upcase
         end


        column("Tipo de Relacion", :sortable => :tipo_rela) do |fam|

         if fam.tipo_rela and fam.tipo_rela>0 then

            Formula.where(product_id:25, orden:fam.tipo_rela).
             select('nombre as dd').first.dd


           end



         end


        column("fec_nac")



         actions
     end


     form :title => 'Edicion Carga Familiar'  do |f|


         f.inputs  do


           f.input :ape_nom,:label => 'Apellidos Nombre', :input_html => { :style =>  'width:30%'}

           f.input :tipo_rela, :as => :select, :collection =>
              Formula.where(product_id:25).order('nombre').map{|u| [u.nombre, u.orden]}
           f.input :fec_nac, :label => 'fecha de Nacimiento' ,:as =>:string, :input_html => { :style =>  'width:30%'}
           f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


           f.actions

         end

       end


       show :title => ' Carga Familiar'  do

               attributes_table  do




                row :ape_nom


                row :tipo_rela do |carga|
                          if carga.tipo_rela and carga.tipo_rela>0 then

                             Formula.where(product_id:25, orden:carga.tipo_rela).
                              select('nombre as dd').first.dd


                            end
                    end
               row :fec_nac




               end
             end


             sidebar "Foto" do

                   if params[:employee_id] then
                  Employee.where(id:params[:employee_id]).each do |item|
                    @nomb=item.ape_nom.upcase
                    unless item.foto.blank?
                     li   image_tag item.foto.thumb.url, size: "250"
                    end


                 end
               end
              if params[:employee_id] then

               li link_to "Nombre: "+"#{@nomb}", admin_employee_path(params[:employee_id])

              end

               end # de sider











end
