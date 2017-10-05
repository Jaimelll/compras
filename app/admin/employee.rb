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
         :cargo, :grado,:area, :sele,
         :remuneracion, :sele2, :distrito

   action_item :actualiza,only: :show do
         link_to 'Actualiza Contrato', actualiza_admin_employee_path( params[:id]), method: :put
   end

   member_action :actualiza, method: :put do
      Formula.where( product_id:22 ,orden:1).update_all( cantidad:1 )
     redirect_to admin_employee_path(params[:id])
   end

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


  filter :ape_nom, label:'Apellido Nombre'
  filter :cargo, label:'Puesto'
  filter :grado, label:'Perfil'
  filter :area, :as => :select, :collection =>
       Formula.where(product_id:26).order('nombre ASC').map{|u| ["#{u.descripcion}", u.orden]}
  filter :sele, label:'Nivel'


  index :title => 'Lista de Empleados' do



          column("Apellido Nombre", :sortable => :ape_nom) do |emple|
            if  emple.ape_nom then
             emple.ape_nom.upcase
            end
           end

          column("Puesto") do |emple|
            emple.cargo
          end

          column("Perfil") do |emple|
            emple.grado
          end

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
         f.input :distrito, :input_html => { :style =>  'width:30%'}
         f.input :telefono, :input_html => { :style =>  'width:30%'}
         f.input :correo, :input_html => { :style =>  'width:30%'}
         f.input :correo_corp, :input_html => { :style =>  'width:30%'}
         f.input :cargo,:label => 'Puesto', :input_html => { :style =>  'width:30%'}
         f.input :grado,:label => 'Perfil', :input_html => { :style =>  'width:30%'}

         f.input :area, :as => :select, :collection =>
            Formula.where(product_id:26).order('nombre').map{|u| [u.descripcion, u.orden]}
        f.input :estado, :as => :select, :collection =>
               Formula.where(product_id:22).order('nombre').map{|u| [u.nombre, u.orden]}
         f.input :tip_tra,:label => 'Tipo Contrato', :as => :select, :collection =>
            Formula.where(product_id:23).order('nombre').map{|u| [u.nombre, u.orden]}
         f.input :fec_nacimiento, :label => 'Fecha de nacimiento' ,:as =>:string, :input_html => { :style =>  'width:30%'}
         f.input :esta_civil, :as => :select, :collection =>
            Formula.where(product_id:24).order('nombre').map{|u| [u.nombre, u.orden]}
         f.input :sele,:label => 'Nivel', :input_html => { :style =>  'width:30%'}
         f.input :remuneracion,:as =>:string, :input_html => { :style =>  'width:30%'}
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
              row :distrito
              row :telefono
              row :correo
              row :correo_corp


             row :afp do |emple|
                       if emple.afp and emple.afp>0 then

                          Formula.where(product_id:30, orden:emple.afp).
                           select('nombre as dd').first.dd


                         end
                 end
              row :estado do |emple|
                        if emple.estado and emple.estado>0 then

                           Formula.where(product_id:22, orden:emple.estado).
                            select('nombre as dd').first.dd


                          end
                  end
              row  'Tipo de contrato' do |emple|
                          if emple.tip_tra and emple.tip_tra>0 then
                           Formula.where(product_id:23, orden:emple.tip_tra).select('nombre as dd').first.dd
                          end
              end
              row 'Fecha de nacimiento' do |emple|
                emple.fec_nacimiento
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
             row :area do |emple|
                         if emple.area and emple.area>0 then

                            Formula.where(product_id:26, orden:emple.area).
                                             select('descripcion as dd').first.dd


                           end
             end
             row 'Nivel' do |emple|
               emple.sele
             end

             row :remuneracion do |emple|

              number_with_delimiter(emple.remuneracion, delimiter: ",")

            end
  row :foto


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
             panel  "Datos de Contratos " do

@conta=0
Agreement.where(employee_id:params[:id]).each do |contr|
if   contr.fec_inicon and contr.fec_tercon then
if contr.fec_inicon<=Time.now and  contr.fec_tercon>=Time.now  then
  ul do
     li "Inicio de contrato: "+contr.fec_inicon.to_s
     li "Fin de contrato: "+contr. fec_tercon.to_s
     li "Puesto:  "+contr.puesto
     li "Estado: ACTIVO"
     li "Ingreso: "+Agreement.where(employee_id:params[:id],
         tipo_contra:contr.tipo_contra).minimum('fec_inicon').to_s

         if contr.area and contr.area>0 then
    li "Area: "  +Formula.where(product_id:26,orden:contr.area).
                  select('descripcion as dd').first.dd
          else
    li "Area: "
         end
     li "remuneracion contrato:  "+number_with_delimiter(contr.remuneracion, delimiter: ",")
 end
 if Formula.where( product_id:22 ,orden:1).select("cantidad as dd").first.dd==1 then
    Employee.where(id:params[:id]).update_all( fec_inicon:Agreement.
        where(employee_id:params[:id],
        tipo_contra:contr.tipo_contra).minimum('fec_inicon') ,
        fec_tercon:contr.fec_tercon,estado:1,area:contr.area,
        remuneracion:contr.remuneracion)
        #actualiza activo en estado
        Formula.where( product_id:22 ,orden:1).update_all( cantidad:0 )

  end


    @conta=1
end #1er if
end #1er if
end  #each

if   @conta==0 then
 ul do

    li "Estado: INACTIVO"
 end
if Formula.where( product_id:22 ,orden:1).select("cantidad as dd").first.dd==1 then
 Employee.where(id:params[:employee_id]).update_all( fec_inicon:nil,
 fec_tercon:nil,estado:2)
 #actualiza activo en estado
 Formula.where( product_id:22 ,orden:1).update_all( cantidad:0 )

end


end

 if params[:id] and Employee.where(id:params[:id]).
 select('remuneracion as dd').first.dd then
ul do

 li "remuneracion activa:  "+number_with_delimiter(Employee.where(id:params[:id]).
 select('remuneracion as dd').first.dd, delimiter: ",")
 li link_to "Personal por area evaluacion",
  reports_vhoja4_path(format: "xlsx")
end

end
   end #end de sidebar



end

  end
