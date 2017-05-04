class ReportsController < ApplicationController

def comment
  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:2,lista:params[:param2])
respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte1.pdf.erb', pdf:'detalle'}
end
end
end
