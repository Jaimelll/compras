ActiveAdmin.register Article do

  menu false



  permit_params :item_id, :ficha,:descripcion, :unidad,:cantidad,
                :precision, :paquete, :piece,:referencial,
                :estado,:obs


    action_item :view, only:[:show,:new,:index]do
      if params[:item_id] then
    nn=Item.where(id:params[:item_id]).
             select('pac as dd').first.dd.capitalize
          link_to "Ir a PAC-#{nn}", admin_item_path(params[:item_id])
      end
     end



    action_item :view, only:[:show, :new]do
              link_to 'Ir a PACs', admin_items_path()
    end





    scope :PAC, :default => true do |articles|

       articles.where(item_id:params[:item_id])

    end




  filter :descripcion


  index :title => "Lista de Articulos"  do

  column("paquete")

  column("ficha", :sortable => :pfecha) do |articles|
    if articles.ficha then
      Sheet.where( id:articles.ficha).
       select('descripcion as dd').first.dd
    else
      "s/d"
    end
  end

  column("descripcion")
  column("unidad") do |articles|
  if articles.unidad then
    Formula.where(product_id:35, orden:articles.unidad).
     select('nombre as dd').first.dd
  else
    "s/d"
  end
end
  column("cantidad")
  #column("piece")

actions

  end

      form :title => 'Edicion Articulos'  do |f|


            f.inputs  do



                   f.input :paquete, :input_html => { :style =>  'width:30%'}

                   f.input :ficha, :as => :select, :collection =>
                            Sheet.where(vigencia:2).order('descripcion').map{|u| [u.descripcion+"("+u.codigo_ficha+")", u.id]}
                   f.input :descripcion
                   f.input :unidad, :as => :select, :collection =>
                           Formula.where(product_id:35).map{|u| [u.nombre, u.orden]}
                   f.input :precision, :input_html => { :style =>  'width:30%'}

                   f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


                         end
                  f.actions



              #    no tiene parametros y la ruta no pasa por item

            end

            show :title => ' Articulo ' do


                      attributes_table do

                        if params[:id] then
                          n1=Article.where(id:params[:id]).
                                   select('item_id as dd').first.dd.to_i
                           nn=Item.where(id:n1).
                                      select('pac as dd').first.dd.capitalize

                        else
                          nn=Item.where(id:params[:item_id]).
                                   select('pac as dd').first.dd.capitalize

                        end

                        row "PAC" do |articles|
                          link_to "#{nn}", admin_item_articles_path(params[:item_id])
                        end
                       row :paquete


                       row("ficha", :sortable => :ficha) do |articles|
                         if articles.ficha then
                           Sheet.where( id:articles.ficha).
                            select('descripcion as dd').first.dd
                         else
                           "s/d"
                         end
                       end

                       row :descripcion
                       row :unidad  do |articles|
                         if articles.unidad then
                           Formula.where(product_id:35, orden:articles.unidad).
                            select('nombre as dd').first.dd
                         else
                           "s/d"
                         end
                       end
                       row :cantidad
                       row :admin_user_id

                      end

                  end

                  sidebar "Datos del PAC" do
                    if params[:item_id] then
                       nn=Item.where(id:  params[:item_id]).
                                select('pac as dd').first.dd.capitalize
                        n1=Item.where(id:  params[:item_id]).
                                 select('obac as dd').first.dd
                       n11=Item.where(id:  params[:item_id]).
                                select('exped as dd').first.dd

                        n2= Item.where(id:params[:item_id]).
                                 select('descripcion as dd').first.dd.capitalize
                        n3=Formula.where(product:1,orden:n1).
                              select('descripcion as dd').first.dd.capitalize

                        n31=Formula.where(product:16,orden:n11).
                             select('nombre as dd').first.dd.capitalize


                    ul do
                      li "No de PAC:   "+nn
                      li "DESCRIPCION: "+n2
                      li "OBAC:  "+n3
                      li "EXPEDIENTE:  "+n31
                    end


                  end# de if
                  end # de sider




end
