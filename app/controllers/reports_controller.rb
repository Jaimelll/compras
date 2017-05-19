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
  #autorizados con rj
  @tita=params[:param3]
  @piea=params[:param4]
  @vopc=params[:param5].to_i

  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd



  case @vopc
when 1
  @items=Item.where(ejecucion:4,modalidad:3,obac:params[:param2]).order('certificado')
  .where('id IN(?)',Detail.where(actividad:8).select("item_id"))
when 5
  @items=Item.where(ejecucion:4,obac:params[:param2]).order('certificado')
  .where("modalidad=1 or modalidad=2")
  .where('id IN(?)',Detail.where(actividad:57).select("item_id"))
end


respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte3.pdf.erb', pdf:'detalle'}
end
end



def comment4
  #en tramite de autorizacion

  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:3,obac:params[:param2]).order('certificado')
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
  @items=Item.where(ejecucion:4,obac:params[:param2],modalidad:4).order('certificado')
 .where('id IN(?)',Detail.where(actividad:200).select("item_id"))

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte5.pdf.erb', pdf:'detalle'}
end
end


def comment6
  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,obac:params[:param2],modalidad:4).order('certificado')
 .where.not('id IN(?)',Detail.where(actividad:200).select("item_id"))

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte6.pdf.erb', pdf:'detalle'}
end
end


def comment7
  @titproc=params[:param4].to_s
  @numproc=params[:param3].to_i
  @lista=Formula.where(product_id:11,orden:params[:param2]).
  select('nombre as dd').first.dd
  @vperiodo=Formula.where(product_id:11,orden:params[:param2]).
  select('orden as dd').first.dd
  @vperiodo2=Formula.where(product_id:11,orden:params[:param2]).
  select('nombre as dd').first.dd
  @vdetalle=Detail.order('pfecha')
  @vite=Item.all
  @items=ActiveRecord::Base.connection.execute("SELECT items.periodo,items.id,items.obac,
  items.pac,items.certificado,items.expediente,
    MAX(formulas.cantidad) as acti
   FROM public.items, public.details,
  public.formulas WHERE items.id = details.item_id AND
  details.actividad = formulas.orden AND
  formulas.product_id = 12 AND items.ejecucion=4  and
   items.modalidad<3 AND ((details.item_id,details.pfecha)
  IN(SELECT   details.item_id,   MAX(details.pfecha)
 FROM   public.details
 GROUP BY   details.item_id)) GROUP BY
 items.periodo,details.item_id, items.id,items.obac,items.pac,items.certificado,items.expediente").to_a

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte7.pdf.erb', pdf:'detalle'}
end
end



end
