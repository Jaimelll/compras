class ReportsController < ApplicationController

def comment

  @items=Item.where(ejecucion:4,modalidad:2,lista:params[:param2])
respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte1.pdf.erb', pdf:'detalle'}
end
end
end
