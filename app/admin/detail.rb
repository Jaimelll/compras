ActiveAdmin.register Detail do
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
menu false



permit_params :actividad, :tipo,:numero, :pfecha,:importe,
              :obs, :admin_user_id, :item_id,:moneda,
              :created_at,:updated_at


  action_item :view, only:[:show,:new]do
    if params[:item_id] then
  nn=Item.where(id:params[:item_id]).
           select('pac as dd').first.dd.capitalize
        link_to "Ir a PAC-#{nn}", admin_item_path(params[:item_id])
    end
   end



  action_item :view, only:[:show, :new]do
            link_to 'Ir a PACs', admin_items_path()
  end



  action_item :view, only: [:show, :index] do
    if params[:item_id] then
          link_to 'Agregar actividad', new_admin_item_detail_path(params[:item_id])
    end
  end

  scope :PAC, :default => true do |details|

     details.where(item_id:params[:item_id])

  end




filter :actividad,  :as => :select, :collection =>
      Formula.where(product_id:12).order('orden ASC').map{|u| ["#{u.cantidad}", u.orden]}



index do

  column("Actividad", :sortable => :item_id) do   |detail|
if params[:item_id] then


    if detail.actividad then
      n2=Formula.where(product_id:12,orden:detail.actividad).
              select('cantidad as dd').first.dd

       n1=Formula.where(product_id:12,orden:detail.actividad).
               select('descripcion as dd').first.dd.capitalize+
                "-----"+
                 "#{Formula.where(product_id:10,orden:n2).
                          select('nombre as dd').first.dd}"



   else
            n1="s/d"
   end

    # link_to "#{n1} ",  admin_item_detail_path(item,detail) }
    case current_admin_user.id # a_variable is the variable we want to compare
    when 1,2,4,6,8,9 #gex
             n3=1
       when 11 #estudio de mercado
            if n2==4
              n3=1
            else
              n3=2
            end
        when 12 # catalogacion
               if n2==3
                 n3=1
               else
                 n3=2
               end
        when 13 #proceso de contrataciones
                  if n2==5
                    n3=1
                  else
                    n3=2
                  end
        when 14 #ejecucion de contratos
                     if n2==6
                       n3=1
                     else
                       n3=2
                     end

        else
             n3=2
      end

  link_to_if @n3==1 ,"#{n1} ",  admin_item_detail_path(params[:item_id],detail)
end
end
column("pfecha")
column("tipo")
column("numero")
column("pfecha")
column("importe") do |detail|
 number_with_delimiter(detail.importe, delimiter: ",")
end
column("moneda") do |detail|
  if detail.moneda then
    Formula.where(product_id:7,orden:detail.moneda).select('nombre as dd').first.dd.to_s

  end
end

#if @n3==1 then
#actions
#end

end

    form  do |f|

        if params[:id] then
#edit
              n1=Detail.where(id:params[:id]).
                       select('item_id as dd').first.dd.to_i
               nn=Item.where(id:n1).
                          select('pac as dd').first.dd.capitalize
          f.inputs "PAC-#{nn}" do
                 f.input :item_id, :label => 'PAC', :as => :select, :collection =>
                      Item.all.order('pac ASC').map{|u| [u.pac, u.id]}

                 f.input :actividad, :as => :select, :collection =>

                 case current_admin_user.id # a_variable is the variable we want to compare
                 when 1,2,4,6,8,9   #mgp
                     Formula.where(product_id:12).order("descripcion").
                       map{|u| [u.descripcion.capitalize,
                        u.orden]}
                 when 7,11     #castaneda
                     Formula.where(product_id:12,cantidad:4).order("orden").
                       map{|u| [u.descripcion.capitalize,
                        u.orden]}
                 when 12     #dc
                          Formula.where(product_id:12,cantidad:3).order("orden").
                            map{|u| [u.descripcion.capitalize,
                             u.orden]}
                 when 13     #dpc
                               Formula.where(product_id:12,cantidad:5).order("orden").
                                 map{|u| [u.descripcion.capitalize,
                                  u.orden]}

                 when 14    #dec
                                    Formula.where(product_id:12,cantidad:6).order("orden").
                                      map{|u| [u.descripcion.capitalize,
                                       u.orden]}
                  end



                 f.input :tipo,:label => 'Documento de recepcion', :input_html => { :style =>  'width:30%'}
                 f.input :numero,:label => 'Numero de documento', :input_html => { :style =>  'width:30%'}
                 f.input :pfecha, :label => 'fecha de documento' ,:as =>:string, :input_html => { :style =>  'width:30%'}
                 f.input :importe,:label => 'Importe de CPP,CPR o Valoracion',:as =>:string, :input_html => { :style =>  'width:30%'}
                 f.input :moneda, :as => :select, :collection =>
                          Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}

                 f.input :obs, :input_html => { :style =>  'width:30%'}
                 f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden


                       end
                f.actions
          end

#nuevo
            if params[:item_id] then
               nn=Item.where(id:  params[:item_id]).
                        select('pac as dd').first.dd.capitalize
           f.inputs "#{nn}" do
             f.input :item_id, :label => 'PAC' ,
                      :input_html => { :value =>   params[:item_id]}, :as => :hidden

             f.input :actividad, :as => :select, :collection =>
             case current_admin_user.id # a_variable is the variable we want to compare
             when 1,2,4,6,8,9  #mgp
                 Formula.where(product_id:12).order("descripcion").
                   map{|u| [u.descripcion.capitalize,
                    u.orden]}
             when 7,11     #castaneda
                 Formula.where(product_id:12,cantidad:4).order("orden").
                   map{|u| [u.descripcion.capitalize,
                    u.orden]}
                  when 12     #dc
                           Formula.where(product_id:12,cantidad:3).order("orden").
                             map{|u| [u.descripcion.capitalize,
                              u.orden]}
                  when 13     #dpc
                                Formula.where(product_id:12,cantidad:5).order("orden").
                                  map{|u| [u.descripcion.capitalize,
                                   u.orden]}

                  when 14    #dec
                                     Formula.where(product_id:12,cantidad:6).order("orden").
                                       map{|u| [u.descripcion.capitalize,
                                        u.orden]}
              end


             f.input :tipo, :label => 'Documemto de recepcion', :input_html => { :style =>  'width:30%'}
             f.input :numero, :label => 'Numero de documento', :input_html => { :style =>  'width:30%'}
             f.input :pfecha, :label => 'fecha de documento' ,:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :importe, :label => 'Importe de CPP,CPR o Valoracion',:as =>:string, :input_html => { :style =>  'width:30%'}
             f.input :moneda, :as => :select, :collection =>
                      Formula.where(product_id:7).map{|u| [u.nombre.capitalize, u.orden]}
             f.input :obs, :input_html => { :style =>  'width:30%'}
             f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden

                   end
                f.actions


            strong { link_to  new_admin_item_detail_path(params[:item_id]) }

                f.inputs "#{nn}" do
                    f.input :tipo

                end


            #    no tiene parametros y la ruta no pasa por item
              end
          end

          show do


                    attributes_table do
                  if params[:id] then
                    n1=Detail.where(id:params[:id]).
                             select('item_id as dd').first.dd.to_i
                     nn=Item.where(id:n1).
                                select('pac as dd').first.dd.capitalize

                  else
                    nn=Item.where(id:params[:item_id]).
                             select('pac as dd').first.dd.capitalize

                  end
                      row :item_id do |formula|
                        link_to "PAC-#{nn}", admin_item_path(detail.item_id)
                      end
                      row :actividad
                      row :tipo
                      row :numero
                      row :pfecha
                      row :importe
                      row :moneda

                      row :obs
                      row :admin_user_id

                    end

                end





end
