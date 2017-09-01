ActiveAdmin.register_page "Indices" do

  menu  priority: 14,label: "Indices"


  content title: "Indices" do

  panel  "Indices" do
    table_for Formula.where(product_id:11).where(cantidad:1)  do


         column(" Desviaciones" ) do |formula|

           link_to "PACs", reports_vhoja5_path(format:  "xls")
         end

         column(" Desviaciones" ) do |formula|

           link_to "Procesos", reports_vhoja5_path(format:  "xls")
         end





  end
end


end











end
