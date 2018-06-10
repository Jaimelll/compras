ActiveAdmin.register_page "Indices" do

  menu  priority: 14,label: "Indicadores"


  content title: "Indices" do


          @vaf=current_admin_user.periodo

          @vitem=Item.where(ejecucion:4).where("modalidad<3")
          .where(exped2:@vaf).order('periodo,exped,obac')


             case   @vaf
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
         vplazo=[0,0,0,0,0,0,0,0,0]

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
             @proj=Formula.where(product_id:12,cantidad:20).select('orden')
             #*******************************************************************

             @vitem.each do |item|

              @vproceso=[0,0,0,0,0,0,0]

               #empieza el item








     vmincexp=@vitem.where(exped:item.exped).minimum(:dcexp)

     if item.modalidad==1 and item.exped>0 and vmincexp>0 then


          @vproceso[2]=vmincexp
          @vproceso[0]=@vitem.where(exped:item.exped).where('dcexp=? ', @vproceso[2]).select('dobac as dd').first.dd
          @vproceso[1]=@vitem.where(exped:item.exped).where('dcexp=? ', @vproceso[2]).select('dsexp as dd').first.dd
     else

             @vproceso[0]=item.dobac
             @vproceso[1]=item.dsexp
             @vproceso[2]=item.dcexp
    end
             @vproceso[3]=item.ddc
             @vproceso[4]=item.ddem
             @vproceso[5]=item.ddpc
             @vproceso[6]=item.dfc
             @vproceso[7]=item.ddec









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
                        vplazo[6]=Formula.where(product_id:10,orden:6).select('cantidad as dd').first.dd
                    when 2 #internacional
                        vplazo[4]=Formula.where(product_id:10,orden:4).select('numero as dd').first.dd
                        vplazo[6]=Formula.where(product_id:10,orden:6).select('numero as dd').first.dd
                   end







                sconta=0

                while sconta<8  #calculo de los vnproceso
                  if sconta==6 then
                      vss=@vproceso.take(2).compact.reduce :+
                  else
                      vss=@vproceso.take(sconta).compact.reduce :+
                  end





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
                     vmes=  fplazo.month

                     vhab=0        #dias laborables

                        while vddia<fplazo
                                 vddia=vddia+1
                                unless vddia.wday==0 or  vddia.wday==6  or @vferi.include?(vddia)
                                          vhab=vhab+1
                                end   # unless


                                  # no termino en plazo
                               if vhab>vplazo[sconta] and  vplazo[sconta] >0 and vlmes==0 then

                                      vlmes=1
                               end

                        end #de while

       dvss=@vproceso.drop(sconta+1).compact.reduce :+

    # if sconta==6 and vmes==11 and dvss>0 and vhab>0 then
    #  li dvss

    #  ul vhab
    #  ul item.id
  #  end

        if vhab>0 and dvss>0 then

                if  vlmes==0  then


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













             ########################################### plazo rutina






             end #terminia  item
             #termina item***********************************************



               #        @vplaz1= @adem.reduce :+

                    ul do
                      @vaf2=Formula.where(product_id:11,orden:@vaf).select('descripcion as dd').first.dd
                      panel  "Indicadores"+@vaf2 do

                       aa=[mes_ter2,mes_deb2,mes_ter4,mes_deb4,mes_ter5,mes_deb5]
                       bb=["Terminados en plazo GEX","Debieron terminar GEX",
                           "Terminados en plazo DEM","Debieron terminar DEM",
                           "Procesos terminados en plazo","Procesos que debieron Terminar"]
                       cc=[aa[0].flatten.compact.length,aa[1].flatten.compact.length,
                           aa[2].flatten.compact.length,aa[3].flatten.compact.length,
                           aa[4].flatten.compact.length,aa[5].flatten.compact.length]
                       if cc[1]>0 and cc[3]>0 and cc[5]>0  then
                       dd=[(cc[0]*100/cc[1]).to_s+"%","-",
                           (cc[2]*100/cc[3]).to_s+"%","-",
                           (cc[4]*100/cc[5]).to_s+"%","-"]
                       else
                         dd=["-","-","-","-","-","-"]
                       end

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












                               vaf=current_admin_user.periodo

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
                                   vestado=[2,4,9]
                                   presu=Piece.where(phase_id:vite,estado:vestado).sum(:presupuestado)
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
                                presut=Piece.where(phase_id:vitet,estado:vestado).sum(:presupuestado)

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
