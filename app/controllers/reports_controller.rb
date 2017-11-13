class ReportsController < ApplicationController





def comment
  case current_admin_user.id # a_variable is the variable we want to compare
  when 21
    @vuobac=[1]
  when 22
    @vuobac=[2]
  when 23
    @vuobac=[3]
  else
    @vuobac=[1,2,3,4,5,6]
  end



  @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
  @tit1=params[:param3].to_s


  @vopc=params[:param4].to_i

  case @vopc
when 1
  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:2,lista:params[:param2]).order('tipo,certificado DESC')
  .where(exped2:@vaf).where(obac: @vuobac)

when 2
   @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:1,lista:params[:param2])
  .where(exped2:@vaf).where(obac: @vuobac).order('exped')

when 3
  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,lista:params[:param2]).where("modalidad<3")
          .where(exped2:@vaf).where(obac: @vuobac).order('tipo,modalidad,certificado DESC')
 when 4
   @lista=Formula.where(product_id:11,orden:params[:param2]).select('nombre as dd').first.dd
   @items= Item.where(ejecucion:4,exped2:params[:param2])
              .where("modalidad<3")
        .order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)
  when 5
       @lista=Formula.where(product_id:11,orden:params[:param2]).select('nombre as dd').first.dd
       @items= Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)")
       .where(exped2:params[:param2]).where(obac: @vuobac)

 when 6
   @lista=" "
   @items=Item.where(ejecucion:4,modalidad:2,tipo:params[:param2]).order('obac,pac')
   .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)

 when 7
   @lista=" "
   @items=Item.where(ejecucion:4,modalidad:1,tipo:params[:param2]).order('obac,pac')
   .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)

 when 8
   @lista=" "
   @items= Item.where(ejecucion:4,tipo:params[:param2]).where("modalidad<3")
           .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)
         when 9
           @lista=" "
           @items=Item.where(ejecucion:4,modalidad:2,fuente:params[:param2]).order('obac,pac')
           .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)

         when 10
           @lista=" "
           @items=Item.where(ejecucion:4,modalidad:1,fuente:params[:param2]).order('obac,pac')
           .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)

         when 11
           @lista=" "
           @items= Item.where(ejecucion:4,fuente:params[:param2]).where("modalidad<3")
                   .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)
     when 12
         @lista=" "
         @items= Item.where(ejecucion:4,fuente:params[:param2]).where("modalidad<3")
             .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)

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
@vprov=params[:param2]

@tit1=params[:param4].to_s

           @activities=Phase.where(id:@vprov).
           order('pp ASC')



  respond_to do |format|

  format.html
  format.json
  format.pdf{render template: 'reports/reporte4.pdf.erb', pdf:'detalle'}

  end
  end







  def comment5
    @vpaso1=params[:param2]
    @vactcanti=params[:param3]
    @vpacv=params[:param5]
    @titproc=params[:param4].to_s
    #@numproc=params[:param3].to_i
    @vper=Formula.where(product_id:11,cantidad:1).select('nombre as dd').first.dd

  @vdetalle= Activity.where(actividad: Formula
  .where(product_id:12,cantidad:params[:param3]).select('orden'))
  .order('pfecha')


    @items=Phase.where(id:@vpacv).order('sele2 DESC')

  respond_to do |format|

  format.html
  format.json
  format.pdf{render template: 'reports/reporte5.pdf.erb', pdf:'detalle'}
  end
    end




    def comment6

      @vactcanti=params[:param3]
      @vpacv=params[:param5]
      @titproc=params[:param4].to_s
      #@numproc=params[:param3].to_i
      @vper=Formula.where(product_id:11,cantidad:1).select('nombre as dd').first.dd

    @vdetalle= Element.where(actividad: Formula
    .where(product_id:19,cantidad:params[:param3]).select('orden'))
    .order('pfecha')


      @items=Contract.where(id:@vpacv).order('numero')

    respond_to do |format|

    format.html
    format.json
    format.pdf{render template: 'reports/reporte6.pdf.erb', pdf:'detalle'}
    end
      end






def comment7
  @vactcanti=params[:param3]
  @vpacv=params[:param5]
  @titproc=params[:param4].to_s
  #@numproc=params[:param3].to_i
  @vper=Formula.where(product_id:11,cantidad:1).select('nombre as dd').first.dd

@vdetalle= Detail.where(actividad: Formula
.where(product_id:12,cantidad:params[:param3]).select('orden'))
.order('pfecha')


  @items=Item.where(id:@vpacv).order('tipo,modalidad,exped,certificado DESC')

respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte7.pdf.erb', pdf:'detalle'}
end
end



def vhoja1
  @vnpac=params[:param1]
  @vmpac=params[:param2]
  @vpac1=params[:param3]
  @vpac2=params[:param4]
  @vpac3=params[:param5]
  @vpac4=params[:param6]
  @vpac5=params[:param7]
#  @items=Item.order('tipo,modalidad,exped,certificado DESC')
  @items=Item.order('tipo,modalidad,exped,certificado DESC')
  respond_to do |format|
    format.html
    format.xls{render template: 'reports/hoja1.xls.erb', xls:'ahoja'}
    format.xlsx{render template: 'reports/hoja1.xlsx.axlsx', xlsx:'SeguimPac'}
  end
end


def vhoja2
  @vnpac=params[:param1]
  @vmpac=params[:param2]
  @vpac1=params[:param3]
  @vpac2=params[:param4]
  @vpac3=params[:param5]
  @vpact=params[:param6]
  @vuobac=params[:param7]
  @activities=Phase.order('pp ASC')



  respond_to do |format|
    format.html
    format.xls{render template: 'reports/hoja2.xls.erb', xls:'ahoja'}
    format.xlsx{render template: 'reports/hoja2.xlsx.axlsx', xlsx:'SeguimProce'}
  end
end


def vhoja3
  @vnpac=params[:param1]
  @vmpac=params[:param2]
  @vpac1=params[:param3]
  @vpac2=params[:param4]
  @vpac3=params[:param5]
  @vpact=params[:param6]
  @vuobac=params[:param7]
  @activities=Phase.order('sele2 DESC')



  respond_to do |format|
    format.html
    format.xls{render template: 'reports/hoja3.xls.erb', xls:'ahoja'}
    format.xlsx{render template: 'reports/hoja3.xlsx.axlsx', xlsx:'ProceAudi'}
  end
end



def vhoja4


  respond_to do |format|
    format.html

    format.xlsx{render template: 'reports/hoja4.xlsx.axlsx', xlsx:'eval'}
  end
end




def vhoja5

  respond_to do |format|
    format.html
    format.xls{render template: 'reports/hoja5.xls.erb', xls:'pacs'}
    format.xlsx{render template: 'reports/hoja5.xlsx.axlsx', xlsx:'pacs'}
  end
end

def vhoja6

  respond_to do |format|
    format.html
    format.xls{render template: 'reports/hoja6.xls.erb', xls:'procesos'}
    format.xlsx{render template: 'reports/hoja6.xlsx.axlsx', xlsx:'procesos'}
  end
end

def vhoja7

  respond_to do |format|
    format.html

    format.xlsx{render template: 'reports/hoja7.xlsx.axlsx', xlsx:'Activos'}
  end
end


def vhoja11
    @iitem=params[:param1]
    @lmes=params[:param2].to_i
    @tit=params[:param3]
    @tip=params[:param4]
  respond_to do |format|
    format.html

    format.xlsx{render template: 'reports/hoja11.xlsx.axlsx', xlsx:'indi1'}
  end
end


end
