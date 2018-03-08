ActiveAdmin.register_page "Catalogacion" do

  menu  priority: 20,label: "Catalogación"


  content title: "Indices" do


                   @vaf=current_admin_user.periodo

                    ul do
                      @vaf2=Formula.where(product_id:11,orden:@vaf).select('descripcion as dd').first.dd
                      panel  "Indicadores"+@vaf2 do







                               pie=Movement.where(estado:3).select(' distinct sheet_id')

                               vpac3=Sheet.where(grupo:@vaf,id:pie).select('id')

                               bb=["Fichas Programadas"]



                               table_for bb  do

                                 column("Mes")do |aho|
                                    bb[bb.index(aho)]
                                 end






                                 lmes=1
                                while lmes<13


                                   proce=Movement.where(sheet_id:vpac3,estado:3).where('extract(month from fechap) = ?',lmes)

                                    column ("#{lmes}") do |aho|
                                        case bb.index(aho)
                                          when 0
                                              proce.count

                                              tit=  bb[bb.index(aho)]
                                              le= proce.count





                                         end
                                     end
                                lmes=lmes+1
                                end







                                column ("TOTAL") do |aho|

                                   case bb.index(aho)
                                      when 0
                                        Movement.where(sheet_id:vpac3,estado:3).count

                                    end
                                 end






                           end#table



         end #panel

      end



end



end
