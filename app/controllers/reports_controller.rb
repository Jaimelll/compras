class ReportsController < ApplicationController

def diasp(var)
  ######ver funcion




   @vitem=Item.where(ejecucion:4).where("modalidad<3")
   .where(exped2:var).order('periodo,exped,obac')
  @iproce=100


      @adata=[]
      @alabels=[]
      @blabels=[]




      @aversion=[]
      @aobac=[]
      @apec=[]
      @adac=[]
      @adem=[]
      @adpc=[]
      @adec=[]
      @aeobac=[]
      @conta=0

               @vferi=Formula.where(product_id:27,cantidad:1).select('nombre')
               @proj=Formula.where(product_id:12,cantidad:20).select('orden')
  @vitem=Item.where(ejecucion:4).where("modalidad<3")
  .where(exped2:var).order('periodo,exped,obac')
               @vitem.each do |item|


                 #empieza el item

               @vfec1=Time.now

               @vproceso=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

               @uproc=8
               @corta=0

               @nconta1=0


                 #@nconta numero de actividades

               #comienza case
               case var
                  when 1
                    @vinicio = Date.parse('2015/01/01')
                    @dfin=365
                    @vfin=Date.parse('2015/12/31')
                    @vrang=30
                    @vtitun=" AF-2015"


                   when 2
                     @vinicio = Date.parse('2016/01/01')
                     @dfin=368
                     @vfin=Date.parse('2016/12/31')
                      @vrang=30
                      @vtitun="AF-2016"



                    when 3
                      @vinicio = Date.parse('2017/01/01')
                      @dfin=(Time.now-@vinicio.to_time).to_i/86400
                      @vfin=Date.parse('2017/12/31')
                       @vrang=15
                       @vtitun=" AF-2017"

                     when 4
                       @vinicio = Date.parse('2018/01/01')
                       @dfin=(Time.now-@vinicio.to_time).to_i/86400
                       @vfin=Time.now
                        @vrang=15
                        @vtitun=" AF-2018"

                 end #termina case


                 @nconta=Detail.where(item_id:item.id).
                    where("details.pfecha>=? and details.pfecha<=? ", @vinicio,@vfin ).count
                  @deta2=Detail.where(item_id:item.id).where.not(actividad:@proj).
                         where("details.pfecha>=? and details.pfecha<=? ", @vinicio,@vfin ).
                        order('details.pfecha DESC,details.id DESC')


               @deta1=@deta2.where(item_id:item.id)

                 @vlog=false

               if @deta1.count==0 then

                 object = Detail.new(:actividad => 36, :pfecha=> @vinicio+1,
                  :item_id => item.id,:admin_user_id => 2,:created_at =>@vinicio,
                  :updated_at => @vinicio,:tipo =>'automatico')
                 object.save


               end

               @deta1.each do |detail|

                 #empieza detail
               #end
               #termina cas
                 @nconta1=@nconta1+1


               if detail.pfecha and detail.actividad  then
               @vproc=Formula.where(product_id:12,orden:detail.actividad).
                                    select('cantidad as dd').first.dd
               #proceso
               @vprord=detail.actividad
               #actividad
               @nconta2=0
               @ulvproc2=0

               @n2fecha=@vinicio

               #inicio de phase if 280 al 392*************************************************************
               if Phase.where(expediente:item.exped,convocatoria:1).count>0 and item.exped>0 then
                 @phase1=Phase.where(convocatoria:1).find_by(expediente:item.exped).activities
                 .where.not(actividad:@proj).where("activities.pfecha>=? and activities.pfecha<=?", @vinicio,@vfin )
                  .order('activities.pfecha DESC,activities.id DESC')


               #inicia cadena

               @phase1.each do |phase|
                 #cambio
                 @vproc2=Formula.where(product_id:12,orden:phase.actividad).
                                      select('cantidad as dd').first.dd

               if phase.pfecha>=detail.pfecha and @vfec1>phase.pfecha then


               #proceso
               @vprord2=phase.actividad
               #actividad

               @vdetfec2=phase.pfecha


                 @nconta2=@nconta2+1






               if  @nconta2==1 and @nconta1==1  then
                     @vlog=false
                     @ulvproc2=1  #guarda el primer proceso
                     @n2fecha=phase.pfecha #guarda la primera fecha
           ###################repetir case de iproce


                  case   @iproce
                    when 100
                        @vlog=true
                   when 2
                     if  @vproc2<=2 then
                         @vlog=true

                     end
                   when 4

                      if  @vproc2==4 then
                       @vlog=true
                      end

                 when 5

                    if  @vproc2==5 then
                     @vlog=true
                    end

               when 7

                  if  @vproc2==6 or  @vproc2==7 then
                   @vlog=true
                  end
               end



           ######################################

               end


               if @vlog  then
               # empieza @vlog


                  unless @vprord2==200 or @vprord2==300 or ( @vprord2==8 and item.modalidad==3)
                    if  @uproc>=@vproc2 then

                           @vproceso[@vproc2]=@vproceso[@vproc2]+
                           ( @vfec1-@vdetfec2.to_time).to_i/86400



                           @uproc=@vproc2
                     else
                           @vproceso[@uproc]=@vproceso[@uproc]+
                           ( @vfec1-@vdetfec2.to_time).to_i/86400


                      end
                   else
                      @corta=( @vfec1-@vdetfec2.to_time).to_i/86400


                   end #de unless




                 @vfec1=@vdetfec2.to_time

               end # termina @vlog


               end #de if de phase mayor

               end  #terminar ecah de phase

               end #terminar el if de  la cadena phase





               # fin phase del 280 al 392************************************************************
               if  @nconta1==1 and   @vlog==false then


           ###############
            if  @ulvproc2==0 and detail.pfecha> @n2fecha then
              case   @iproce
                when 100
                    @vlog=true
               when 2
                 if  @vproc<=2 then
                     @vlog=true

                 end
               when 4

                  if  @vproc==4 then
                   @vlog=true
                  end

             when 5

                if  @vproc==5 then
                 @vlog=true
                end

           when 7

              if  @vproc==6 or  @vproc==7 then
               @vlog=true
              end
           end


           end
           ###################


               end

               if @vlog  then
               # empieza @vlog


                  unless @vprord==200 or @vprord==300 or ( @vprord==8 and item.modalidad==3)
                    if  @uproc>=@vproc then

                           @vproceso[@vproc]=@vproceso[@vproc]+
                           ( @vfec1-detail.pfecha.to_time).to_i/86400

                         #  if @nconta1==1 then
                         #     @vproceso[@vproc]=@vproceso[@vproc]+2
                         #  end
                           @uproc=@vproc
                     else
                           @vproceso[@uproc]=@vproceso[@uproc]+
                           ( @vfec1-detail.pfecha.to_time).to_i/86400


                      end
                   else
                      @corta=( @vfec1-detail.pfecha.to_time).to_i/86400


                   end #de unless


                   if @nconta1==@nconta then
                     if @vprord==36 then
                          @vproceso[0]= ( detail.pfecha.to_time-
                          @vinicio.to_time).to_i/86400
                      end

                    @vproceso[@vproc]=@vproceso[@vproc]+
                    ( detail.pfecha.to_time-@vinicio.to_time).to_i/86400-@vproceso[0]



                   end  #if  @nconta1


                 @vfec1=detail.pfecha.to_time

               end # termina @vlog











               end #termina actividad


               end #termina detail??






               # empieza @vlog
               if @vlog then

   Item.where(id:item.id).update_all( dobac: @vproceso[0], dsexp: @vproceso[1], dcexp: @vproceso[2],
    ddc: @vproceso[3],ddem: @vproceso[4],ddpc: @vproceso[5],dfc: @vproceso[6],ddec: @vproceso[7])

  ######ver funcion
  end #de item
end #de item
end #de funcion






def comment
  case current_admin_user.categoria # a_variable is the variable we want to compare
#when 21
#    @vuobac=[1]
  when 22
    @vuobac=[2]
  when 23
    @vuobac=[3]
  else
    @vuobac=[1,2,3,4,5,6]
  end



  @vaf=current_admin_user.periodo
  @tit1=params[:param3].to_s


  @vopc=params[:param4].to_i

  case @vopc
when 1
  @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:2,lista:params[:param2])
  .where(exped2:@vaf).where(obac: @vuobac).order('tipo,certificado DESC')

when 2
   @lista=Formula.where(product_id:3,orden:params[:param2]).select('descripcion as dd').first.dd
  @items=Item.where(ejecucion:4,modalidad:1,lista:params[:param2])
  .where(exped2:@vaf).where(obac: @vuobac).order('exped,certificado DESC')

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
   @items=Item.where(ejecucion:4,modalidad:2,tipo:params[:param2])
   .where(exped2:@vaf).order('tipo,modalidad,certificado DESC,obac,pac').where(obac: @vuobac)

 when 7
   @lista=" "
   @items=Item.where(ejecucion:4,modalidad:1,tipo:params[:param2]).order('obac,pac')
   .where(exped2:@vaf).order('tipo,modalidad,exped,certificado DESC,obac,pac').where(obac: @vuobac)

 when 8
   @lista=" "
   @items= Item.where(ejecucion:4,tipo:params[:param2]).where("modalidad<3")
           .where(exped2:@vaf).order('tipo,modalidad,exped,certificado DESC,obac,pac').where(obac: @vuobac)
         when 9
           @lista=" "
           @items=Item.where(ejecucion:4,modalidad:2,fuente:params[:param2])
           .where(exped2:@vaf).order('certificado DESC,obac,pac').where(obac: @vuobac)

         when 10
           @lista=" "
           @items=Item.where(ejecucion:4,modalidad:1,fuente:params[:param2])
           .where(exped2:@vaf).order('exped,certificado DESC,obac,pac').where(obac: @vuobac)

         when 11
           @lista=" "
           @items= Item.where(ejecucion:4,fuente:params[:param2]).where("modalidad<3")
                   .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)
     when 12
         @lista=" "
         @items= Item.where(ejecucion:4,fuente:params[:param2]).where("modalidad<3")
             .where(exped2:@vaf).order('tipo,modalidad,exped,obac,pac').where(obac: @vuobac)

# en totales
     when 13
             @lista=" "
              @items=Item.where(ejecucion:4,modalidad:2).order('tipo,certificado DESC')
             .where(exped2:@vaf).where(obac: @vuobac)
     when 14
                   @lista=" "
                    @items=Item.where(ejecucion:4,modalidad:1).order('tipo,certificado DESC')
                   .where(exped2:@vaf).where(obac: @vuobac)

     when 15
                  @lista=" "
                   @items=Item.where(ejecucion:4).where("modalidad<3")
                           .where(exped2:@vaf).where(obac: @vuobac).order('tipo,modalidad,certificado DESC')
  end



respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte1.pdf.erb', pdf:'detalle'}
end
end



def comment2
  @vaf=current_admin_user.periodo
  @vaf1=Formula.where(product_id:11,orden:@vaf).select('nombre as dd').first.dd
  @tit1=params[:param3].to_s


  @vopc=params[:param4].to_i


  case @vopc
  when 4
       @lista=@vaf1
       @items= Item.where(ejecucion:4,exped2:params[:param2])
           .where("modalidad<3").order('obac,certificado DESC')
  when 5
       @lista=@vaf1
       @items= Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)")
       .where(exped2:params[:param2]).order('obac,certificado DESC')
  when 6
       @vuobac=params[:param2]
       @lista=  @vaf1
       @items=  Item.where(ejecucion:4,modalidad:3,exped2:@vaf,obac:@vuobac).
       order('obac,certificado DESC')

  end



respond_to do |format|

format.html
format.json
format.pdf{render template: 'reports/reporte2.pdf.erb', pdf:'detalle'}
end
end




def comment3
  #autorizados con rj
  @vaf=current_admin_user.periodo
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
    @vaf=current_admin_user.periodo
    @vaf1=Formula.where(product_id:11,orden:@vaf).select('nombre as dd').first.dd
    @vper=  @vaf1

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

      @vaf=current_admin_user.periodo
      @vaf1=Formula.where(product_id:11,orden:@vaf).select('nombre as dd').first.dd
      @vper=  @vaf1

    @vdetalle= Element.where(actividad: Formula
    .where(product_id:19,cantidad:params[:param3]).select('orden'))
    .order('pfecha')


      @items=Contract.where(id:@vpacv).order('obac,numero')

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
  @vaf=current_admin_user.periodo
  @vaf1=Formula.where(product_id:11,orden:@vaf).select('nombre as dd').first.dd
  @vper=  @vaf1

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
  @vpac6=params[:param8]
  @vpac7=params[:param9]
  @vuobac=params[:param10]

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
  @vitpiece=params[:param1]
  @nni=params[:param2]#pacs


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

@vuobac=params[:param1]

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
    @esta=params[:param5].to_i
  respond_to do |format|
    format.html

    format.xlsx{render template: 'reports/hoja11.xlsx.axlsx', xlsx:'indi1'}
  end
end

def vhoja20
  @vaf=current_admin_user.periodo
    diasp(@vaf)

    @vuobac=params[:param7]
    @artic=Article.where()
    @items=Item.where(obac:@vuobac,ejecucion:4,exped2:@vaf).where('modalidad<3')
    nitem=@items.select('id')
    @proce=Phase.where(periodo:  @vaf)
    @artic=Article.where(item_id:nitem)
    respond_to do |format|
      format.html

      format.xlsx{render template: 'reports/hoja20.xlsx.axlsx', xlsx:'DiasPac'}
    end
  end

def vhoja21
#  @vnpac=params[:param1]
#  @vmpac=params[:param2]
  @vpac1=params[:param3]
  @vpac2=params[:param8]
  @vpac3=params[:param5]
  @vpact=params[:param6]
  @vuobac=params[:param7]
  @vpac4=params[:param4]
  @vpac5=params[:param17]

  @activities=Phase.order('pp ASC')






#  @vnpac0=params[:param11]
#  @vmpac0=params[:param12]
  @vpac10=params[:param13]
  @vpac20=params[:param14]
  @vpac30=params[:param15]
  @vpac40=params[:param16]
  @vpac50=params[:param18]


  @items=Item.where(obac:@vuobac).order('tipo,modalidad,exped,certificado DESC')
  respond_to do |format|
    format.html

    format.xlsx{render template: 'reports/hoja21.xlsx.axlsx', xlsx:'CuadroPac'}
  end
end


def vhoja22

  @vpac3=params[:param5]
  @vpac4=params[:param6]
  @vuobac=params[:param7]

  @activities=Phase.order('pp ASC')



  respond_to do |format|
    format.html
    format.xlsx{render template: 'reports/hoja22.xlsx.axlsx', xlsx:'Adjudicados'}
  end
end





end
