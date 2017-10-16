ActiveAdmin.register_page "Dashboard" do

menu  priority: 1,label: proc{ I18n.t("active_admin.dashboard") }

#action_item :Encargo,  if: proc{ current_admin_user.id==2 } do
#Formula.where( product_id:15 ).update_all( cantidad:0 )
#Formula.where( product_id:15 ,orden:2).update_all( cantidad:1 )
#link_to 'Encargo',admin_dashboard_path
#end

action_item :only=> :index do

    link_to   'Cambiar AF', af_admin_product_formula_path(1, :@num), method: :put
end




  content title: proc{ I18n.t("active_admin.dashboard") } do



    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    # columns do
    #   column do
    #     panel "Recent Posts" do
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
        @dfin=365
        @vfin=Date.parse('2016/12/31')
         @vrang=30
         @vtitun=" AF-2016"



       when 3
         @vinicio = Date.parse('2017/01/01')
         @dfin=(Time.now-@vinicio.to_time).to_i/86400
         @vfin=Time.now
          @vrang=15
          @vtitun=" AF-2017"


    end #termina case



              columns do

                     column do

                       case current_admin_user.id
                       when 21,22,23,24


                       else

#else de column abierto


          ########################################





          case current_admin_user.id
          when 2,3,26
                       panel  "HISTORIAL POR PERIODOS  - 'PAC/(SOLES)'" do
                         table_for Formula.where(product_id:11).order('orden')  do


                              column("Periodos" ) do |formula|
                                formula.descripcion
                              end

                              column("EN ACFFAA ") do |formula|
                              @auto=  formula.orden
                              @tita1="PACs en ACFFAA - PERIODO"
                              @vopc1=4

                            @le1=  Item.where(ejecucion:4,exped2:formula.orden)
                                .where("modalidad<3")

                            @le= @le1.count.to_s+ "/("+
                                   number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                           case current_admin_user.id
                           when 21,22,23
                              @le
                             else
                               link_to "#{@le} ", reports_comment_path(format: :pdf,
                               :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

                            end

                          end



                              column("EN OBAC " ) do |formula|


                                @auto=  formula.orden
                                @tita1="PACs en OBAC - PERIODO"
                                @vopc1=5

                              @le1=  Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)")
                              .where(exped2:formula.orden)

                              @le= number_with_delimiter((@le1.count).to_i, delimiter: ",").to_s+ "/("+
                                     number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                case   formula.orden
                            when 3



                              case current_admin_user.id
                              when 21,22,23
                                 @le
                                else
                                  link_to "#{@le} ", reports_comment2_path(format: :pdf,
                                  :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

                               end









                            when 2
                              "1,711/(1,277,507,620)"
                            when 1
                                "3,566/(1,295,058,915)"
                            end
                               end


                              column("TOTAL  ") do |formula|
                                @vtproc=Item.where(exped2:formula.orden).where.not(modalidad:4)

                             case   formula.orden
                             when 1
                                 number_with_delimiter((@vtproc.count+3566).to_i, delimiter: ",").to_s+ "/("+

                                    number_with_delimiter((@vtproc.sum(:certificado)+1295058915).to_i, delimiter: ",").to_s+ ")"
                             when 2
                               number_with_delimiter((@vtproc.count+1711).to_i, delimiter: ",").to_s+ "/("+

                                    number_with_delimiter((@vtproc.sum(:certificado)+1277507620).to_i, delimiter: ",").to_s+ ")"
                               when 3
                                  number_with_delimiter((@vtproc.count).to_i, delimiter: ",").to_s+ "/("+

                                   number_with_delimiter(@vtproc.sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end
                              end

                          #     column("Culminados ACFFAA") do |formula|
                          #     Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).count.to_s+ "/("+
                          #          number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                        end   #de table for
    #########personal

                        li link_to "Personal por area evaluacion", reports_vhoja4_path(format: "xlsx")
                        li    link_to "visitas", "https://secure-harbor-85875.herokuapp.com"
                      end #de panel historial periodos

###############################
        end

end # de case
unless current_admin_user.id==24


               @vaf=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
               panel  "I.- LISTAS GENERALES DE COMPRAS ACFFAA "+@vaf+ " - 'PAC/(SOLES)'" do

                         table_for Formula.where(product_id:3)  do
                           @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
                              column("Listas ") do |formula|
                              formula.nombre
                              end

                              column("Por Encargo ") do |formula|
                                @auto=  formula.orden
                                @tita1="-"
                                @vopc1=1

                              @le1=Item.where(ejecucion:4,modalidad:2,lista:formula.orden)
                                   .where(exped2:@vaf).where(obac: @vuobac)

                              @le= @le1.count.to_s+ "/("+
                                     number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                              link_to "#{@le} ", reports_comment_path(format: :pdf,
                              :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                              end
                              column("Corporativos") do |formula|
                                @auto=  formula.orden
                                @tita1="-"
                                @vopc1=2

                              @le1=Item.where(ejecucion:4,modalidad:1,lista:formula.orden)
                                    .where(exped2:@vaf).where(obac: @vuobac)

                              @le= @le1.count.to_s+ "/("+
                                     number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                              link_to "#{@le} ", reports_comment_path(format: :pdf,
                              :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)


                              end

                              column("TOTAL") do |formula|

                                @auto=  formula.orden
                                @tita1="-"
                                @vopc1=3

                                @ls1=   Item.where(ejecucion:4,lista:formula.orden).where("modalidad<3")
                                        .where(exped2:@vaf).where(obac: @vuobac)
                                @ls=   @ls1.count.to_s+ "/("+
                                     number_with_delimiter(@ls1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                     link_to "#{@ls} ", reports_comment_path(format: :pdf,
                                     :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                              end







                          end # de table for listas

        @let=Item.where(ejecucion:4)
               .where(exped2:@vaf).where(obac: @vuobac)


table_for "A"  do
  column("Total=")
  column("#{@let.where(modalidad:2).count.to_s+"/("+
           number_with_delimiter(@let.where(modalidad:2).sum(:certificado).to_i, delimiter: ",").to_s+ ")"} ")
  column("#{@let.where(modalidad:1).count.to_s+"/("+
           number_with_delimiter(@let.where(modalidad:1).sum(:certificado).to_i, delimiter: ",").to_s+ ")"} ")
  column("#{@let.where('modalidad<=2').count.to_s+"/("+
           number_with_delimiter(@let.where('modalidad<=2').sum(:certificado).to_i, delimiter: ",").to_s+ ")"} ")
end#table



                        end # panel listas
                        @vaf=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
                        panel  "II.- TIPO DE COMPRA POR MERCADO  ACFFAA "+@vaf+ " - 'PAC/(SOLES)'" do

                                  table_for Formula.where(product_id:6)  do
                                    @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
                                       column("Mercado ") do |formula|
                                       formula.nombre
                                       end

                                       column("Por Encargo ") do |formula|
                                         @auto=  formula.orden
                                         @tita1=" "
                                         @vopc1=6

                                       @le1=Item.where(ejecucion:4,modalidad:2,tipo:formula.orden)
                                            .where(exped2:@vaf).where(obac: @vuobac)

                                       @le= @le1.count.to_s+ "/("+
                                              number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                       link_to "#{@le} ", reports_comment_path(format: :pdf,
                                       :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                                       end
                                       column("Corporativos") do |formula|
                                         @auto=  formula.orden
                                         @tita1=" "
                                         @vopc1=7

                                       @le1=Item.where(ejecucion:4,modalidad:1,tipo:formula.orden)
                                             .where(exped2:@vaf).where(obac: @vuobac)

                                       @le= @le1.count.to_s+ "/("+
                                              number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                       link_to "#{@le} ", reports_comment_path(format: :pdf,
                                       :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)


                                       end

                                       column("TOTAL") do |formula|

                                         @auto=  formula.orden
                                         @tita1=" "
                                         @vopc1=8

                                         @ls1=   Item.where(ejecucion:4,tipo:formula.orden).where("modalidad<3")
                                                 .where(exped2:@vaf).where(obac: @vuobac)
                                         @ls=   @ls1.count.to_s+ "/("+
                                              number_with_delimiter(@ls1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                              link_to "#{@ls} ", reports_comment_path(format: :pdf,
                                              :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                                       end






                                   end # de table for Mercado




                                 end # panel mercado

                          @vaf=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
                          panel  "III.- EXPEDIENTES POR FUENTE DE FINANCIAMIENTO  ACFFAA "+@vaf+ " - 'PAC/(SOLES)'" do

                                    table_for Formula.where(product_id:14)  do
                                      @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
                                         column("Fuente  ") do |formula|
                                         formula.nombre
                                         end

                                         column("Por Encargo ") do |formula|
                                           @auto=  formula.orden
                                           @tita1=" "
                                           @vopc1=9

                                         @le1=Item.where(ejecucion:4,modalidad:2,fuente:formula.orden)
                                              .where(exped2:@vaf).where(obac: @vuobac)

                                         @le= @le1.count.to_s+ "/("+
                                                number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                         link_to "#{@le} ", reports_comment_path(format: :pdf,
                                         :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                                         end
                                         column("Corporativos") do |formula|
                                           @auto=  formula.orden
                                           @tita1=" "
                                           @vopc1=10

                                         @le1=Item.where(ejecucion:4,modalidad:1,fuente:formula.orden)
                                               .where(exped2:@vaf).where(obac: @vuobac)

                                         @le= @le1.count.to_s+ "/("+
                                                number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                         link_to "#{@le} ", reports_comment_path(format: :pdf,
                                         :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)


                                         end

                                         column("TOTAL") do |formula|

                                           @auto=  formula.orden
                                           @tita1=" "
                                           @vopc1=11

                                           @ls1=   Item.where(ejecucion:4,seleccion:formula.orden).where("modalidad<3")
                                                   .where(exped2:@vaf).where(obac: @vuobac)
                                           @ls=   @ls1.count.to_s+ "/("+
                                                number_with_delimiter(@ls1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                                link_to "#{@ls} ", reports_comment_path(format: :pdf,
                                                :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                                         end






                                     end # de table for Mercado




                                   end # panel mercado

        end# de columns

      end # de unless de personal



        column do

unless current_admin_user.id==24 #personal

                                   @vaf1=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
                                   @vaf=Formula.where(product_id:11,cantidad:1).select('nombre as dd').first.dd


                                   panel  "IV.- SEGUIMIENTO DE PACs EN CURSO ACFFAA AF-" +@vaf+ " - 'PAC/(SOLES)'" do


                                      table_for Formula.where(product_id:11,orden:@vaf1).order('orden')  do
                                              @vxper=[0,0,0,0,0,0,0,0]
                                              @vpresu=[0,0,0,0,0,0,0,0]
                                              @vpac1=[]
                                              @vpac2=[]
                                              @vpac3=[]
                                              @vpac4=[]
                                              @vpac5=[]
                                              @vpac6=[]
                                              @vpac7=[]
                                              @itep=Item.where(ejecucion:4,exped2:@vaf1).where("modalidad<3").where(obac: @vuobac)
                                              @itep.each do |ite|

                                              @deta3=Detail.where(item_id:ite.id).
                                                where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).
                                                order('details.pfecha DESC,details.id DESC')









                                                        if @deta3.count>0 then
                                                          @vactiv= @deta3.
                                                             select('actividad as dd').first.dd
                                                             @vactivfec= @deta3.
                                                                select('pfecha as dd').first.dd


                                                            if  Phase.where.not(expediente:0).where(expediente:ite.exped,convocatoria:1).count>0 and
                                                              Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).activities  .where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).count>0 then


                                                               @phase3=Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).activities
                                                                    .where("pfecha>=? and pfecha<=? ", @vinicio,@vfin )
                                                                   .order('activities.pfecha DESC,activities.id DESC')













                                                             @vactiv2=Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).activities
                                                                        .where("pfecha>=? and pfecha<=? ", @vinicio,@vfin )
                                                                       .order('activities.pfecha DESC,activities.id DESC').
                                                                       select('activities.actividad as dd').first.dd
                                                              @vactiv2fec=Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).activities
                                                                           .where("pfecha>=? and pfecha<=? ", @vinicio,@vfin )
                                                                                 .order('activities.pfecha DESC,activities.id DESC').
                                                                                 select('activities.pfecha as dd').first.dd


                                                                  if    @vactiv2fec>  @vactivfec then
                                                                     @vactiv=@vactiv2
                                                                  end
                                                            end





                                                                #linea 209
                                                        @vdir=Formula.where(product_id:12,orden:@vactiv).
                                                              select('cantidad as dd').first.dd
                                          #                @vdir=2
                                                          @vxper[@vdir]=@vxper[@vdir]+ 1
                                                          @vpresu[@vdir]=@vpresu[@vdir]+ ite.certificado
                                                           case @vdir
                                                           when 1
                                                               @vpac1.push(ite.id)
                                                             when 2
                                                               @vpac2.push(ite.id)
                                                             when 3
                                                               @vpac3.push(ite.id)
                                                             when 4
                                                               @vpac4.push(ite.id)
                                                             when 5
                                                               @vpac5.push(ite.id)
                                                             when 6
                                                               @vpac6.push(ite.id)
                                                             when 7
                                                               @vpac7.push(ite.id)

                                                          end #case

                                                        else
                                                           @vxper[0]=@vxper[0]+ 1
                                                           @vpresu[0]=@vpresu[0]+ ite.certificado
                                                           @vpac1.push(ite.id)


                        end# de if 1
                                                 end
                                         column("Avance") do |formula|
                                     link_to "PAC", reports_vhoja1_path(format:  "xlsx", :param1=> @vxper,
                                      :param2=> @vpresu, :param3=> @vpac1, :param4=> @vpac2,
                                      :param5=> @vpac3,:param6=> @vpac4)
                                        #  "PAC"
                                         end
                                         column("S/EXP") do |formula|

                                           @titproc1="PAC SIN EXPEDIENTE DE INICIO "
                                           @vpas=[0,1]
                                           @dpcl=   @vxper[0]+ @vxper[1]
                                                 link_to "#{@dpcl} ",
                                                  reports_comment7_path(format: :pdf,
                                                  :param3=> @vpas,
                                                  :param4=> @titproc1,:param5=> @vpac1)
                                          end

                                       column("C/EXP") do |formula|
                                        @dpc=  formula.orden
                                        @vpas=[2]
                                        @titproc1="PAC CON EXPEDIENTE DE INICIO"

                                        @dpcl=   @vxper[2].to_s+ "/("+
                                        number_with_delimiter(@vpresu[2].to_i, delimiter: ",").to_s+ ")"

                                               link_to "#{@dpcl} ",
                                               reports_comment7_path(format: :pdf,
                                              :param3=> @vpas,
                                              :param4=> @titproc1,:param5=> @vpac2)
                                         end

                                         column("DC") do |formula|

                                           @dpc=  formula.orden
                                           @vpas=[3]
                                           @titproc1="EXPEDIENTES EN CATALOGACION"
                                           @dpcl=   @vxper[3]
                                                 link_to "#{@dpcl} ",
                                                  reports_comment7_path(format: :pdf,
                                                  :param3=> @vpas,
                                                  :param4=> @titproc1,:param5=> @vpac3)

                                          end

                                         column("DEM") do |formula|
                                           @dpc=  formula.orden
                                           @vpas=[4]
                                           @titproc1="EXPEDIENTES EN ESTUDIO DE MERCADO"
                                           @dpcl=   @vxper[4].to_s+ "/("+
                                           number_with_delimiter(@vpresu[4].to_i, delimiter: ",").to_s+ ")"
                                                 link_to "#{@dpcl} ",
                                                  reports_comment7_path(format: :pdf,
                                                  :param3=> @vpas,
                                                  :param4=> @titproc1,:param5=> @vpac4)

                                          end

                                         column("DPC") do |formula|
                                         @dpc=  formula.orden
                                          @vpas=[5]
                                          @titproc1="EXPEDIENTES EN PROCESO DE COMPRAS"
                                           @dpcl=  @vxper[5]
                                                 link_to "#{@dpcl} ",
                                                  reports_comment7_path(format: :pdf,
                                                  :param3=> @vpas,
                                                  :param4=> @titproc1,:param5=> @vpac5)

                                          end

                                         column("FC ") do |formula|
                                           @dpc=  formula.orden
                                           @vpas=[6]
                                           @titproc1="EXPEDIENTES POR FIRMA DE CONTRATO"
                                           @dpcl=   @vxper[6]
                                                   link_to "#{@dpcl} ",
                                                   reports_comment7_path(format: :pdf,
                                                   :param3=> @vpas,
                                                   :param4=> @titproc1,:param5=> @vpac6)

                                         end
                                         column("EC ") do |formula|
                                           @dpc=  formula.orden
                                           @vpas=[7]
                                           @titproc1="EXPEDIENTES EN DEC"
                                           @dpcl=   @vxper[7]
                                                   link_to "#{@dpcl} ",
                                                   reports_comment7_path(format: :pdf,
                                                   :param3=> @vpas,
                                                   :param4=> @titproc1,:param5=> @vpac7)

                                         end

                                        column("TOTAL ") do |formula|

                                          @auto=  @vaf1
                                          @tita1="Total Procesos en Curso ACFFAA - PERIODO"
                                          @vopc1=4
                                          @le=  @vxper.inject(0, :+).to_s+ "/("+
                                          number_with_delimiter(@vpresu.inject(0, :+).to_i, delimiter: ",").to_s+ ")"
                                                  link_to "#{@le} ", reports_comment_path(format: :pdf,
                                               :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

                                       end








                                    end # de table_for

                            end #end de panel









                                   panel  "V.- CALENDARIO DE PROCESOS  ACFFAA "+@vaf + " - 'PROCESOS/(SOLES)'" do
                                   #  ul do

                                   #li link_to "Historial  ", reports_comment4_path(format: :pdf,  :param1=> 2)
                                     #    li link_to "Programados ", reports_comment4_path(format: :pdf,  :param1=> 1)

                                   #  end
                                       table_for  Formula.where(product_id:29).where('orden<3').order('orden') do
##################
@vxper2=[0,0,0,0,0,0,0,0]
@vxper3=[0,0,0,0,0,0,0,0]
@contavus=[0,0,0,0,0,0,0,0]

# @vpresu2=[0,0,0,0,0,0,0]
@vpro1=[]
@vpro2=[]
@vpro3=[]
@vpro4=[]
@vpro5=[]
@vpro6=[]
@vpro7=[]
@vprot=[]

@vconv1=[]# actos previos
@vconv2=[]# convocados
@vconv3=[]# adjudicados
@vconvt=[]# total


@vexped=Item.where(obac: @vuobac).where.not(exped:0).select('DISTINCT exped')


@procp=Phase.where(periodo:@vaf1).where(expediente:@vexped).order('id')

@procp .each do |proceso|

    @deta4=Activity.where(phase_id:proceso.id).
      where("pfecha>=?  ", @vinicio ).
    order('pfecha DESC,id DESC')







         if @deta4.count>0  then
            @vactiv3= @deta4.where("pfecha<=?  ", @vfin ).select('actividad as dd').first.dd

          @vdir=Formula.where(product_id:12,orden:@vactiv3).
                select('cantidad as dd').first.dd



                @vxper2[@vdir]=@vxper2[@vdir]+ 1


     #     @vpresu2[@vdir]=@vpresu2[@vdir]+ proceso.certificado
           @vconv=0
        if @deta4.where(actividad:20).count>0 and @vdir>4 then
              @vconv=2
            if @deta4.where(actividad:20).sum(:importe)>0 then
              @vconv=3
            end

        else
          if @vdir==5 then
              @vconv=1
          else
              @vconv=4
          end
        end
        if @deta4.where(actividad:79).count>0 then
          @vconv=4
          @vxper2[@vdir]=@vxper2[@vdir]- 1
          @vdir=0
        end



        case @vconv
          when 1
            @vconv1.push(proceso.id)
            @vxper3[1]=@vxper3[1]+1

         if proceso.moneda and proceso.valor then

             @vpv=Formula.where(product_id:7,orden:proceso.moneda)
                   .select('cantidad as dd').first.dd.to_i*proceso.valor/100


             @contavus[1]=  @contavus[1]+ @vpv
             Phase.where(id:proceso.id).update_all( sele2:@vpv )
        end

            if Activity.where(phase_id:proceso.id,actividad:34).count>0 then
            @vpp=Activity.where(phase_id:proceso.id,actividad:34)
            .select('pfecha as dd').first.dd
            Phase.where(id:proceso.id).update_all( pp:@vpp )
            else
            Phase.where(id:proceso.id).update_all( pp:Time.now )
            end

         when 2
            @vconv2.push(proceso.id)
              @vxper3[2]=@vxper3[2]+1
              if proceso.valor then

             @vpv=Formula.where(product_id:7,orden:proceso.moneda)
                   .select('cantidad as dd').first.dd.to_i*proceso.valor/100

              @contavus[2]=  @contavus[2]+@vpv
               Phase.where(id:proceso.id).update_all( sele2:@vpv )
              end
              @vpp=Activity.where(phase_id:proceso.id,actividad:20)
              .select('pfecha as dd').first.dd
              Phase.where(id:proceso.id).update_all( pp:@vpp )



          when 3
            @vconv3.push(proceso.id)
              @vxper3[3]=@vxper3[3]+1
@vpv=0
      if  Piece.where(phase_id:proceso.id).where("adjudicado IS NOT NULL and moneda IS NOT NULL").count>0  then
        Piece.where(phase_id:proceso.id).where("adjudicado IS NOT NULL").each do |adju|
           @vpv=@vpv+adju.adjudicado*Formula.where(product_id:7,orden:adju.moneda).select('cantidad as dd').first.dd.to_i/100
        end
      end

              @contavus[3]=  @contavus[3]+@vpv
                Phase.where(id:proceso.id).update_all( sele2:@vpv )

              @vpp=Activity.where(phase_id:proceso.id,actividad:20)
              .select('pfecha as dd').first.dd
              Phase.where(id:proceso.id).update_all( pp:@vpp )

        end #case

        case @vconv
        when 1,2,3
           @vconvt.push(proceso.id)
           @vxper3[0]=@vxper3[0]+1



        end

    unless @vactiv3 ==79

             case @vdir
             when 1
               @vpro1.push(proceso.id)
               Phase.where(id:proceso.id).update_all( sele:1 )
             when 2
               @vpro2.push(proceso.id)
               Phase.where(id:proceso.id).update_all( sele:2 )
             when 3
               @vpro3.push(proceso.id)
               Phase.where(id:proceso.id).update_all( sele:3 )
             when 4
               @vpro4.push(proceso.id)
               Phase.where(id:proceso.id).update_all( sele:4 )
               when 5
                 @vpro5.push(proceso.id)
                 Phase.where(id:proceso.id).update_all( sele:5 )
               when 6
                 @vpro6.push(proceso.id)
                  Phase.where(id:proceso.id).update_all(sele:6  )
                when 7
                  @vpro7.push(proceso.id)
                   Phase.where(id:proceso.id).update_all(sele:7  )
              end #case

            case @vdir
            when 1,2,3,4,5,6,7
                @vprot.push(proceso.id)
            end
end


          end# de if 1


end# del each

@nliqui=@procp.where(sele:7).count
if @nliqui>0 then
@idliqui=@procp.where(sele:7).select('id')
@vliqui=Activity.where(phase_id:@idliqui,actividad:300).count
end
##################
case current_admin_user.id
when  2,3,10,25 # adm,roy,pedro,salinas
  vvar=1
else
  vvar=0
end

##################

column("Rol") do |formula|
   if formula.orden==1 then
     link_to "#{formula.nombre}", reports_vhoja2_path(format:  "xlsx", :param1=> @vxper3,
        :param2=> @contavus, :param3=> @vconv1, :param4=>@vconv2,
        :param5=> @vconv3,:param6=> @vconvt,:param7=> @vuobac)
   else
     if vvar==1 then
     link_to "#{formula.nombre}", reports_vhoja3_path(format:  "xlsx", :param1=> @vxper3,
        :param2=> @contavus, :param3=> @vconv1, :param4=>@vconv2,
        :param5=> @vconv3,:param6=> @vconvt,:param7=> @vuobac)
     end
   end

end

column("En Proceso") do |formula|
  if formula.orden==1 then
  @dpc=  formula.orden
  @titproc1="En Proceso"
  @vopc=4


 link_to "#{@vxper3[1]}"+"/("+"#{number_with_delimiter(@contavus[1].to_i, delimiter: ",")}"+")",
  reports_comment4_path(format: :pdf,  :param1=>  @vopc,   :param2=>  @vconv1,
   :param4=>  @titproc1)
 else
   if vvar==1 then
    Phase.where(id:@vconv1,sele3:2).count
  end
 end
 end

 column("convocados") do |formula|
   if formula.orden==1 then
   @dpc=  formula.orden
   @titproc1="Procesos Convocados"
   @vopc=1


link_to "#{@vxper3[2]}"+"/("+"#{number_with_delimiter(@contavus[2].to_i, delimiter: ",")}"+")",
reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  @vconv2,
:param4=>  @titproc1)
else
  if vvar==1 then
    Phase.where(id:@vconv2,sele3:2).count
  end
end
  end


  column("Adjudicados") do |formula|
       if formula.orden==1 then
    @dpc=  formula.orden
    @titproc1="Procesos Adjudicados"
    @vopc=2


  link_to "#{@vxper3[3]}"+"/("+"#{number_with_delimiter(@contavus[3].to_i, delimiter: ",")}"+")",
  reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  @vconv3,
  :param4=>  @titproc1)
else
 if vvar==1 then
     Phase.where(id:@vconv3,sele3:2).count
end
end
end
   column("Total") do |formula|
     if formula.orden==1 then
     @dpc=  formula.orden
     @titproc1="Relacion de Procesos"
     @vopc=3
     @contavus[0]=  @contavus[1]+@contavus[2]+@contavus[3]

   link_to "#{@vxper3[0]}"+"/("+"#{number_with_delimiter(@contavus[0].to_i, delimiter: ",")}"+")",
   reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  @vconvt,
   :param4=>  @titproc1)
 else
   if vvar==1 then
      Phase.where(id:@vconvt,sele3:2).count
  end
 end

    end




end #de table

 #if @vliqui>0 then
 #strong("* Procesos culminados = "+@vliqui.to_s)

 #end

table_for  Formula.where(product_id:11,orden:@vaf1).order('orden') do
  column("Resumen ") do |formula|
  "Procesos acumulados"
  end
column("convocados") do |formula|
  @vxper3[2]+@vxper3[3]
end
column("Adjudicados") do |formula|
  @vxper3[3]
end
column("Culminados") do |formula|
  @vliqui
end

end







end #panel

end #personal de column
#########################################
case current_admin_user.id
when 21,22,23,24


else
   panel  "VI.- SEGUIMIENTO DE PROCESOS EN CURSO ACFFAA AF-" +@vaf  do


      table_for Formula.where(product_id:11,orden:@vaf1).order('orden')  do

         column("Avance") do |formula|
                 "Proceso"
         end
         column("Des./nulo") do |formula|
           @dpc=  formula.orden
           @vpaso=0
           @vpas=1
           @titproc1="PROCESOS EN OBAC"
           @le= @vxper2[1]
           link_to "#{@le}",
           reports_comment5_path(format: :pdf,
           :param3=> @vpas,
           :param4=> @titproc1,:param5=> @vpro1,:param2=> @vpaso)

          end


         column("C/EXP") do |formula|
           @dpc=  formula.orden
           @vpaso=0
           @vpas=2
           @titproc1="PROCESOS EN GEX"
           @le= @vxper2[2]
           link_to "#{@le}",
           reports_comment5_path(format: :pdf,
           :param3=> @vpas,
           :param4=> @titproc1,:param5=> @vpro2,:param2=> @vpaso)

          end


         column("DC") do |formula|
           @dpc=  formula.orden
           @vpaso=0
           @vpas=3
           @titproc1="PROCESOS EN DC"
           @le= @vxper2[3]
           link_to "#{@le}",
           reports_comment5_path(format: :pdf,
           :param3=> @vpas,
           :param4=> @titproc1,:param5=> @vpro3,:param2=> @vpaso)

          end


         column("DEM") do |formula|
           @dpc=  formula.orden
           @vpaso=0
           @vpas=4
           @titproc1="PROCESOS EN DEM"
           @le= @vxper2[4]
           link_to "#{@le}",
           reports_comment5_path(format: :pdf,
           :param3=> @vpas,
           :param4=> @titproc1,:param5=> @vpro4,:param2=> @vpaso)

          end



         column("DPC") do |formula|
           @dpc=  formula.orden
           @vpaso=0
           @vpas=5
           @titproc1="PROCESOS EN DPC"
           @le= @vxper2[5]
           link_to "#{@le}",
           reports_comment5_path(format: :pdf,
           :param3=> @vpas,
           :param4=> @titproc1,:param5=> @vpro5,:param2=> @vpaso)

          end

          column("FC") do |formula|
            @dpc=  formula.orden
              @vpaso=0
            @vpas=6
            @titproc1="PROCESOS PREVIOS A FIRMA DE CONTRATO"
            @le= @vxper2[6]
            link_to "#{@le}",
            reports_comment5_path(format: :pdf,
            :param3=> @vpas,
            :param4=> @titproc1,:param5=> @vpro6,:param2=> @vpaso)
          end

            column("EC") do |formula|
              @dpc=  formula.orden
                @vpaso=0
              @vpas=7
              @titproc1="PROCESOS EN EJECUCION CONTRACTUAL"
              @le= @vxper2[7]
              link_to "#{@le}",
              reports_comment5_path(format: :pdf,
              :param3=> @vpas,
              :param4=> @titproc1,:param5=> @vpro7,:param2=> @vpaso)



          end
          column("TOTAL") do |formula|
            @dpc=  formula.orden
              @vpaso=1
            @vpas=[1,2,3,4,5,6,7]
            @titproc1="RELACION DE PROCESOS"
            @le=@vxper2[1]+@vxper2[2]+@vxper2[3]+@vxper2[4]+ @vxper2[5]+  @vxper2[6]+  @vxper2[7]
            link_to "#{@le}",
            reports_comment5_path(format: :pdf,
            :param3=> @vpas,
            :param4=> @titproc1,:param5=> @vprot,:param2=> @vpaso)







          end







   end
   end

if current_admin_user.id==2 then
   panel  "VII.-SEGUIMIENTO DE CONTRATOS ACFFAA-"+@vaf  do
          table_for  Formula.where(product_id:11,orden:@vaf1).order('orden') do

            ##################
            @vxper2=[0,0,0,0,0,0,0,0]



            @vpro1=[]
            @vpro2=[]
            @vpro3=[]
            @vpro4=[]
            @vpro5=[]
            @vpro6=[]
            @vpro7=[]
            @vprot=[]





            @procp=Contract.where(periodo:@vaf1,obac:@vuobac).order('id')

            @procp .each do |proceso|

                @deta4=Element.where(contract_id:proceso.id).
                  where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).
                order('pfecha DESC,id DESC')







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

                        case @vdir
                        when 1,2,3,4,5,6,7
                            @vprot.push(proceso.id)
                        end



                      end# de if 1


            end# del each

            column("Avance") do |formula|
                    "Contrato"
            end
            column("Recp Contrato") do |formula|
              @dpc=  formula.orden

              @vpas=1
              @titproc1="FASE RECEPCION DE CONTRATO"
              @le= @vxper2[1]
              link_to "#{@le}",
              reports_comment6_path(format: :pdf,
              :param3=> @vpas,
              :param4=> @titproc1,:param5=> @vpro1)

             end


            column("Recp Bien") do |formula|
              @dpc=  formula.orden

              @vpas=2
              @titproc1="FASE RECEPCION DE BIEN O SERVICIO"
              @le= @vxper2[2]
              link_to "#{@le}",
              reports_comment6_path(format: :pdf,
              :param3=> @vpas,
              :param4=> @titproc1,:param5=> @vpro2)

             end

             column("Recp Guia") do |formula|
               @dpc=  formula.orden

               @vpas=3
               @titproc1="FASE RECEPCION DE GUIAS"
               @le= @vxper2[3]
               link_to "#{@le}",
               reports_comment6_path(format: :pdf,
               :param3=> @vpas,
               :param4=> @titproc1,:param5=> @vpro3)

              end


             column("Recp Pago") do |formula|
               @dpc=  formula.orden

               @vpas=4
               @titproc1="FASE RECEPCION DE PAGO"
               @le= @vxper2[4]
               link_to "#{@le}",
               reports_comment6_path(format: :pdf,
               :param3=> @vpas,
               :param4=> @titproc1,:param5=> @vpro4)

              end
              column("TOTAL") do |formula|
                @dpc=  formula.orden

                @vpas=[1,2,3,4]
                @titproc1="Relacion de Procesos"
                @le=@vxper2[1]+@vxper2[2]+@vxper2[3]+@vxper2[4]+ @vxper2[5]+  @vxper2[6]+  @vxper2[7]
                link_to "#{@le}",
                reports_comment6_path(format: :pdf,
                :param3=> @vpas,
                :param4=> @titproc1,:param5=> @vprot)

              end



      end#panel
    end   #table for
  end # de if  panel contratos current 2

  end
#personal
unless current_admin_user.id==24


  panel  "Leyenda" do
   li "S/EXP: Expediente en OBAC"
     li "C/EXP: Expediente en ACFFAA"
       li "DC: Dirección de Catalogación ACFFAA"
         li "DEM: Dirección de Estudio de Mercado ACFFAA"
           li "DPC: Dirección de Procesos de Compras ACFFAA"
            li "FC: Previo a Firma de Contrato ACFFAA "
             li "EC:En Ejecucion de Contrato"





  end
else
  li link_to "Personal por area evaluacion",    reports_vhoja4_path(format: "xlsx")
end

#########################################

end #column 2












    end




  end # content



end
