ActiveAdmin.register Agreement do
  menu false

  permit_params :employee_id, :num_cont, :fec_inicon,
       :fec_tercon, :puesto, :cod_hor, :remuneracion,
       :area, :tipo_contra, :fec_retiro, :motivo_retir,
       :obs, :admin_user_id,:contra, :sele


  filter :centro





  index :title => 'Lista de Contratos' do





          column("contra")
          column("fec_inicon")
          column("fec_tercon")
          column("puesto")
          column("cod_hor")
          column("area")  do |contra|
                      if contra.area and contra.area>0 then

                         Formula.where(product_id:26, orden:contra.area).
                                          select('descripcion as dd').first.dd


                        end
          end

           actions
       end

       form :title => 'Edicion Contrato'  do |f|


           f.inputs  do


             f.input :contra, :input_html => { :style =>  'width:30%'}

             f.input :fec_inicon,:label => 'Inicio de contrato',:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :fec_tercon,:label => 'Término de contrato',:as =>:string, :input_html => { :style =>  'width:30%'}

             f.input :puesto, :input_html => { :style =>  'width:30%'}
             f.input :cod_hor,:label => 'Horario', :input_html => { :style =>  'width:30%'}
            f.input :remuneracion,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :area, :as => :select, :collection =>
                Formula.where(product_id:26).order('nombre').map{|u| [u.descripcion, u.orden]}

            f.input :tipo_contra,:label => 'Tipo Contrato', :as => :select, :collection =>
                    Formula.where(product_id:23).order('nombre').map{|u| [u.nombre, u.orden]}
             f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


             f.actions

           end

         end

         show :title => ' Contrato'  do

                 attributes_table  do

                  row :contra
                  row :fec_inicon
                  row :fec_tercon
                  row :puesto
                  row :cod_hor
                  row :remuneracion do |contra|

                   number_with_delimiter(contra.remuneracion, delimiter: ",")

                 end
                  row :area
                  row :tipo_contra
                  row :fec_retiro
                  row :motivo_retir
                  row :area  do |contra|
                              if contra.area and contra.area>0 then

                                 Formula.where(product_id:26, orden:contra.area).
                                                  select('descripcion as dd').first.dd


                                end
                  end
                  row :obs







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
