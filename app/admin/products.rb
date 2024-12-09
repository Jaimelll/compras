ActiveAdmin.register Product do
  # Cambiar el nombre en el panel de administración a "Productos"
  menu label: "Productos"  # Esto hace que se vea como "Productos" en el menú lateral

  # Permitir los parámetros para creación
  permit_params :nombre, :descripcion, :orden, :created_by_id

  # Filtros solo para los campos nombre, descripcion, orden
  filter :nombre
  filter :descripcion
  filter :orden

  # El campo created_by_id se llena automáticamente con el usuario actual, pero no es editable
  controller do
    def create
      # Asignar el usuario activo al campo 'created_by_id' automáticamente
      params[:product][:created_by_id] = current_admin_user.id
      super
    end

    def update
      # Asegurarse de que 'created_by_id' no se actualice manualmente
      params[:product].delete(:created_by_id)
      super
    end
  end

  # Configuración de la vista 'index'
  index do
    selectable_column
    id_column
    column :nombre
    column :descripcion
    column :orden
 
    actions
  end

  # Configuración del formulario (crear y editar)
  form do |f|
    f.inputs do
      f.input :nombre
      f.input :descripcion
      f.input :orden
      f.input :created_by_id, as: :hidden, input_html: { value: current_admin_user.id }  # Este campo se oculta y se llena por defecto
    end
    f.actions
  end

  # Configurar el campo 'created_by_id' para que no se pueda editar en el formulario de edición
  show do
    attributes_table do
      row :nombre
      row :descripcion
      row :orden
      row :created_by_id
      row :created_at
    end
  end
end
