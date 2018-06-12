ActiveAdmin.register Purchase do
    menu  priority: 21, label: "Data Warehouse"


    scope :Todos, :default => true do |adjudi|
        adjudi.all
    end

    scope :veinte_mil, :default => true do |adjudi|
        adjudi.where('montoadjudicadosoles<20000')
    end
    scope :cuarenta_mil, :default => true do |adjudi|
        adjudi.where('montoadjudicadosoles>20000 and montoadjudicadosoles<40000')
    end

    scope :sesenta_mil, :default => true do |adjudi|
        adjudi.where('montoadjudicadosoles>40000 and montoadjudicadosoles<100000')
    end
    scope :un_millon, :default => true do |adjudi|
        adjudi.where('montoadjudicadosoles>100000 and montoadjudicadosoles<1000000')
    end
    scope :mayor_a_un_millon, :default => true do |adjudi|
        adjudi.where('montoadjudicadosoles>1000000')
    end

    filter :proceso
    filter :fechaconsentimientobp, label:'Consentimiento'
    filter :proveedor
    filter :entidad
    filter :modalidad
    filter :itemconvoca_descripcion, label:'Item'


    #filter :montoadjudicadosoles

index :title => "Lista de procesos"  do
column("proceso")
column("Consentimiento") do |adjudi|
    adjudi.fechaconsentimientobp
end
column("proveedor")
column("entidad")
column("modalidad")
column("Item", sortable: :itemconvoca_descripcion) do |adjudi|
    adjudi.itemconvoca_descripcion
end

column("Adjudicado Soles", :class => 'text-right', sortable: :montoadjudicadosoles ) do |adjudi|
    number_with_delimiter(adjudi.montoadjudicadosoles, delimiter: ",")
end
column("PU", :class => 'text-right' ) do |adjudi|
    
    if adjudi.cantidadadjudicado then
      vpu=adjudi.montoadjudicadosoles*100/adjudi.cantidadadjudicado
    else
        vpu=adjudi*100.montoadjudicadosoles
    end 
       vpu2='%.02f' % vpu.fdiv(100)  
       number_with_delimiter(vpu2, delimiter: ",", separator: ".")
   
end

 actions

end













end
