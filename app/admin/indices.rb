ActiveAdmin.register_page "Indices" do

  menu  priority: 14,label: "Indicadores"


  content title: "Indices" do

         @var=Formula.where(product_id:15,cantidad:1).
                              select('orden as dd').first.dd
         @titulo=Formula.where(product_id:15,cantidad:1).
                              select('nombre as dd').first.dd
          @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd

          @vitem=Item.where(ejecucion:4).where("modalidad<3")
          .where(exped2:@vaf).order('periodo,exped,obac')
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





         #################var plazo
         #mes con pacs debieron gex
         mes_deb2=[]
         #mes con pacs terminados gex
         mes_ter2=[]
         #mes con pacs debieron dem
         mes_deb4=[]
         #mes con pacs terminados dem
         mes_ter4=[]
         #mes con pacs debieron dpc
         mes_deb5=[]
         #mes con pacs terminados dpc
         mes_ter5=[]


         #demoras netas:
         vnproceso=[0,0,0,0,0,0]

         #plazos teoricos
         vplazo=[0,0,0,0,0,0]

         #####################################################para plazo

         vcontmes=12

          while  vcontmes>0
         mes_deb2[vcontmes]=[]
         mes_ter2[vcontmes]=[]
         mes_deb4[vcontmes]=[]
         mes_ter4[vcontmes]=[]
         mes_deb5[vcontmes]=[]
         mes_ter5[vcontmes]=[]
         vcontmes=vcontmes-1
         end


         ########################################################

         ###################################
             #feriados


             @vferi=Formula.where(product_id:27,cantidad:1).select('nombre')

             #*******************************************************************

             @vitem.each do |item|


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
                     vplazo[6]=Formula.where(product_id:10,orden:5).select(' cantidad as dd').first.dd
                    when 2 #encargo
                      vplazo[2]=Formula.where(product_id:10,orden:2).select(' numero as dd').first.dd
                      vplazo[6]=Formula.where(product_id:10,orden:5).select(' numero as dd').first.dd
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

                while sconta<7  #calculo de los vnproceso
                  if sconta==6 then
                      vss=@vproceso.take(2).compact.reduce :+
                  else
                      vss=@vproceso.take(sconta).compact.reduce :+
                  end

                      idss=@vproceso.push(0)

                      dvss=idss.drop(sconta).compact.reduce :+

                      unless vss
                        vss=0
                      end
                    iplazo  = @vinicio+vss

                       if sconta==6 then
                         fplazo=iplazo+ @vproceso[2]+ @vproceso[3]+ @vproceso[4]+ @vproceso[5]+ @vproceso[6]
                       else
                        fplazo=iplazo+ @vproceso[sconta]
                       end

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
                        when 6
                            mes_ter5[vmes].push(item.id)
                    end   #case
                end #if


                case sconta
                        when 2
                            mes_deb2[vmes].push(item.id)
                        when 4
                          mes_deb4[vmes].push(item.id)
                        when 6
                          mes_deb5[vmes].push(item.id)
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



               #        @vplaz1= @adem.reduce :+

                    ul do
                      @vaf=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
                      panel  "Indicadores"+@vaf do

                       aa=[mes_ter2,mes_deb2,mes_ter4,mes_deb4,mes_ter5,mes_deb5]
                       bb=["Terminados en plazo GEX","Debieron terminar GEX",
                           "Terminados en plazo DEM","Debieron terminar DEM",
                           "Procesos terminados en plazo","Procesos que debieron Terminar"]
                       cc=[aa[0].flatten.compact.length,aa[1].flatten.compact.length,
                           aa[2].flatten.compact.length,aa[3].flatten.compact.length,
                           aa[4].flatten.compact.length,aa[5].flatten.compact.length]
                      # if cc[1]>0 and cc[3]>0  then
                       dd=[(cc[0]*100/cc[1]).to_s+"%","-",
                           (cc[2]*100/cc[3]).to_s+"%","-",
                           (cc[4]*100/cc[5]).to_s+"%","-"]
                    #   else
                    #     dd=["-","-","-","-","-","-"]
                    #   end

                      table_for aa  do
                        column("Mes")do |ter|
                         bb[aa.index(ter)]
                        end

                         lmes=1


                        while lmes<13
                            column ("#{lmes}") do |ter|
                            tit=  bb[aa.index(ter)]
                            le=ter[lmes].length

                            if le>0 then
                            link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                            :param1=> ter[lmes], :param2=> lmes, :param3=> tit.upcase, :param4=> 1)
                          else
                            le
                          end #de if


                        end #de colum
                        lmes=lmes+1
                      end #de while

                                           column ("TOTAL") do |ter|

                                           ter.flatten.compact.length



                                       end

                                         column("Porcentaje")do |ter|
                                          dd[aa.index(ter)]
                                         end

                      end#table












                               vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd

                               pie=Piece.where("adjudicado IS NOT NULL").select(' distinct phase_id')

                               vpac3=Phase.where(periodo:vaf,id:pie).select('id')

                               bb=["Procesos adjudicados","Presupuestado",
                                 "Adjudicado","Ahorro"]



                               table_for bb  do

                                 column("Mes")do |aho|
                                    bb[bb.index(aho)]
                                 end


                                 lmes=1
                                while lmes<13

                                   proce=Phase.where(id:vpac3).where('extract(month from pp) = ?',lmes)
                                   vite1=Phase.where(id:vpac3).where('extract(month from pp) = ?',
                                   lmes).select(:id).map {|e| e.attributes.values}

                                   vite=Phase.where(id:vpac3).where('extract(month from pp) = ?',
                                   lmes).select("id")

                                   presu=Piece.where(phase_id:vite,estado:4).sum(:presupuestado)
                                    column ("#{lmes}") do |aho|
                                        case bb.index(aho)
                                          when 0
                                              proce.count

                                              tit=  bb[bb.index(aho)]
                                              le= proce.count

                                              if le>0 then
                                              link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                              :param1=> vite1, :param2=> lmes, :param3=> tit.upcase, :param4=> 2)
                                              else
                                              le
                                              end #de if









                                           when 1

                                              number_with_delimiter( presu.to_i, delimiter: ",")
                                           when 2
                                              number_with_delimiter( proce.sum("sele2").to_i, delimiter: ",") #adjudicado
                                           when 3
                                             number_with_delimiter( (presu-proce.sum("sele2")).to_i, delimiter: ",")
                                         end
                                     end
                                lmes=lmes+1
                                end




                                procet=Phase.where(id:vpac3)
                                vitet=Phase.where(id:vpac3).select("id")
                                presut=Piece.where(phase_id:vitet,estado:4).sum(:presupuestado)

                                column ("TOTAL") do |aho|

                                   case bb.index(aho)
                                      when 0
                                         procet.count
                                      when 1

                                        number_with_delimiter( presut.to_i, delimiter: ",")
                                      when 2
                                        number_with_delimiter( procet.sum("sele2").to_i, delimiter: ",") #adjudicado
                                      when 3
                                       number_with_delimiter( (presut-procet.sum("sele2")).to_i, delimiter: ",")
                                    end
                                 end




                                 column ("Porcentaje") do |aho|

                                    case bb.index(aho)
                                       when 3
                                         if presut>0 then
                                              porcc=(presut-procet.sum("sele2"))*100/presut
                                              number_with_delimiter( porcc.to_i, delimiter: ",").to_s+"%"
                                         else
                                           0
                                         end
                                      else
                                        "-"
                                     end
                                  end


                           end#table



         end #panel














            end


















  panel  "Desviaciones PAC y Procesos" do
    table_for Formula.where(product_id:11).where(cantidad:1)  do


         column(" Devoluciones" ) do |formula|

           link_to "PACs", reports_vhoja5_path(format:  "xlsx")
         end

         column(" Devoluciones" ) do |formula|

           link_to "Procesos", reports_vhoja6_path(format:  "xlsx")
         end





  end
end


end











end
