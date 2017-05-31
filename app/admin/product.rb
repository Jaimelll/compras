ActiveAdmin.register Product do
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

#menu if: proc{ current_admin_user.id==2 }, priority: 3, label: "Productos"

menu  priority: 3, label: "Productos"

permit_params :nombre, :descripcion, :orden,
     :obs

     action_item :view, only: :show do
       link_to 'Ir a Productos', admin_products_path()
     end

filter :nombre



index do

  column("nombre")
  column("descripcion")
  column("orden")


    actions
end



form do |f|

  f.inputs "Products" do
        f.input :nombre
        f.input :descripcion
        f.input :orden

  end



     f.actions

end









    show do
      nn=Product.where(id:params[:id]).
                 select('nombre as dd').first.dd.capitalize

           panel "Formula de #{nn}" do

        table_for(product.formulas.order('orden ASC')) do |t|
          t.column("Nombre:", :sortable => :id) {|formula|
                   link_to "#{formula.nombre} ",  admin_product_formula_path(product,formula) }

          t.column("descripcion", :sortable => :id) {|formula|
                   link_to "#{formula.descripcion.capitalize} ",  admin_product_formula_path(product,formula) }
          t.column("orden")
          t.column("cantidad")
          t.column("numero")


        end

      end

      strong { link_to 'Agregar formula', new_admin_product_formula_path(product) }


  end

end
