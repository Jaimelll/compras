class ReportsController < ApplicationController

def comment
  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:2,lista:params[:param2]).order('obac,pac')

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte1.pdf.erb', pdf:'detalle'}
end
end


def comment2
  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:1,lista:params[:param2]).order('expediente')
respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte2.pdf.erb', pdf:'detalle'}
end
end

def comment3
  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:3,obac:params[:param2])
  .where('id IN(?)',Detail.where(actividad:8).select("item_id"))

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte3.pdf.erb', pdf:'detalle'}
end
end



def comment4
  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:3,obac:params[:param2])
  .where.not('id IN(?)',Detail.where(actividad:8).select("item_id"))

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte4.pdf.erb', pdf:'detalle'}
end
end

def comment5
  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,obac:params[:param2],modalidad:4).
 where('id IN(?)',Detail.where(actividad:200).select("item_id"))

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte5.pdf.erb', pdf:'detalle'}
end
end


def comment6
  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,obac:params[:param2],modalidad:4).
 where.not('id IN(?)',Detail.where(actividad:200).select("item_id"))

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte6.pdf.erb', pdf:'detalle'}
end
end


def comment7
  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd


respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte7.pdf.erb', pdf:'detalle'}
end
end



end
