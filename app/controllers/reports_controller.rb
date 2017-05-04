class ReportsController < ApplicationController

def comment
  @details = Detail.where("pfecha>'02/05/2017'")
respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte1.pdf.erb', pdf:'detalle'}
end
end
end
