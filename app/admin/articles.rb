ActiveAdmin.register Article do

  menu false



  permit_params :item_id, :ficha,:descripcion, :unidad,:cantidad,
                :precision, :paquete, :piece,:referencial,
                :estado,:obs,:art3,:art4,:art5,:art6


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
    if articles.ficha and articles.ficha>0 then
    vrevs=Sheet.where( id:articles.ficha).
       select('codigo_revision as dd').first.dd
       localiz='http://www.acffaa.gob.pe/documents/32651/443704/'+vrevs+'.pdf'
       link_to vrevs, localiz
    else
      "s/d"
    end
  end
column("CUBSO")  do |articles|
  articles.art3
end
  column("descripcion")
  column("unidad") do |articles|
  if articles.unidad and articles.unidad>0 then
    Formula.where(product_id:35, orden:articles.unidad).
     select('nombre as dd').first.dd
  else
    "s/d"
  end
end
  column("cantidad")

    column("Moneda", :class => 'text-right', sortable: :art1) do |articles|

    if articles.art1 then
      Formula.where(product_id:7, orden:articles.art1).
       select('nombre as dd').first.dd
    else
      "s/d"
    end
  end

  column("Estimado", :class => 'text-right', sortable: :art4) do |articles|
    number_with_delimiter(articles.art4, delimiter: ",")
  end

  column("Item paquete") do |articles|
  if articles.piece and articles.piece>0 then
    Piece.where(id:articles.piece).
     select('codigo as dd').first.dd
  else
    "s/d"
  end
end
  #column("piece")

actions

  end

      form :title => 'Edicion Articulos'  do |f|
          if params[:id] then
            #edit
            viditem=Article.where(id:params[:id]).
                        select('item_id').map {|e| e.attributes.values}.flatten
            if Item.where(id:viditem).where('exped>0').count>0 then
              vexp=Item.where(id:viditem).
                  select('exped').map {|e| e.attributes.values}.flatten
             if  Phase.where(expediente:vexp).count>0  then
                 @vprocs=Phase.where(expediente:vexp).
                   select('id').map {|e| e.attributes.values}.flatten



             end
             end

          end


            f.inputs  do

                  @vaf=current_admin_user.periodo

                   f.input :paquete, :input_html => { :style =>  'width:30%'}

                   f.input :ficha, :as => :select, :collection =>
                            Sheet.where(vigencia:2).order('descripcion').map{|u| [u.descripcion+"("+u.codigo_ficha+")", u.id]}
                   f.input :descripcion
                   f.input :unidad, :as => :select, :collection =>
                           Formula.where(product_id:35).map{|u| [u.nombre, u.orden]}
                   f.input :cantidad, :input_html => { :style =>  'width:30%'}
                   f.input :art1,:label => 'Moneda', :as => :select, :collection =>
                           Formula.where(product_id:7,numero:@vaf).map{|u| [u.nombre, u.orden]}
                   f.input :art4,:label => 'Estimado', :input_html => { :style =>  'width:30%'}
                   f.input :precision, :input_html => { :style =>  'width:30%'}
                   f.input :art5,:label => 'Desierto', :input_html => { :style =>  'width:30%'}
                   f.input :art6,:label => 'Convocado', :input_html => { :style =>  'width:30%'}
                   f.input :art3,:label => 'CUBSO'

                   f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden

               if params[:id] then
            #       Article.where(id:params[:id]).each do |aart|
            #         if aart.ficha then
            #           vdesc=Sheet.where(id:aart.ficha).select("descripcion as dd").first.dd
            #           Article.where(id:aart.id).update_all( descripcion:vdesc )
            #         end
            #       end



                   f.input :piece,:label => 'Item paquete', :as => :select, :collection =>
                             Piece.where(phase_id:@vprocs).map{|u| [u.codigo, u.id]}
                end
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


                       row "ficha" do |articles|
                         if articles.ficha and articles.ficha>0 then
                           Sheet.where( id:articles.ficha).
                            select('descripcion as dd').first.dd
                         else
                           "s/d"
                         end
                       end

                       row :descripcion
                       row :unidad  do |articles|

                         if articles.unidad and articles.unidad>0  then
                           Formula.where(product_id:35, orden:articles.unidad).
                            select('nombre as dd').first.dd
                         else
                           "s/d"
                         end
                       end
                       row :cantidad
                       row "Moneda"  do |articles|

                         if articles.art1 and articles.art1>0  then
                           Formula.where(product_id:7, orden:articles.art1).
                            select('nombre as dd').first.dd
                         else
                           "s/d"
                         end
                       end
                       row "estimado" do |articles|
                         articles.art4
                       end
                      row :precision
                      row "Desierto" do |articles|
                       articles.art5
                      end

                      row "Convocado" do |articles|
                        articles.art6
                      end

                      row "CUBSO" do |articles|
                        articles.art3
                      end

                       row :admin_user_id

                       row 'Item paquete' do |articles|
                       if articles.piece and articles.piece>0 then
                         Piece.where(id:articles.piece).
                          select('codigo as dd').first.dd
                       else
                         "s/d"
                       end
                       end
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
