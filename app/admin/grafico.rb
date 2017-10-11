
ActiveAdmin.register_page "grafico" do

  menu  priority: 2,label: "Grafico PAC"


  action_item :only=> :index do
      link_to 'Encargo', encargo_admin_product_formula_path(1, :@num), method: :put

  end
  #action_item :only=> :index do
  #    link_to 'Encargo 2 de 2', mgp_admin_formula_path( :@num), method: :put
  #end
  action_item :only=> :index do
      link_to 'Corporativos', corporativa_admin_product_formula_path( 1,:@num), method: :put
  end



  action_item :only=> :index do
      link_to 'Autorizaciones', autorizado_admin_product_formula_path( 1,:@num), method: :put
  end

  action_item :only=> :index do
      link_to 'Exclusiones', excluido_admin_product_formula_path(1, :@num), method: :put
  end


  action_item :only=> :index do
     link_to 'GEX', gex_admin_product_formula_path( 1,:@num), method: :put
  end

  action_item :only=> :index do
     link_to 'DEM', dem_admin_product_formula_path( 1,:@num), method: :put
  end

  action_item :only=> :index do
     link_to 'DPC', dpc_admin_product_formula_path( 1,:@num), method: :put
  end

  action_item :only=> :index do
     link_to 'DEC', dec_admin_product_formula_path(1, :@num), method: :put
  end

  action_item :only=> :index do
      link_to 'Indicadores', indica_admin_product_formula_path( 1,:@num), method: :put
  end



  content title: "Grafico" do

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

     @var=Formula.where(product_id:15,cantidad:1).
                          select('orden as dd').first.dd
     @titulo=Formula.where(product_id:15,cantidad:1).
                          select('nombre as dd').first.dd
      @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd






  case @var
   when 1
     #encargo
     @vitem=Item.where(ejecucion:4,modalidad:2)
     .where(exped2:@vaf).order('periodo,obac ASC,pac')
     @iproce=100

   when 2
   #corporativa
     @vitem=Item.where(ejecucion:4,modalidad:1)
     .where(exped2:@vaf).order('periodo,exped,obac')
    @iproce=100
  when 3
  # autorizados
     @vitem=Item.where(ejecucion:4,modalidad:3)
     .where(exped2:@vaf).order('obac ASC,pac')
     @iproce=100
  when 4
  #DEC proceso 6
  @vitem=Item.where(ejecucion:4).where("modalidad<3")
  .where(exped2:@vaf).order('periodo,exped,obac')
   @iproce=7

  when 5
  #excluidos
    @vitem=Item.where(ejecucion:4,modalidad:4)
    .where(exped2:@vaf).order('obac ASC,pac')
    @iproce=100

  when 6
  #dpc
  @vitem=Item.where(ejecucion:4).where("modalidad<3")
  .where(exped2:@vaf).order('periodo,exped,obac')
  @iproce=5

  when 7
  #dem
  @vitem=Item.where(ejecucion:4).where("modalidad<3")
  .where(exped2:@vaf).order('periodo,exped,obac')
  @iproce=4

  when 8
  #gex
  @vitem=Item.where(ejecucion:4).where("modalidad<3")
  .where(exped2:@vaf).order('periodo,exped,obac')
  @iproce=2


 when 11
  #indicadores
    @vitem=Item.where(ejecucion:4).where("modalidad<3")
    .where(exped2:@vaf).order('periodo,exped,obac')
   @iproce=100
end


    @vitem=@vitem.where(obac: @vuobac)



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





#################var plazo
#mes con pacs debieron
mes_deb2=[]



#mes con pacs terminados
mes_ter2=[]

#mes con pacs debieron
mes_deb4=[]



#mes con pacs terminados
mes_ter4=[]


#demoras netas:
vnproceso=[0,0,0,0,0]

#plazos teoricos
vplazo=[0,0,0,0,0]

#####################################################para plazo

vcontmes=12

 while  vcontmes>0
mes_deb2[vcontmes]=[]
mes_ter2[vcontmes]=[]
mes_deb4[vcontmes]=[]
mes_ter4[vcontmes]=[]
vcontmes=vcontmes-1
end

    prueba=[]
########################################################

###################################
    #feriados


    @vferi=Formula.where(product_id:27,cantidad:1).select('nombre')

    #*******************************************************************

    @vitem.each do |item|

      #prueba conta

      #empieza el item

    @vfec1=Time.now

    @vproceso=[0,0,0,0,0,0,0,0]

    @uproc=8
    @corta=0

    @nconta1=0


      #@nconta numero de actividades

    #comienza case
    case   @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
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
           @vfin=Time.now
            @vrang=15
            @vtitun=" AF-2017"


      end #termina case


      @nconta=Detail.where(item_id:item.id).
         where("details.pfecha>=? and details.pfecha<=? ", @vinicio,@vfin ).count
       @deta2=Detail.where(item_id:item.id).
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
      .where("activities.pfecha>=? and activities.pfecha<=?", @vinicio,@vfin )
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









    @vversion=@vproceso[0]
       @vobac=@vproceso[1]
        @vpec=@vproceso[2]
        @vdac=@vproceso[3]
        @vdem=@vproceso[4]
        @vdpc=@vproceso[5]
        @vdec=@vproceso[6]
        @veobac=@vproceso[7]












    if item.obac and item.obac>0 then
        @n1=Formula.where(product_id:1, orden:item.obac).
           select('nombre as dd').first.dd

    else
        @n1="s/d"
    end

    #@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
    #@alabels2.push(item.descripcion.first(10))
    @desc=item.descripcion.underscore

    if @desc[0,3]=='adq' then
        @desc=@desc[15,54]
    else
     @desc=@desc

    end

    if item.exped and item.exped>0 then

    @lab1=Formula.where(product_id:16,orden:item.exped).
             select('nombre as dd').first.dd+"-"+
              Formula.where(product_id:16,orden:item.exped).
                        select('descripcion as dd').first.dd.underscore.truncate(30)+
                      "-"+item.pac+"-"+@n1
    else
    #@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
    @lab1=@desc.capitalize.truncate(40)+"-"+item.pac+"-"+@n1

    end




       @alabels.push(@lab1)
       @aversion.push(@vversion)
       @aobac.push(@vobac)
       @apec.push(@vpec)
       @adac.push(@vdac)
       @adem.push(@vdem)
       @adpc.push(@vdpc)
       @adec.push(@vdec)
       @aeobac.push(@veobac)



       #calculo de plazo de pec
          case  item.modalidad
          when 1 #corporativa
            vplazo[2]=Formula.where(product_id:10,orden:2).select(' cantidad as dd').first.dd
           when 2 #encargo
             vplazo[2]=Formula.where(product_id:10,orden:2).select(' numero as dd').first.dd
          end




       #calculo de plazo de dem
         #mercado
            case  item.tipo
          when 1 #nacional
               vplazo[4]=Formula.where(product_id:10,orden:4).select('cantidad as dd').first.dd
           when 2 #internacional
               vplazo[4]=Formula.where(product_id:10,orden:4).select('numero as dd').first.dd
          end







       sconta=0

       while sconta<5  #calculo de los vnproceso
             prueba.push(sconta)
             vss=@vproceso.take(sconta).compact.reduce :+

             idss=@vproceso.push(0)
             dvss=idss.drop(sconta).compact.reduce :+

             unless vss
               vss=0
             end
           iplazo  = @vinicio+vss

            fplazo=iplazo+ @vproceso[sconta]
            vddia=iplazo
           vlmes=0
            vmes=  vddia.month

            vhab=0        #dias laborables

               while vddia<fplazo
                        vddia=vddia+1
                       unless vddia.wday==0 or  vddia.wday==6  or @vferi.include?(vddia)
                                 vhab=vhab+1
                       end   # unless



                      if vhab>vplazo[sconta] and  vplazo[sconta] >0 and vlmes==0 then
                             vmes=  vddia.month
                             vlmes=1
                      end

               end #de while


if vhab>0 and dvss>0 then
       if  vlmes==0  then
              vmes=  vddia.month

          case sconta
               when 2
                   mes_ter2[vmes].push(item.id)
               when 4
                   mes_ter4[vmes].push(item.id)
           end   #case
       end #if


       case sconta
               when 2
                   mes_deb2[vmes].push(item.id)
               when 4
                 mes_deb4[vmes].push(item.id)
           end #case

end
       #demoras netas:
       vnproceso[sconta]=vhab




       sconta=sconta+1

       end #de while1
       ###########################









    end   # log



    ########################################### plazo rutina






    end #terminia  item
    #termina item***********************************************
   unless  @var==11



if @vtitun then
@vtit=@titulo+'-'+@vtitun
else
@vtit=@titulo
end
    columns do
           column do


#@alabels=@alabels.map { |i| " '" + i + "'" }.join(',')
#@alabels=@alabels.join(",")

               render :partial => "grafico",
               :locals => { :param1 => @alabels,
                            :param2 => @aversion,
                            :param3 => @aobac,
                            :param4 => @apec,
                            :param5 => @adac,
                            :param6 => @adem,
                            :param7 => @adpc,
                            :param8 => @adec,
                            :param9 => @aeobac,
                            :param20 =>  @vtit}


           end
     end


    else


      #        @vplaz1= @adem.reduce :+

           ul do
             @vaf=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
             panel  "Indicadores"+@vaf do

             table_for "B"  do
               column("Mes")do |ter|
               "Term. plazo DEM"
               end

                lmes=1
               while lmes<13 # and mes_deb4[lmes].length>0
                   column ("#{lmes}") do |ter|
                   mes_ter4[lmes].length


                   link_to "#{mes_ter4[lmes].length}", reports_vhoja11_path(format:  "xlsx",
                   :param1=> mes_ter4[lmes], :param2=> lmes)



               end
               lmes=lmes+1
               end
             end#table


             table_for "B"  do
               column("Procesos DEM")
                lmes=1
               while lmes<13 and mes_deb4[lmes].length>0
               column("#{mes_deb4[lmes].length}")
               lmes=lmes+1
               end
             end#table
           end #panel













        end


   end









  end
end
