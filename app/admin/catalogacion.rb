ActiveAdmin.register_page "Catalogacion" do

  menu  priority: 20,label: "Catalogación"


  content title: "Indices" do


                   @vaf=current_admin_user.periodo



                      @vaf2=Formula.where(product_id:11,orden:@vaf).select('descripcion as dd').first.dd
                      panel  "Fichas Elaboradas -"+@vaf2 do







                               pie=Movement.where(estado:3).select(' distinct sheet_id')
                               vpac1=Sheet.where(grupo:@vaf,id:pie,vigencia:1)  #vigencia 1 en proceso 2 activo
                               vpac2=vpac1.count
                               vpac3=vpac1.select('id')

                               bb=["Programadas","Ejecutadas","Hechas en Plazo"]


                           if vpac2>0 then
                               table_for bb  do

                                 column("Mes")do |aho|
                                    bb[bb.index(aho)]
                                 end






                                 lmes=1
                                    plazot=[]
                                while lmes<13


                                   proce=Movement.where(sheet_id:vpac3,estado:3).where('extract(month from fechap) = ?',lmes)
                                   ejec=Movement.where(sheet_id:vpac3,estado:1).where('extract(month from fechap) = ?',lmes) # estado 1 creada 2 revision
                                   proce1=proce.select(:sheet_id).map {|e| e.attributes.values}
                                   ejec1=ejec.select(:sheet_id).map {|e| e.attributes.values}
                                   plazo=proce1 &  ejec1.to_a


                                    column ("#{lmes}") do |aho|
                                        case bb.index(aho)
                                          when 0
                                              proce.count

                                              tit=  bb[bb.index(aho)]
                                              le= proce1.length
                                              if le>0 then
                                                  link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                 :param1=> proce1, :param2=> lmes, :param3=> tit.upcase, :param4=> 3)
                                              else
                                                le
                                              end
                                          when 1
                                                ejec.count

                                                tit=  bb[bb.index(aho)]
                                                le= ejec1.length
                                                if le>0 then
                                                    link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                   :param1=> ejec1, :param2=> lmes, :param3=> tit.upcase, :param4=> 4)
                                                else
                                                  le
                                                end

                                          when 2
                                                ejec.count
                                                plazot=plazot+plazo
                                                tit=  bb[bb.index(aho)]
                                                le=plazo.length

                                                if le>0 then
                                                    link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                   :param1=> plazo, :param2=> lmes, :param3=> tit.upcase, :param4=> 5)
                                                else
                                                  le
                                                end




                                         end
                                     end
                                lmes=lmes+1
                                end







                                column ("TOTAL") do |aho|
                                  procet=Movement.where(sheet_id:vpac3,estado:3)
                                  eject=Movement.where(sheet_id:vpac3,estado:1) # estado 2 revision


                                   case bb.index(aho)
                                      when 0
                                        procet.count
                                      when 1
                                        eject.count
                                      when 2
                                        plazot.length

                                    end
                                 end






                           end#table
                      end #if


         end #panel



         panel  "Fichas Revisadas -"+@vaf2 do




                                          pie=Movement.where(estado:3).select(' distinct sheet_id')
                                          vpac1=Sheet.where(grupo:@vaf,id:pie,vigencia:2)  #vigencia 1 en proceso 2 activo
                                          vpac2=vpac1.count
                                          vpac3=vpac1.select('id')

                                          bb=["Programadas","Ejecutadas","Hechas en Plazo"]


                                      if vpac2>0 then
                                          table_for bb  do

                                            column("Mes")do |aho|
                                               bb[bb.index(aho)]
                                            end






                                            lmes=1
                                               plazot=[]
                                           while lmes<13


                                              proce=Movement.where(sheet_id:vpac3,estado:3).where('extract(month from fechap) = ?',lmes)
                                              ejec=Movement.where(sheet_id:vpac3,estado:2).where('extract(month from fechap) = ?',lmes) # estado 1 creada 2 revision
                                              proce1=proce.select(:sheet_id).map {|e| e.attributes.values}
                                              ejec1=ejec.select(:sheet_id).map {|e| e.attributes.values}
                                              plazo=proce1 &  ejec1.to_a


                                               column ("#{lmes}") do |aho|
                                                   case bb.index(aho)
                                                     when 0
                                                         proce.count

                                                         tit=  bb[bb.index(aho)]
                                                         le= proce1.length
                                                         if le>0 then
                                                             link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                            :param1=> proce1, :param2=> lmes, :param3=> tit.upcase, :param4=> 3)
                                                         else
                                                           le
                                                         end
                                                     when 1
                                                           ejec.count

                                                           tit=  bb[bb.index(aho)]
                                                           le= ejec1.length
                                                           if le>0 then
                                                               link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                              :param1=> ejec1, :param2=> lmes, :param3=> tit.upcase, :param4=> 4)
                                                           else
                                                             le
                                                           end

                                                     when 2
                                                           ejec.count
                                                           plazot=plazot+plazo
                                                           tit=  bb[bb.index(aho)]
                                                           le=plazo.length

                                                           if le>0 then
                                                               link_to "#{le}", reports_vhoja11_path(format:  "xlsx",
                                                              :param1=> plazo, :param2=> lmes, :param3=> tit.upcase, :param4=> 5)
                                                           else
                                                             le
                                                           end




                                                    end
                                                end
                                           lmes=lmes+1
                                           end







                                           column ("TOTAL") do |aho|
                                             procet=Movement.where(sheet_id:vpac3,estado:3)
                                             eject=Movement.where(sheet_id:vpac3,estado:2) # estado 2 revision


                                              case bb.index(aho)
                                                 when 0
                                                   procet.count
                                                 when 1
                                                   eject.count
                                                 when 2
                                                   plazot.length

                                               end
                                            end






                                      end#table
                                 end #if


                    end #panel



      end







end
