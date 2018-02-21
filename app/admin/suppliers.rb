ActiveAdmin.register Supplier do
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

menu  priority: 26, label: "Proveedores"

permit_params :numero_proveedor, :num_documento_pais, :des_proveedor,
 :direccion_pais, :telefono_pais, :correo_pais, :pag_weeb, :nro_representante,
 :des_representante, :correo_representante, :activo, :fec_registro, :mod_registro,
  :tipo_proveedor, :calificacion, :observacion, :admin_user_id, :actividad, :num_traba


  form :title => 'Edicion Proveedor' do |f|

      f.inputs  do



         f.input :numero_proveedor,:label => 'Codigo identificacion ', :input_html => { :style =>  'width:30%'}
         f.input :num_documento_pais,:label => 'Pais ', :as => :select, :collection =>
             Formula.where(product_id:8).order('nombre').map{|u| [u.nombre, u.orden]}
           f.input :des_proveedor,:label => 'Proveedor Descripcion', :input_html => { :style =>  'width:30%'}
           f.input :direccion_pais,:label => 'Direccion', :input_html => { :style =>  'width:30%'}

         f.input :telefono_pais,:label => 'Telefono', :input_html => { :style =>  'width:30%'}
         f.input :correo_pais,:label => 'Correo', :input_html => { :style =>  'width:30%'}
         f.input :pag_weeb,:label => 'Pagina Web', :input_html => { :style =>  'width:30%'}
         f.input :nro_representante,:label => 'Telefono Representante', :input_html => { :style =>  'width:30%'}
         f.input :des_representante,:label => 'Nombre de Representante', :input_html => { :style =>  'width:30%'}
         f.input :correo_representante,:label => 'Correo de Representante', :input_html => { :style =>  'width:30%'}
         f.input :activo, :as => :select, :collection =>
             Formula.where(product_id:9).order('nombre').map{|u| [u.nombre, u.orden]}



         f.input :tipo_proveedor,:label => 'Tipo de Proveedor', :as => :select, :collection =>
             Formula.where(product_id:11).order('nombre').map{|u| [u.nombre, u.orden]}
         f.input :calificacion, :input_html => { :style =>  'width:30%'}
         f.input :mod_registro,:label => 'Certificacion', :input_html => { :style =>  'width:30%'}
          f.input :num_traba,:label => 'Numero de trabajadores', :input_html => { :style =>  'width:30%'}
         f.input :actividad,:label => 'Actividad principal', :as => :select, :collection =>
             Formula.where(product_id:10).order('nombre').map{|u| [u.nombre, u.orden]}

         f.input :observacion, :input_html => { :style =>  'width:30%'}
         f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden

                f.actions



      end
    end









end
