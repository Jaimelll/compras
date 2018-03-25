ActiveAdmin.register Sheet do
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
ActiveAdmin.register Movement do
belongs_to :sheet
end


menu  priority: 24, label: "Fichas"


permit_params :codigo_ficha, :codigo_revision, :creada,
     :revisada, :descripcion_original, :descripcion,
     :grupo, :clase, :cna, :na, :soc, :caracteristica,
     :vigencia, :unidad_medida, :categoria, :numero,
     :admin_user_id








     scope :Activos, :default => true do |ficha|
          ficha.where(vigencia:2)
     end

     scope :Homogenizados, :default => true do |ficha|
          ficha.where(vigencia:2).where.not("right(codigo_ficha,2)='ER'")
     end
     scope :Estandarizados, :default => true do |ficha|
          ficha.where(vigencia:2).where("right(codigo_ficha,2)='ER'")
     end



     scope :Progra_homogenizados, :default => true do |ficha|
         @vaf=current_admin_user.periodo
         vyear=Formula.where(product_id:11,orden:@vaf).
               select('nombre as dd').first.dd.to_i
         ejec=Movement.where(estado:3).where('extract(year from fechap) = ?',vyear).
                select('sheet_id ')
         ficha.where.not("right(codigo_ficha,2)='ER'").where(id:ejec)
     end

     scope :Progra_estandarizados, :default => true do |ficha|
         @vaf=current_admin_user.periodo
         vyear=Formula.where(product_id:11,orden:@vaf).
               select('nombre as dd').first.dd.to_i
         ejec=Movement.where(estado:3).where('extract(year from fechap) = ?',vyear).
                select('sheet_id ')
         ficha.where("right(codigo_ficha,2)='ER'").where(id:ejec)
     end

     scope :Elaboradas, :default => true do |ficha|
       @vaf=current_admin_user.periodo
       vyear=Formula.where(product_id:11,orden:@vaf).
             select('nombre as dd').first.dd.to_i
       ejec=Movement.where(estado:1).where('extract(year from fechap) = ?',vyear).
              select('sheet_id ')
       ficha.where(id:ejec)
     end
     scope :Revisadas, :default => true do |ficha|
       @vaf=current_admin_user.periodo
       vyear=Formula.where(product_id:11,orden:@vaf).
             select('nombre as dd').first.dd.to_i
       ejec=Movement.where(estado:2).where('extract(year from fechap) = ?',vyear).
              select('sheet_id ')
       ficha.where(id:ejec)
     end
     scope :SIE, :default => true do |ficha|

       ejec=Movement.where(estado:5).select('DISTINCT sheet_id ')
       ficha.where(id:ejec)
     end
     scope :Todos, :default => true do |ficha|
          ficha.all
     end




     filter :codigo_ficha
     filter :codigo_revision
     filter :descripcion

     filter :vigencia, label:'estado', :as => :select, :collection =>
           Formula.where(product_id:36).order('orden ASC').map{|u| ["#{u.nombre}", u.orden]}
     filter :categoria, :as => :select, :collection =>
                 Formula.where(product_id:37).order('orden ASC').map{|u| ["#{u.descripcion}", u.orden]}







     index :title => 'Lista de Fichas' do

       column("codigo_ficha") do |ficha|
         link_to "#{ficha.codigo_ficha} ", admin_sheet_movements_path(ficha.id)
       end
       column("codigo_revision")

       column("Fecha", :sortable => :revisada) do |ficha|
         if ficha.revisada then
             ficha.revisada.strftime("%d-%m-%Y")
         end
       end


      column("descripcion")


      column("Categoria") do |ficha|
            if ficha.categoria then
                 Formula.where(product_id:37, orden:ficha.categoria).
                  select('descripcion as dd').first.dd
            end
      end


      column("estado")  do |ficha|
            if ficha.vigencia then
                 Formula.where(product_id:36, orden:ficha.vigencia).
                  select('nombre as dd').first.dd
            end
          end





           actions

       end

       form :title => 'Edicion Fichas' do |f|

           f.inputs  do



              f.input :codigo_ficha, :input_html => { :style =>  'width:30%'}
              f.input :codigo_revision, :input_html => { :style =>  'width:30%'}
              f.input :creada,:label => 'fecha creacion' , as: :datepicker, :input_html => { :style =>  'width:30%'}
              f.input :revisada,:label => 'fecha revision', as: :datepicker, :input_html => { :style =>  'width:30%'}
              f.input :descripcion_original, :input_html => { :style =>  'width:30%'}
              f.input :descripcion, :input_html => { :style =>  'width:30%'}
              f.input :clase, :as => :select, :collection =>
                List.order('orden').map{|u| [u.clase+"-"+u.descripcion, u.id]}

              f.input :cna, :input_html => { :style =>  'width:30%'}
              f.input :na, :input_html => { :style =>  'width:30%'}
              f.input :soc, :input_html => { :style =>  'width:30%'}
              f.input :caracteristica, :input_html => { :style =>  'width:30%'}
              f.input :unidad_medida,:label => 'Unidad de medida', :as => :select, :collection =>
                  Formula.where(product_id:35).order('nombre').map{|u| [u.nombre, u.orden]}

              f.input :vigencia,:label => 'Estado de la ficha', :as => :select, :collection =>
                      Formula.where(product_id:36).order('nombre').map{|u| [u.nombre, u.orden]}
             f.input :categoria,:label => 'Categoria', :as => :select, :collection =>
                      Formula.where(product_id:37).order('nombre').map{|u| [u.descripcion, u.orden]}
              f.input :numero,:label => 'Resolucion', :input_html => { :style =>  'width:30%'}
              f.input :grupo,:label => 'Periodo', :as => :select, :collection =>
                       Formula.where(product_id:11).order('nombre').map{|u| [u.nombre, u.orden]}

              f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden

                     f.actions



           end
         end

         show :title => ' Fichas'  do

               attributes_table  do
                row :codigo_ficha
                row :codigo_revision
                row "fecha creacion" do |ficha|
                   ficha.creada
                end
               row "fecha revision" do |ficha|
                    ficha.revisada
                end

                row :descripcion_original
                row :descripcion

                row("clase") do |ficha|
                  cfic=List.where(id:ficha.clase).count
                    if cfic>0 then
                      List.where(id:ficha.clase).select('clase as dd').first.dd
                    else
                      "s/d"
                   end
                end


                row :cna
                row :na
                row :soc
                row :caracteristica
                row  "Resolucion"  do |ficha|
                   ficha.numero
                 end
                row "estado"  do |ficha|
                      if ficha.vigencia then
                           Formula.where(product_id:36, orden:ficha.vigencia).
                            select('nombre as dd').first.dd
                      end
                    end
                row :unidad_medida  do |ficha|
                      if ficha.unidad_medida then
                           Formula.where(product_id:35, orden:ficha.unidad_medida).
                            select('nombre as dd').first.dd
                      end
                end
                row :categoria  do |ficha|
                      if ficha.categoria then
                           Formula.where(product_id:37, orden:ficha.categoria).
                            select('descripcion as dd').first.dd
                      end
                    end
                    row "Periodo"  do |ficha|
                          if ficha.grupo and ficha.grupo>0 then
                               Formula.where(product_id:11, orden:ficha.grupo).
                                select('nombre as dd').first.dd
                          end
                        end



               end
             end













end
