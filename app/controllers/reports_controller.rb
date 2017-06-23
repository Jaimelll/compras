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
        .order('tipo,modalidad,exped,obac,pac')
  when 5
       @lista=Formula.where(product_id:11,orden:params[:param2]).select('nombre as dd').first.dd
       @items= Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)")
       .where(exped2:params[:param2])

 when 6
   @lista=" "
   @items=Item.where(ejecucion:4,modalidad:2,tipo:params[:param2]).order('obac,pac')
   .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac')

 when 7
   @lista=" "
   @items=Item.where(ejecucion:4,modalidad:1,tipo:params[:param2]).order('obac,pac')
   .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac')

 when 8
   @lista=" "
   @items= Item.where(ejecucion:4,tipo:params[:param2]).where("modalidad<3")
           .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac')



  end



respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte1.pdf.erb', pdf:'detalle'}
end
end



def comment2

  @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
  @tit1=params[:param3].to_s


  @vopc=params[:param4].to_i

  case @vopc

  when 5
       @lista=Formula.where(product_id:11,orden:params[:param2]).select('nombre as dd').first.dd
       @items= Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)")
       .where(exped2:params[:param2]).order('obac,certificado DESC')


  end



respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte2.pdf.erb', pdf:'detalle'}
end
end




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




def comment4
  @vopc=params[:param1].to_i
  case @vopc
   when 1
     @tit1="Calendario de Presentacion de Propuestas"

     @activities=Phase.joins(:activities).where("activities.actividad=20 and activities.pfecha>=current_date " )
       .select(" activities.pfecha as pfecha,phases.expediente  as expediente,
      phases.nomenclatura  as nomenclatura,phases.descripcion as descripcion,
      phases.moneda as moneda,phases.valor as valor ")
       .order("pfecha")
     when 2
       @tit1="Calendario de Convocatorias con Buena Pro Consentida"

       @activities=Phase.joins(:activities).where("activities.actividad=20 and activities.pfecha<current_date
       and importe IS NOT NULL and importe>0" )
         .select("phases.id as id, activities.pfecha as pfecha,phases.expediente  as expediente,
        phases.nomenclatura  as nomenclatura,phases.descripcion as descripcion,
        phases.moneda as moneda,phases.valor as valor ")
         .order("pfecha")
       when 3
         @tit1="Relacion de Procesos "

         @activities=Phase.joins(:activities).where("activities.actividad=19 " )
           .select("phases.id as id, activities.pfecha as pfecha,phases.expediente  as expediente,
          phases.nomenclatura  as nomenclatura,phases.descripcion as descripcion,
          phases.moneda as moneda,phases.valor as valor ")
           .order("pfecha")

   end

  respond_to do |format|

  format.html
  format.json
  format.pdf{render template: 'reports/reporte4.pdf.erb', pdf:'detalle'}

  end
  end





def comment7
  @vpacv=params[:param5]
  @titproc=params[:param4].to_s
  #@numproc=params[:param3].to_i
  @vper=Formula.where(product_id:11,cantidad:1).select('nombre as dd').first.dd

@vdetalle= Detail.where(actividad: Formula
.where(product_id:12,cantidad:params[:param3]).select('orden'))
.order('pfecha')


  @items=Item.where(id:@vpacv).order('tipo,modalidad,exped,obac,pac')

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte7.pdf.erb', pdf:'detalle'}
end
end



end
