ActiveAdmin.register_page "Catalogacion" do

  menu  priority: 20,label: "Catalogación"


  content title: "Indices" do


                   @vaf=current_admin_user.periodo
                   @vaf1=Formula.where(product_id:11,orden:@vaf).select('nombre as dd').first.dd.to_i
                   @vaf2=Formula.where(product_id:11,orden:@vaf).select('descripcion as dd').first.dd







                      panel  "Fichas Aprobadas -"+@vaf2 do







                               pie=Movement.where(estado:3).where('extract(year from fechap) = ?',@vaf1).
                               select(' distinct sheet_id')
                               vpac1=Sheet.where(id:pie,vigencia:1)  #vigencia 1 en proceso 2 activo
                               vpac2=vpac1.count
                               vpac3=vpac1.select('id')

                               bb=["Programadas","Ejecutadas","Hechas en Plazo","Acumuladas %"]
                               cc=["Fichas Aprobadas Programadas","Fichas Aprobadas Ejecutadas",
                                 "Fichas Aprobadas Hechas en Plazo","Fichas Acumuladas Aprobadas Hechas en Plazo"]


                           if vpac2>0 then
                               table_for bb  do

                                 column("Mes")do |aho|
                                    bb[bb.index(aho)]
                                 end






                                    lmes=1
                                    plazo=[]
                                    plazot=[]
                                    aplazo=[]
                                    aejec=[]
                                    aproce1=[]
                                    apru=[]

                                while lmes<13


                                   proce=Movement.where(sheet_id:vpac3,estado:3).where('extract(month from fechap) = ?',lmes)
                                   ejec=Movement.where(estado:1).where('extract(year from fechap) = ?',@vaf1).
                                        where('extract(month from fechap) = ?',lmes) # estado 1 creada 2 revision
                                   proce1=proce.select(:sheet_id).map {|e| e.attributes.values}
                                   ejec1=ejec.select(:sheet_id).map {|e| e.attributes.values}


                                     aproce1=aproce1+proce1         #programa acumulado
                                     aejec=aejec+ejec1              #ejecutados acumulados
                                     apru=proce1+plazo
                                     plazo=apru &  aejec.to_a & proce1.to_a
                                     aplazo=aplazo+ plazo            # acum   aproce1.length*100/aplazo.length.to_i


                                    column ("#{lmes}") do |aho|
                                        case bb.index(aho)
                                          when 0

                                              esta=3
                                              tit=  cc[bb.index(aho)]
                                              le= proce1.length
                                              if le>0 then
                                                  link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                 :param1=> proce1, :param2=> lmes, :param3=> tit.upcase,
                                                 :param4=> 3,:param5=> esta)
                                              else
                                                le
                                              end
                                          when 1

                                                esta=1
                                                tit=  cc[bb.index(aho)]
                                                le= ejec1.length
                                                if le>0 then
                                                    link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                   :param1=> ejec1, :param2=> lmes, :param3=> tit.upcase,
                                                   :param4=> 3,:param5=> esta)
                                                else
                                                  le
                                                end

                                          when 2

                                                esta=1

                                                tit=  cc[bb.index(aho)]
                                                le=plazo.length

                                                if le>0 then
                                                    link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                   :param1=> plazo, :param2=> lmes, :param3=> tit.upcase,
                                                   :param4=> 3,:param5=> esta)
                                                else
                                                  le
                                                end
                                          when 3
                                             if aproce1.length>0 then
                                                le=aplazo.length*100/aproce1.length.to_i
                                             else
                                                le=100
                                             end

                                         end
                                     end
                                lmes=lmes+1
                                end







                                column ("TOTAL") do |aho|
                                  procet=Movement.where(sheet_id:vpac3,estado:3).where('extract(year from fechap) = ?',@vaf1).
                                           select(:sheet_id).map {|e| e.attributes.values}.flatten.compact

                                   case bb.index(aho)
                                      when 0

                                        esta=3
                                        tit=  "TOTAL DE FICHAS APROBADAS"
                                        le=   procet.length

                                            link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                           :param1=> procet, :param2=> 12, :param3=> tit,
                                           :param4=> 4,:param5=> esta)

                                      when 1
                                        esta=1
                                        tit=  "TOTAL DE FICHAS APROBADAS EJECUTADAS"
                                        le=   aejec.length

                                            link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                           :param1=> aejec, :param2=> 12, :param3=> tit,
                                           :param4=> 4,:param5=> esta)



                                      when 2
                                          "-"
                                      when 3
                                          "-"

                                    end
                                 end






                           end#table
                      end #if


         end #panel

##############
panel  "Fichas Actualizadas -"+@vaf2 do


                                  pie=Movement.where(estado:3).where('extract(year from fechap) = ?',@vaf1).
                                      select(' distinct sheet_id')
                                 vpac1=Sheet.where(id:pie,vigencia:2)  #vigencia 1 en proceso 2 activo
                                 vpac2=vpac1.count
                                 vpac3=vpac1.select('id')

                                 bb=["Programadas","Ejecutadas","Hechas en Plazo","Acumuladas %"]
                                 cc=["Fichas Actualizadas Programadas","Fichas Actualizadas Ejecutadas",
                                   "Fichas Actualizadas Hechas en Plazo","Fichas Acumuladas Actualizadas Hechas en Plazo"]


                             if vpac2>0 then
                                 table_for bb  do

                                   column("Mes")do |aho|
                                      bb[bb.index(aho)]
                                   end







                             lmes=1
                             plazo=[]
                             plazot=[]
                             aplazo=[]
                             aejec=[]
                             aproce1=[]
                             apru=[]
                                  while lmes<13



                                     proce=Movement.where(sheet_id:vpac3,estado:3).where('extract(month from fechap) = ?',lmes)
                                     ejec=Movement.where(estado:2).where('extract(year from fechap) = ?',@vaf1).
                                          where('extract(month from fechap) = ?',lmes) # estado 1 creada 2 revision
                                     proce1=proce.select(:sheet_id).map {|e| e.attributes.values}
                                     ejec1=ejec.select(:sheet_id).map {|e| e.attributes.values}

                                    aproce1=aproce1+proce1         #programa acumulado
                                    aejec=aejec+ejec1              #ejecutados acumulados
                                    apru=proce1+plazo
                                    plazo=apru &  aejec.to_a & proce1.to_a
                                    aplazo=aplazo+ plazo            # acum   aproce1.length*100/aplazo.length.to_i




                                     column ("#{lmes}") do |aho|
                                         case bb.index(aho)
                                           when 0

                                               esta=3
                                               tit=  cc[bb.index(aho)]
                                               le= proce1.length
                                               if le>0 then
                                                   link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                  :param1=> proce1, :param2=> lmes, :param3=> tit.upcase,
                                                  :param4=> 3,:param5=> esta)
                                               else
                                                 le
                                               end
                                           when 1

                                                 esta=2
                                                 tit=  cc[bb.index(aho)]
                                                 le= ejec1.length
                                                 if le>0 then
                                                     link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                    :param1=> ejec1, :param2=> lmes, :param3=> tit.upcase,
                                                    :param4=> 3,:param5=> esta)
                                                 else
                                                   le
                                                 end

                                           when 2

                                                 esta=2
                                                 plazot=plazot+plazo
                                                 tit=  cc[bb.index(aho)]
                                                 le=plazo.length

                                                 if le>0 then
                                                     link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                    :param1=> plazo, :param2=> lmes, :param3=> tit.upcase,
                                                    :param4=> 3,:param5=> esta)
                                                 else
                                                   le
                                                 end


                                         when 3
                                              if aproce1.length>0 then
                                                le=aplazo.length*100/aproce1.length.to_i
                                              else
                                                le=100
                                              end
                                          end
                                      end
                                  lmes=lmes+1
                                  end







                                  column ("TOTAL") do |aho|

                                    procet=Movement.where(sheet_id:vpac3,estado:3).where('extract(year from fechap) = ?',@vaf1).
                                    select(:sheet_id).map {|e| e.attributes.values}.flatten.compact

                            case bb.index(aho)
                               when 0

                                 esta=3
                                 tit=  "TOTAL DE FICHAS ACTUALIZADAS"
                                 le=   procet.length

                                     link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                    :param1=> procet, :param2=> 12, :param3=> tit,
                                    :param4=> 4,:param5=> esta)

                               when 1
                                 esta=1
                                 tit=  "TOTAL DE FICHAS ACTUALIZADAS EJECUTADAS"
                                 le=   aejec.length

                                     link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                    :param1=> aejec, :param2=> 12, :param3=> tit,
                                    :param4=> 4,:param5=> esta)



                               when 2
                                   "-"
                               when 3
                                   "-"

                             end
                           end









                             end#table
                        end #if


           end #panel

###########

         panel  "Fichas Certificadas enviadas a Perú Compras -"+@vaf2 do
                        pies=Movement.where(estado:4).where('extract(year from fechap) < ?',@vaf1)
                                         .select(' distinct sheet_id')#programa de envio 4
                        vpac1s=Sheet.where(id:pies)  #vigencia 1 en proceso 2 activo
                        vpac2s=vpac1s.count
                        vpac3s=vpac1s.select('id')
                        vsiadm=Movement.where(sheet_id:vpac3s,estado:5).count
                        vnoadm=Movement.where(sheet_id:vpac3s,estado:6).count


                                          pie=Movement.where(estado:4).where('extract(year from fechap) = ?',@vaf1).
                                                       select(' distinct sheet_id')#programa de envio 4
                                          vpac1=Sheet.where(id:pie)  #vigencia 1 en proceso 2 activo
                                          vpac2=vpac1.count
                                          vpac3=vpac1.select('id')

                                          bb=["Programadas/enviadas","Aprobadas","No Admitidas", "Pendientes"]
                                          cc=["Fichas Programadas/Enviadas","Fichas Aprobadas","Fichas No admitidas","Fichas Pendientes"]



                                          table_for bb  do



                                            column("Mes")do |aho|
                                               bb[bb.index(aho)]
                                            end

                                            column("Anterior")do |aho|
                                            case bb.index(aho)
                                              when 0

                                                    vpac2s

                                              when 1
                                                    vsiadm

                                              when 2
                                                   vnoadm

                                              when 3
                                                 vpac2s-vsiadm-vnoadm

                                             end
                                            end




                                            lmes=1
                                               plazot=[]
                                           while lmes<13


                                              proce=Movement.where(sheet_id:vpac3,estado:4).where('extract(month from fechap) = ?',lmes)
                                              ejec=Movement.where(sheet_id:vpac3,estado:5).
                                                  where('extract(month from fechap) = ?',lmes) # estado 1 creada 2 revision 5 envio 6 no admitidas
                                              ejes=Movement.where(sheet_id:vpac3,estado:6).
                                                    where('extract(month from fechap) = ?',lmes) # estado 1 creada 2 revision 5 envio 6 no admitidas
                                              proce1=proce.select(:sheet_id).map {|e| e.attributes.values}
                                              ejec1=ejec.select(:sheet_id).map {|e| e.attributes.values}
                                              ejes1=ejes.select(:sheet_id).map {|e| e.attributes.values}

                                              plazo=proce1 &  ejec1.to_a


                                              column ("#{lmes}") do |aho|
                                                  case bb.index(aho)
                                                    when 0

                                                        esta=4
                                                        tit=  cc[bb.index(aho)]
                                                        le= proce1.length
                                                        if le>0 then
                                                            link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                           :param1=> proce1, :param2=> lmes, :param3=> tit.upcase,
                                                           :param4=> 3,:param5=> esta)
                                                        else
                                                          le
                                                        end


                                                    when 1

                                                          esta=5
                                                          tit=  cc[bb.index(aho)]
                                                          le= ejec1.length
                                                          if le>0 then
                                                              link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                             :param1=> proce1, :param2=> lmes, :param3=> tit.upcase,
                                                             :param4=> 3,:param5=> esta)
                                                          else
                                                            le
                                                          end


                                                    when 2

                                                         esta=6
                                                         tit=  cc[bb.index(aho)]
                                                         le= ejes1.length
                                                         if le>0 then
                                                             link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                            :param1=> proce1, :param2=> lmes, :param3=> tit.upcase,
                                                            :param4=> 3,:param5=> esta)
                                                         else
                                                           le
                                                         end



                                                    when 3

                                                    proce1.length- ejec1.length-ejes1.length

                                                   end

                                               end
                                           lmes=lmes+1
                                           end


                                           column ("TOTAL") do |aho|
                                             procet=Movement.where(sheet_id:vpac3,estado:4).where('extract(year from fechap) = ?',@vaf1)
                                             eject=Movement.where(sheet_id:vpac3,estado:5).where('extract(year from fechap) = ?',@vaf1)
                                             ejest=Movement.where(sheet_id:vpac3,estado:6).where('extract(year from fechap) = ?',@vaf1)


                                              case bb.index(aho)
                                                 when 0
                                                   procet.count
                                                 when 1
                                                   eject.count
                                                 when 2
                                                   ejest.count
                                                 when 3
                                                  procet.count-eject.count-ejest.count+vpac2s-vsiadm-vnoadm

                                               end
                                            end











                                      end#table
                              

                    end #panel

#################

      end







end
