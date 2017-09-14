ActiveAdmin.register Employee do

  ActiveAdmin.register Family do
  belongs_to :employee
  end

  ActiveAdmin.register Student do
  belongs_to :employee
  end

  ActiveAdmin.register Experience do
belongs_to :employee
end

ActiveAdmin.register Agreement do
belongs_to :employee
end


    menu  priority: 16, label: "Empleados"

    permit_params :dni, :ape_pat, :ape_mat,
         :nombres, :direccion, :telefono,
         :correo, :fec_nacimiento, :estado,
         :tip_tra, :esta_civil, :afp,
         :admin_user_id, :foto, :ape_nom,
         :correo_corp, :fec_inicon, :fec_tercon,
         :cargo, :grado,:area, :sele



         scope :Activos, :default => true do |emples|
                   emples.where(estado:1)
              end

        scope :CAS, :default => true do |emples|
                        emples.where(tip_tra:1)
             end
        scope :Orden_servicio, :default => true do |emples|
                       emples.where(tip_tra:2)
            end
        scope :Militares, :default => true do |emples|
                    emples.where(tip_tra:3)
               end


         scope :Inactivos, :default => true do |emples|
                        emples.where(estado:2)
                   end

         scope :Todos, :default => true do |emples|
                          emples.order('ape_nom')
               end


  filter :ape_nom
  filter :cargo
  filter :grado


  index :title => 'Lista de Empleados' do



          column("Apellido Nombre", :sortable => :ape_nom) do |emple|
           emple.ape_nom.upcase
           end

          column("Puesto")
          column("Perfil")
          column("Foto") do   |emple|
                  unless emple.foto.blank?
                   li   image_tag emple.foto.thumb.url, size: "100"
                  end
                end

           actions
       end


   form :title => 'Edicion Empleado'  do |f|


       f.inputs  do

         f.input :dni, :input_html => { :style =>  'width:30%'}
         f.input :ape_pat,:label => 'Apellido paterno', :input_html => { :style =>  'width:30%'}
         f.input :ape_mat,:label => 'Apellido materno', :input_html => { :style =>  'width:30%'}
         f.input :nombres, :input_html => { :style =>  'width:30%'}
         f.input :direccion, :input_html => { :style =>  'width:30%'}
         f.input :telefono, :input_html => { :style =>  'width:30%'}
         f.input :correo, :input_html => { :style =>  'width:30%'}
         f.input :correo_corp, :input_html => { :style =>  'width:30%'}
         f.input :cargo,:label => 'Puesto', :input_html => { :style =>  'width:30%'}
         f.input :grado,:label => 'Perfil', :input_html => { :style =>  'width:30%'}

         f.input :estado, :as => :select, :collection =>
            Formula.where(product_id:22).order('nombre').map{|u| [u.nombre, u.orden]}
         f.input :tip_tra,:label => 'Tipo Contrato', :as => :select, :collection =>
            Formula.where(product_id:23).order('nombre').map{|u| [u.nombre, u.orden]}
         f.input :esta_civil, :as => :select, :collection =>
            Formula.where(product_id:24).order('nombre').map{|u| [u.nombre, u.orden]}
        f.input :foto, :as => :file, :hint => f.object.foto.present? \
                ? image_tag(f.object.foto.url(:thumb))
                 : content_tag(:span, "no hay foto aun")


         f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden



         f.actions

       end

     end

     show :title => ' Empleado'  do

             attributes_table  do

              row :dni
              row :ape_pat
              row :ape_mat
              row :nombres do |emple|
               @nombre=emple.ape_pat+' '+emple.ape_mat+', '+emple.nombres
               Employee.where(id:emple.id).update_all( ape_nom: @nombre)
               emple.nombres
             end

              row 'Puesto' do |emple|
                emple.cargo
              end
              row 'Perfil' do |emple|
                emple.grado
              end

              row :direccion
              row :telefono
              row :correo
              row :correo_corp


              row :estado do |emple|
                        if emple.estado and emple.estado>0 then

                           Formula.where(product_id:22, orden:emple.estado).
                            select('nombre as dd').first.dd


                          end
                  end
              row  'Tipo de contrato' do |emple|
                          if emple.tip_tra and emple.tip_tra>0 then

                           Formula.where(product_id:23, orden:emple.tip_tra).
                                  select('nombre as dd').first.dd


                          end
              end

            row :esta_civil do |emple|
                        if emple.esta_civil and emple.esta_civil>0 then

                           Formula.where(product_id:24, orden:emple.esta_civil).
                                            select('nombre as dd').first.dd


                          end
            end
             row 'Fecha de ingreso' do |emple|
               emple.fec_inicon
             end

             row 'Término de contrato' do |emple|
               emple.fec_tercon
             end





             end
           end



           sidebar "Foto", except: :index  do

             if params[:id] then
            Employee.where(id:params[:id]).each do |item|
              @nomb=item.ape_nom.upcase
              unless item.foto.blank?
               li   image_tag item.foto.thumb.url, size: "250"
               li      strong "Nombre: "+"#{@nomb}"
              end


           end
         end
     ul do
        if params[:id] then
         li      link_to "CARGA FAMILIAR", admin_employee_families_path(params[:id])
         li      link_to "ESTUDIOS", admin_employee_students_path(params[:id])
         li      link_to "EXPERIENCIA LABORAL", admin_employee_experiences_path(params[:id])
         li      link_to "CONTRATOS", admin_employee_agreements_path(params[:id])
                  end
    end
         end # de sider





  end
