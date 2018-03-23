ActiveAdmin.register_page "Dec" do

  menu  priority: 3,label: "Contratos"


  content title: "Contratos" do

    ##################
    Formula.where(product_id:1).update_all( numero:2 )
    case current_admin_user.categoria # a_variable is the variable we want to compare
    when 21
      @vuobac=[1]
      Formula.where(product_id:1,orden:1).update_all( numero:1 )
    when 22
      @vuobac=[2]
        Formula.where(product_id:1,orden:2).update_all( numero:1 )
    when 23
      @vuobac=[3]
      Formula.where(product_id:1,orden:3).update_all( numero:1 )
    when 29
      @vuobac=[1,2,3,6]
      Formula.where(product_id:1).where('orden=1 or orden=2 or orden=3 or orden=6').update_all( numero:1 )
    else
      @vuobac=[1,2,3,4,5,6]
      Formula.where(product_id:1).where.not(orden:4).update_all( numero:1 )
      Formula.where(product_id:1,orden:5).update_all( numero:2 )
      Formula.where(product_id:1,orden:4).update_all( numero:2 )
    end


  columns do
      column do

       ############fin de adjudicados
       panel  "I.-SEGUIMIENTO DE CONTRATOS ACFFAA" do
              table_for  Formula.where(product_id:11).order('orden') do





      def calcu1(var)

                @vxper2=[0,0,0,0,0,0,0,0]


                @vpro0=[]
                @vpro1=[]
                @vpro2=[]
                @vpro3=[]
                @vpro4=[]
                @vpro5=[]
                @vpro6=[]
                @vpro7=[]
                @vprot=[]





                @procp=Contract.where(periodo:var,obac:@vuobac).order('id')
# comienza bucle
                @procp .each do |proceso|

                    @deta4=Element.where(contract_id:proceso.id).
                                      order('pfecha DESC,id DESC')

                  vculmi=Element.where(contract_id:proceso.id,actividad:300).count



                         if vculmi==0 then
                         if @deta4.count>0 then
                            @vactiv3= @deta4.select('actividad as dd').first.dd

                          @vdir=Formula.where(product_id:19,orden:@vactiv3).
                                select('cantidad as dd').first.dd

                            @vxper2[@vdir]=@vxper2[@vdir]+ 1
                     #     @vpresu2[@vdir]=@vpresu2[@vdir]+ proceso.certificado









                             case @vdir
                             when 1
                               @vpro1.push(proceso.id)
                               Contract.where(id:proceso.id).update_all( sele:1 )
                             when 2
                               @vpro2.push(proceso.id)
                               Contract.where(id:proceso.id).update_all( sele:2 )
                             when 3
                               @vpro3.push(proceso.id)
                               Contract.where(id:proceso.id).update_all( sele:3 )
                             when 4
                               @vpro4.push(proceso.id)
                               Contract.where(id:proceso.id).update_all( sele:4 )
                               when 5
                                 @vpro5.push(proceso.id)
                                 Contract.where(id:proceso.id).update_all( sele:5 )
                               when 6
                                 @vpro6.push(proceso.id)
                                  Contract.where(id:proceso.id).update_all(sele:6  )
                                when 7
                                  @vpro7.push(proceso.id)
                                   Contract.where(id:proceso.id).update_all(sele:7  )
                              end #case

                              @vprot.push(proceso.id)

                          else
                              @vxper2[0]=@vxper2[0]+ 1
                            @vpro0.push(proceso.id)
                            Contract.where(id:proceso.id).update_all( sele:0 )
                              @vprot.push(proceso.id)
                          end# de if 1



                        end# de if 2

                     end
                end# del each

                column("Periodo") do |formula|
                        formula.nombre
                end
                column("ENVIO a OABC ", :class => 'text-right') do |formula|
                    calcu1(formula.orden)
                  @dpc=  formula.orden

                  @vpas=0
                  @titproc1="REMISION DE CONTRATO A OBAC"
                  @le= @vxper2[0]
                  link_to "#{@le}",
                  reports_comment6_path(format: :pdf,
                  :param3=> @vpas,
                  :param4=> @titproc1,:param5=> @vpro0)

                 end
                column("RECEP.Contrato", :class => 'text-right') do |formula|
                    calcu1(formula.orden)
                  @dpc=  formula.orden

                  @vpas=1
                  @titproc1="RECEPCION DE CONTRATO"
                  @le= @vxper2[1]
                  link_to "#{@le}",
                  reports_comment6_path(format: :pdf,
                  :param3=> @vpas,
                  :param4=> @titproc1,:param5=> @vpro1)

                 end


                column("RECEP. BIEN", :class => 'text-right') do |formula|
                    calcu1(formula.orden)
                  @dpc=  formula.orden

                  @vpas=2
                  @titproc1="FASE RECEPCION DE BIEN O SERVICIO"
                  @le= @vxper2[2]
                  link_to "#{@le}",
                  reports_comment6_path(format: :pdf,
                  :param3=> @vpas,
                  :param4=> @titproc1,:param5=> @vpro2)

                 end

                 column("RECEP. Guia", :class => 'text-right') do |formula|
                     calcu1(formula.orden)
                     @dpc=  formula.orden

                   @vpas=3
                   @titproc1="FASE RECEPCION DE GUIAS"
                   @le= @vxper2[3]
                   link_to "#{@le}",
                   reports_comment6_path(format: :pdf,
                   :param3=> @vpas,
                   :param4=> @titproc1,:param5=> @vpro3)

                  end


                 column("RECEP. PAGO", :class => 'text-right') do |formula|
                     calcu1(formula.orden)
                   @dpc=  formula.orden

                   @vpas=4
                   @titproc1="FASE RECEPCION DE PAGO"
                   @le= @vxper2[4]
                   link_to "#{@le}",
                   reports_comment6_path(format: :pdf,
                   :param3=> @vpas,
                   :param4=> @titproc1,:param5=> @vpro4)

                  end
                  column("TOTAL ", :class => 'text-right') do |formula|
                      calcu1(formula.orden)
                    @dpc=  formula.orden

                    @vpas=[0,1,2,3,4]
                    @titproc1="Relacion de Procesos"
                    @le=@vxper2[0]+@vxper2[1]+@vxper2[2]+@vxper2[3]+@vxper2[4]+ @vxper2[5]+  @vxper2[6]+  @vxper2[7]
                    link_to "#{@le}",
                    reports_comment6_path(format: :pdf,
                    :param3=> @vpas,
                    :param4=> @titproc1,:param5=> @vprot)

                  end



          end#panel
        end   #table fo
end# de column

#####################2

column do
panel  "II.-CONTRATOS CULMINADOS" do
       table_for  Formula.where(product_id:11).order('orden') do





def calcu2(var)





         @vcul=[]






         @procp=Contract.where(periodo:var,obac:@vuobac).order('id')

         @procp .each do |proceso|

             @deta4=Element.where(contract_id:proceso.id).
                               order('pfecha DESC,id DESC')


               vculmi=Element.where(contract_id:proceso.id,actividad:300).count




                  if vculmi>0   then
                    @vcul.push(proceso.id)


                   end# de if 1

              end
         end# del each

         column("Periodo") do |formula|
                 formula.nombre
         end
         column("Culminados") do |formula|
             calcu2(formula.orden)
           @dpc=  formula.orden

           @vpas=4
           @titproc1="Contratos culminados"
           @le= @vcul.length
           link_to "#{@le}",
           reports_comment6_path(format: :pdf,
           :param3=> @vpas,
           :param4=> @titproc1,:param5=> @vcul)

          end


        end


   end#panel
 end   #table fo
end
end
end
