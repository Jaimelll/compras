class ReportsController < ApplicationController

def comment
  @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
  @tit1=params[:param3].to_s


  @vopc=params[:param4].to_i

  case @vopc
when 1
  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:2,lista:params[:param2]).order('obac,pac')
  .where(exped2:@vaf)

when 2
   @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:1,lista:params[:param2]).order('expediente')
  .where(exped2:@vaf)

when 3
  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,lista:params[:param2]).where("modalidad<3")
          .where(exped2:@vaf)
 when 4
   @lista=Formula.where(product_id:11,orden:params[:param2]).select('nombre as dd').first.dd
   @items= Item.where(ejecucion:4,exped2:params[:param2])
       .where("modalidad<3")
  when 5
       @lista=Formula.where(product_id:11,orden:params[:param2]).select('nombre as dd').first.dd
       @items= Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)")
       .where(exped2:params[:param2])

 when 6
   @lista=" "
   @items=Item.where(ejecucion:4,modalidad:2,tipo:params[:param2]).order('obac,pac')
   .where(exped2:@vaf)

 when 7
   @lista=" "
   @items=Item.where(ejecucion:4,modalidad:1,tipo:params[:param2]).order('obac,pac')
   .where(exped2:@vaf)

 when 8
   @lista=" "
   @items= Item.where(ejecucion:4,tipo:params[:param2]).where("modalidad<3")
           .where(exped2:@vaf)






  end



respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte1.pdf.erb', pdf:'detalle'}
end
end


#def comment2
#  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
#  @items=Item.where(ejecucion:4,modalidad:1,lista:params[:param2]).order('expediente')
#  .where.not('id IN(?)',Detail.where(actividad:61).select("item_id"))
#respond_to do |format|

#format.html
#format.json
#format.pdf{render template: 'reports/reporte2.pdf.erb', pdf:'detalle'}
#end
#end

def comment3
  #autorizados con rj
  @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
  @tita=params[:param3]
  @piea=params[:param4]
  @vopc=params[:param5].to_i

  @lista=Formula.where(product_id:1,cantidad:1,orden:params[:param2]).
  select('descripcion as dd').first.dd



  case @vopc
when 1
  @items=Item.where(ejecucion:4,modalidad:3,obac:params[:param2]).order('certificado')
  .where(exped2:@vaf)
  .where('id IN(?)',Detail.where(actividad:8).select("item_id"))
when 2
@items=  Item.where(ejecucion:4,modalidad:3,obac:params[:param2]).order('certificado')
  .where(exped2:@vaf)
  .where.not('id IN(?)',Detail.where(actividad:8).select("item_id"))
when 3
@items=   Item.where(ejecucion:4,obac:params[:param2],modalidad:4).order('certificado')
  .where(exped2:@vaf)
  .where('id IN(?)',Detail.where(actividad:200).select("item_id"))
when 4
@items=  Item.where(ejecucion:4,obac:params[:param2],modalidad:4).order('certificado')
.where(exped2:@vaf)
.where.not('id IN(?)',Detail.where(actividad:200).select("item_id"))

when 5
  @items=Item.where(ejecucion:4,obac:params[:param2]).order('certificado')
  .where(exped2:@vaf)
  .where("modalidad=1 or modalidad=2")
  .where('id IN(?)',Detail.where(actividad:57).select("item_id"))
end


respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte3.pdf.erb', pdf:'detalle'}
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
#@vdetalle=Detail.order('pfecha')
@vdetalle= Detail.where(actividad: Formula
.where(product_id:12,cantidad:params[:param3]).select('orden'))
.order('pfecha')

  @vite=Item.all
  @items=ActiveRecord::Base.connection.execute("SELECT items.exped2,items.id,items.obac,
  items.pac,items.certificado,items.exped,
    items.tipo,items.modalidad,
    MAX(formulas.cantidad) as acti
   FROM public.items, public.details,
  public.formulas WHERE items.id = details.item_id AND
  details.actividad = formulas.orden AND
  formulas.product_id = 12 AND items.ejecucion=4 and
   items.modalidad<3  AND exped2=(SELECT max(orden) FROM  formulas where cantidad=1
    GROUP BY product_id HAVING product_id=11) AND ((details.item_id,details.pfecha)
  IN(SELECT   details.item_id,   MAX(details.pfecha)
 FROM   public.details
 GROUP BY   details.item_id)) GROUP BY
 items.exped2,details.item_id, items.id,items.obac,items.pac,items.certificado,items.exped,
items.tipo,items.modalidad").to_a

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte7.pdf.erb', pdf:'detalle'}
end
end



end
