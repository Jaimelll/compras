ActiveAdmin.register List do
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


menu  priority: 25, label: "Clase"
permit_params :clase, :descripcion, :orden
    # :admin_user_id

filter :clase
filter :descripcion
filter :orden




     index :title => 'Lista de Clases' do

             column("clase")
             column("descripcion")
             column("orden")



              actions
          end
          form :title => 'Edicion Clase'  do |f|


                  f.inputs  do

                    f.input :clase, :input_html => { :style =>  'width:30%'}
                    f.input :descripcion
                    f.input :orden, :input_html => { :style =>  'width:30%'}
                #    f.input :admin_user_id, :input_html => { :value => current_admin_user.id }, :as => :hidden

                           f.actions

                    end

          end

          show :title => ' Clase'  do

                attributes_table  do





                row :clase
                row :descripcion
                row :orden



                end
              end






end
