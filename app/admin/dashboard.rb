ActiveAdmin.register_page "Dashboard" do

menu  priority: 1,label: proc{ I18n.t("active_admin.dashboard") }

#action_item :Encargo,  if: proc{ current_admin_user.categoria==2 } do
#Formula.where( product_id:15 ).update_all( cantidad:0 )
#Formula.where( product_id:15 ,orden:2).update_all( cantidad:1 )
#link_to 'Encargo',admin_dashboard_path
#end

action_item :only=> :index do

    link_to   'Cambiar AF', af_admin_admin_user_path(1, :@num), method: :put
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
    Formula.where(product_id:1).update_all( numero:2 )
    case current_admin_user.categoria # a_variable is the variable we want to compare
  #  when 21 #ejercito
  #    @vuobac=[1]
  #    Formula.where(product_id:1,orden:1).update_all( numero:1 )
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

    #comienza case

    @vaf=current_admin_user.periodo
    @vaf1=Formula.where(product_id:11,orden:@vaf).select('descripcion as dd').first.dd
  case @vaf  #comienza case

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



              columns do

                     column do

                       case current_admin_user.categoria
                       when 21,22,23,24,29


                       else

#else de column abierto


          ########################################





          case current_admin_user.categoria
          when 2,3,26,4,6,8,9 #adm roy amador italo sectoristas
                       panel  "HISTORIAL POR PERIODOS  - 'PAC/(SOLES)'" do
                         table_for Formula.where(product_id:11).order('orden')  do


                              column("Periodos" ) do |formula|
                                formula.descripcion
                              end

                              column("EN ACFFAA ", :class => 'text-right') do |formula|
                              @auto=  formula.orden
                              @tita1="PACs en ACFFAA - PERIODO"
                              @vopc1=4

                            @le1=  Item.where(ejecucion:4,exped2:formula.orden)
                                .where("modalidad<3")

                            @le= @le1.count.to_s+ "/("+
                                   number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                           case current_admin_user.categoria
                           when 21,22,23,29
                              @le
                             else
                               #cambiar comment2 por comment para ver modalidalidad y mercado
                               link_to "#{@le} ", reports_comment2_path(format: :pdf,
                               :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

                            end

                          end



                              column("EN OBAC ", :class => 'text-right' ) do |formula|


                                @auto=  formula.orden
                                @tita1="PACs en OBAC - PERIODO"
                                @vopc1=5

                              @le1=  Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)")
                              .where(exped2:formula.orden)

                              @le= number_with_delimiter((@le1.count).to_i, delimiter: ",").to_s+ "/("+
                                     number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"



                                case   formula.orden
                            when 4



                              case current_admin_user.categoria
                              when 21,22,23,29
                                 @le
                                else
                                  link_to "#{@le} ", reports_comment2_path(format: :pdf,
                                  :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

                               end




                           when 3

                                 c3="2,119/(870,358,390)"

                            when 2

                                a3="1,711/(1,277,507,620)"
                            when 1

                                b3="3,566/(1,295,058,915)"

                            end
                               end


                              column("TOTAL  ", :class => 'text-right') do |formula|
                                a1=1711
                                a2=1277507620
                                b1=3566
                                b2=1295058915
                                c1=2119
                                c2=870358390
                                @vtproc=Item.where(exped2:formula.orden).where.not(modalidad:4)

                             case   formula.orden
                             when 1
                                 number_with_delimiter((@vtproc.where(ejecucion:4).count+b1).to_i, delimiter: ",").to_s+ "/("+

                                    number_with_delimiter((@vtproc.where(ejecucion:4).sum(:certificado)+b2).to_i, delimiter: ",").to_s+ ")"
                             when 2
                               number_with_delimiter((@vtproc.where(ejecucion:4).count+a1).to_i, delimiter: ",").to_s+ "/("+

                                    number_with_delimiter((@vtproc.where(ejecucion:4).sum(:certificado)+a2).to_i, delimiter: ",").to_s+ ")"
                              when 3
                                    number_with_delimiter((@vtproc.where("modalidad<3").where(ejecucion:4).count+c1).to_i, delimiter: ",").to_s+ "/("+

                                   number_with_delimiter((@vtproc.where("modalidad<3").where(ejecucion:4).sum(:certificado)+c2).to_i, delimiter: ",").to_s+ ")"

                               when 4
                                  number_with_delimiter((@vtproc.count).to_i, delimiter: ",").to_s+ "/("+

                                   number_with_delimiter(@vtproc.sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end
                              end

                          #     column("Culminados ACFFAA") do |formula|
                          #     Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).count.to_s+ "/("+
                          #          number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                        end   #de table for
    #########personal
                         case current_admin_user.categoria
                             when 2,3
                           #  li link_to "Personal por area evaluacion", reports_vhoja4_path(format: "xlsx")
                           #  li    link_to "Personal", "https://secure-harbor-85875.herokuapp.com"
                              li    link_to "Personal", "http://172.25.10.6:3001/admin/login"
                             li    link_to "Compras local", "http://172.25.10.6:3000/admin/login"

                         end
                      end #de panel historial periodos

###############################
        end

end # de case
unless current_admin_user.categoria==24



               panel  "I.- PAC-LISTAS GENERALES DE COMPRAS ACFFAA "+@vaf1+ " - 'PAC/(SOLES)'" do

                         table_for Formula.where(product_id:3).order('orden')  do

                        #     @vult=Formula.where(product_id:3).maximum('orden')
                        @let=Item.where(ejecucion:4)
                               .where(exped2:@vaf).where(obac: @vuobac)
                              column("Listas ") do |formula|
                                  if formula.cantidad==1 then
                                    formula.nombre
                                  else
                                    div :class =>"grueso" do
                                    link_to formula.descripcion, reports_vhoja7_path(format:  "xlsx", :param1=> @vuobac)
                                  end
                                  end
                              end


                              column("Por Encargo ", :class => 'text-right') do |formula|
                                if formula.cantidad==1 then
                                  @auto=  formula.orden
                                  @tita1="-"
                                  @vopc1=1

                                @le1=Item.where(ejecucion:4,modalidad:2,lista:formula.orden)
                                     .where(exped2:@vaf).where(obac: @vuobac)

                                @le= @le1.count.to_s+ "/("+
                                       number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                link_to "#{@le} ", reports_comment_path(format: :pdf,
                                :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)
                                else

                                  @tita1="-"
                                  @vopc1=13
                                  vnometi="#{@let.where(modalidad:2).count.to_s+"/("+
                                           number_with_delimiter(@let.where(modalidad:2).sum(:certificado).to_i,
                                            delimiter: ",").to_s+ ")"} "
                                    div :class =>"grueso" do

                                  link_to vnometi,
                                              reports_comment_path(format: :pdf, :param3=>   @tita1,
                                             :param4=>   @vopc1 )
                                    end
                                end




                              end
                              column("Corporativos", :class => 'text-right') do |formula|
                                  if formula.cantidad==1 then
                                @auto=  formula.orden
                                @tita1="-"
                                @vopc1=2

                              @le1=Item.where(ejecucion:4,modalidad:1,lista:formula.orden)
                                    .where(exped2:@vaf).where(obac: @vuobac)

                              @le= @le1.count.to_s+ "/("+
                                     number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                              link_to "#{@le} ", reports_comment_path(format: :pdf,
                              :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)
                            else

                              @tita1="-"
                              @vopc1=14


                              vnometi="#{@let.where(modalidad:1).count.to_s+"/("+
                                       number_with_delimiter(@let.where(modalidad:1).sum(:certificado).to_i,
                                        delimiter: ",").to_s+ ")"} "
                                div :class =>"grueso" do
                              link_to vnometi,
                                          reports_comment_path(format: :pdf, :param3=>   @tita1,
                                         :param4=>   @vopc1 )
                                end
                            end

                              end

                              column("TOTAL", :class => 'text-right') do |formula|
                                    if formula.cantidad==1 then
                                @auto=  formula.orden
                                @tita1="-"
                                @vopc1=3

                                @ls1=   Item.where(ejecucion:4,lista:formula.orden).where("modalidad<3")
                                        .where(exped2:@vaf).where(obac: @vuobac)
                                @ls=   @ls1.count.to_s+ "/("+
                                     number_with_delimiter(@ls1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                     link_to "#{@ls} ", reports_comment_path(format: :pdf,
                                     :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)
                                   else

                                     @tita1="-"
                                     @vopc1=15


                                     vnometi="#{@let.where('modalidad<=2').count.to_s+"/("+
                                              number_with_delimiter(@let.where('modalidad<=2').sum(:certificado).to_i,
                                               delimiter: ",").to_s+ ")"} "
                                  div :class =>"grueso" do
                                    link_to vnometi,
                                               reports_comment_path(format: :pdf, :param3=>   @tita1,
                                                :param4=>   @vopc1 )
                                  end


                              end

                            end





                          end # de table for listas



                        end # panel listas



                          panel  "II.- PAC-EXPEDIENTES POR FUENTE DE FINANCIAMIENTO  ACFFAA "+@vaf1+ " - 'PAC/(SOLES)'" do
                            @let=Item.where(ejecucion:4)
                                   .where(exped2:@vaf).where(obac: @vuobac)

                                    table_for Formula.where(product_id:8)  do

                                       column("Fuente  ") do |formula|
                                          if formula.cantidad==1 then
                                              formula.nombre
                                           else
                                              div :class =>"grueso" do
                                              formula.descripcion
                                            end
                                           end
                                        end

                                         column("Por Encargo ", :class => 'text-right') do |formula|
                                             if formula.cantidad==1 then
                                                @auto=  formula.orden
                                                @tita1=" "
                                                @vopc1=9

                                               @le1=Item.where(ejecucion:4,modalidad:2,fuente:formula.orden)
                                                   .where(exped2:@vaf).where(obac: @vuobac)

                                                @le= @le1.count.to_s+ "/("+
                                                     number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                               link_to "#{@le} ", reports_comment_path(format: :pdf,
                                              :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

                                            else
                                               div :class =>"grueso" do
                                                 vnometi="#{@let.where(modalidad:2).count.to_s+"/("+
                                                          number_with_delimiter(@let.where(modalidad:2).sum(:certificado).to_i,
                                                           delimiter: ",").to_s+ ")"} "
                                                end
                                             end
                                         end
                                         column("Corporativos", :class => 'text-right') do |formula|
                                          if formula.cantidad==1 then
                                             @auto=  formula.orden
                                             @tita1=" "
                                             @vopc1=10

                                             @le1=Item.where(ejecucion:4,modalidad:1,fuente:formula.orden)
                                                  .where(exped2:@vaf).where(obac: @vuobac)

                                             @le= @le1.count.to_s+ "/("+
                                                   number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                             link_to "#{@le} ", reports_comment_path(format: :pdf,
                                              :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)
                                           else
                                            div :class =>"grueso" do
                                              vnometi="#{@let.where(modalidad:1).count.to_s+"/("+
                                                       number_with_delimiter(@let.where(modalidad:2).sum(:certificado).to_i,
                                                        delimiter: ",").to_s+ ")"} "
                                           end
                                            end

                                         end

                                         column("TOTAL", :class => 'text-right') do |formula|
                                            if formula.cantidad==1 then
                                                @auto=  formula.orden
                                                @tita1=" "
                                                @vopc1=11

                                                @ls1=   Item.where(ejecucion:4,fuente:formula.orden).where("modalidad<3")
                                                       .where(exped2:@vaf).where(obac: @vuobac)
                                                @ls=   @ls1.count.to_s+ "/("+
                                                   number_with_delimiter(@ls1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                                link_to "#{@ls} ", reports_comment_path(format: :pdf,
                                                :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

                                              else
                                               div :class =>"grueso" do
                                                 vnometi="#{@let.where('modalidad<=2').count.to_s+"/("+
                                                          number_with_delimiter(@let.where('modalidad<=2').sum(:certificado).to_i,
                                                           delimiter: ",").to_s+ ")"} "
                                              end
                                               end

                                         end






                                     end # de table for Mercado




                                   end # panel mercado



        end# de columns


        #personal
        unless current_admin_user.categoria==24


          panel  "Leyenda" do
           li "RO: Recursos ordinarios"
             li "RO-Vraem: Recursos ordinarios Vraem"
               li "RD: Recurso determinado"
                 li "RO,RDR/RP: Recursos ordinarios,
                   R. direct. recaudados/R. propios"
                   li "D y T: Donaciones y transferencias"
                    li "ROOC: Recursos por operaciones oficiales de credito"
                     li "RDR y RP/RP: Recursos directamente recaudados"





          end
        else
        #  li link_to "Personal por area evaluacion",    reports_vhoja4_path(format: "xlsx")
          li    link_to "Personal", "http://172.25.10.6:3001/admin/login"
        end



      end # de unless de personal



        column do

unless current_admin_user.categoria==24 #personal



  panel  "III.- PAC-TIPO DE COMPRA POR MERCADO  ACFFAA "+@vaf1+ " - 'PAC/(SOLES)'" do

            table_for Formula.where(product_id:6)  do
              @let=Item.where(ejecucion:4)
                     .where(exped2:@vaf).where(obac: @vuobac)

                 column("Mercado ") do |formula|
                     if formula.cantidad==1 then
                       formula.nombre
                   else
                       div :class =>"grueso" do
                     formula.descripcion
                      end
                   end
                 end

                 column("Por Encargo ", :class => 'text-right') do |formula|
                    if formula.cantidad==1 then
                   @auto=  formula.orden
                   @tita1=" "
                   @vopc1=6

                 @le1=Item.where(ejecucion:4,modalidad:2,tipo:formula.orden)
                      .where(exped2:@vaf).where(obac: @vuobac)

                 @le= @le1.count.to_s+ "/("+
                        number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                 link_to "#{@le} ", reports_comment_path(format: :pdf,
                 :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

               else
                  div :class =>"grueso" do
                    vnometi="#{@let.where(modalidad:2).count.to_s+"/("+
                             number_with_delimiter(@let.where(modalidad:2).sum(:certificado).to_i,
                              delimiter: ",").to_s+ ")"} "
                   end
                end
            end
                 column("Corporativos", :class => 'text-right') do |formula|
                   if formula.cantidad==1 then
                   @auto=  formula.orden
                   @tita1=" "
                   @vopc1=7

                 @le1=Item.where(ejecucion:4,modalidad:1,tipo:formula.orden)
                       .where(exped2:@vaf).where(obac: @vuobac)

                 @le= @le1.count.to_s+ "/("+
                        number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                 link_to "#{@le} ", reports_comment_path(format: :pdf,
                 :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)
               else
                div :class =>"grueso" do
                  vnometi="#{@let.where(modalidad:1).count.to_s+"/("+
                           number_with_delimiter(@let.where(modalidad:1).sum(:certificado).to_i,
                            delimiter: ",").to_s+ ")"} "
               end
                end

             end

                 column("TOTAL", :class => 'text-right') do |formula|
               if formula.cantidad==1 then
                   @auto=  formula.orden
                   @tita1=" "
                   @vopc1=8

                   @ls1=   Item.where(ejecucion:4,tipo:formula.orden).where("modalidad<3")
                           .where(exped2:@vaf).where(obac: @vuobac)
                   @ls=   @ls1.count.to_s+ "/("+
                        number_with_delimiter(@ls1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                        link_to "#{@ls} ", reports_comment_path(format: :pdf,
                        :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)

                      else
                       div :class =>"grueso" do
                         vnometi="#{@let.where('modalidad<=2').count.to_s+"/("+
                                  number_with_delimiter(@let.where('modalidad<=2').sum(:certificado).to_i,
                                   delimiter: ",").to_s+ ")"} "
                      end
                       end

                 end






             end # de table for Mercado




           end # panel mercado





                                   panel  "IV.- SEGUIMIENTO DE PAC AF-" +@vaf1+ " - 'PAC/(SOLES)'" do


                                      table_for Formula.where(product_id:11).where('orden<=2').order('orden')  do
                                              @vxper=[0,0,0,0,0,0,0,0]
                                              @vpresu=[0,0,0,0,0,0,0,0]
                                              @vpac1=[]
                                              @vpac2=[]
                                              @vpac3=[]
                                              @vpac4=[]
                                              @vpac5=[]
                                              @vpac6=[]
                                              @vpac7=[]
                                              @itep=Item.where(ejecucion:4,exped2:@vaf).where("modalidad<3").where(obac: @vuobac)
                                              @itep.each do |ite|
                                              @proj=Formula.where(product_id:12,cantidad:20).select('orden')
                                              @deta3=Detail.where(item_id:ite.id).where.not(actividad:@proj).
                                                where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).
                                                order('details.pfecha DESC,details.id DESC')









                                                        if @deta3.count>0 then
                                                          @vactiv= @deta3.
                                                             select('actividad as dd').first.dd
                                                             @vactivfec= @deta3.
                                                                select('pfecha as dd').first.dd
                                                              else
                                                                @vactiv=78
                                                                @vactivfec=@vinicio

                                                          end

                                                          ################phase


                                                          if  Phase.where.not(expediente:0).where(expediente:ite.exped,convocatoria:1).count>0 then
                                                          if    Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).
                                                            activities.where.not(actividad:@proj).where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).count>0 then


                                                             @phase3=Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).activities
                                                                .where.not(actividad:@proj).where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).where("actividad<>83")
                                                                 .order('activities.pfecha DESC,activities.id DESC')




                                                           @vactiv2=@phase3.select('activities.actividad as dd').first.dd
                                                            @vactiv2fec=@phase3.select('activities.pfecha as dd').first.dd



                                                                if    @vactiv2fec>  @vactivfec then
                                                                   @vactiv=@vactiv2
                                                                end
                                                          else
                                                            vanno=Formula.where(product_id:11,orden:@vaf).select('nombre as dd').first.dd
                                                            if Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).
                                                              activities.where("pfecha>=? and extract(year from pfecha) = ?", @vinicio,vanno ).count>0  then



                                                              @phase3=Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).activities
                                                                 .where.not(actividad:@proj).where("pfecha>=? and extract(year  from pfecha) = ?", @vinicio,vanno  ).where("actividad<>83")
                                                                  .order('activities.pfecha DESC,activities.id DESC')




                                                            @vactiv2=@phase3.select('activities.actividad as dd').first.dd
                                                             @vactiv2fec=@phase3.select('activities.pfecha as dd').first.dd



                                                                 if    @vactiv2fec>  @vactivfec then
                                                                    @vactiv=@vactiv2
                                                                 end

                                                            end


                                                        end

                                                    end






################phase end

                                                                #linea 209
                                                        @vdir=Formula.where(product_id:12,orden:@vactiv).
                                                              select('cantidad as dd').first.dd
                                          #                @vdir=2
                                                          @vxper[@vdir]=@vxper[@vdir]+ 1
                                                          @vpresu[@vdir]=@vpresu[@vdir]+ ite.certificado.to_i
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


                                                 end
                                         column("Avance") do |formula|
                                           if formula.orden==1 then
                                     link_to "ACFFAA", reports_vhoja1_path(format:  "xlsx", :param1=> @vxper,
                                      :param2=> @vpresu, :param3=> @vpac1, :param4=> @vpac2,
                                      :param5=> @vpac3,:param6=> @vpac4,:param7=> @vpac5,
                                      :param8=> @vpac6,:param9=> @vpac7,:param10=> @vuobac)
                                        #  "PAC"
                                          else
                                            "Autorizados"
                                          end
                                         end
                                         column("S/EXP", :class => 'text-right') do |formula|
                                        if formula.orden==1 then
                                           @titproc1="PAC SIN EXPEDIENTE DE INICIO "
                                           @vpas=[0,1]
                                           @dpcl=   @vxper[0]+ @vxper[1]
                                                 link_to "#{@dpcl} ",
                                                  reports_comment7_path(format: :pdf,
                                                  :param3=> @vpas,
                                                  :param4=> @titproc1,:param5=> @vpac1)
                                          end
                                        end

                                       column("C/EXP", :class => 'text-right') do |formula|
                                         if formula.orden==1 then
                                        @dpc=  formula.orden
                                        @vpas=[2]
                                        @titproc1="PAC CON EXPEDIENTE DE INICIO"

                                        @dpcl=   @vxper[2]

                                               link_to "#{@dpcl} ",
                                               reports_comment7_path(format: :pdf,
                                              :param3=> @vpas,
                                              :param4=> @titproc1,:param5=> @vpac2)
                                         end
                                       end

                                         column("DC", :class => 'text-right') do |formula|
                                           if formula.orden==1 then

                                           @dpc=  formula.orden
                                           @vpas=[3]
                                           @titproc1="EXPEDIENTES EN CATALOGACION"
                                           @dpcl=   @vxper[3]
                                                 link_to "#{@dpcl} ",
                                                  reports_comment7_path(format: :pdf,
                                                  :param3=> @vpas,
                                                  :param4=> @titproc1,:param5=> @vpac3)

                                          end
                                        end

                                         column("DEM", :class => 'text-right') do |formula|
                                           if formula.orden==1 then
                                           @dpc=  formula.orden
                                           @vpas=[4]
                                           @titproc1="EXPEDIENTES EN ESTUDIO DE MERCADO"
                                           @dpcl=   @vxper[4]

                                                 link_to "#{@dpcl} ",
                                                  reports_comment7_path(format: :pdf,
                                                  :param3=> @vpas,
                                                  :param4=> @titproc1,:param5=> @vpac4)

                                          end
                                        end

                                         column("DPC", :class => 'text-right') do |formula|
                                           if formula.orden==1 then
                                         @dpc=  formula.orden
                                          @vpas=[5]
                                          @titproc1="EXPEDIENTES EN PROCESO DE COMPRAS"
                                           @dpcl=  @vxper[5]
                                                 link_to "#{@dpcl} ",
                                                  reports_comment7_path(format: :pdf,
                                                  :param3=> @vpas,
                                                  :param4=> @titproc1,:param5=> @vpac5)

                                          end
                                        end

                                         column("FC ", :class => 'text-right') do |formula|
                                           if formula.orden==1 then
                                           @dpc=  formula.orden
                                           @vpas=[6]
                                           @titproc1="EXPEDIENTES POR FIRMA DE CONTRATO"
                                           @dpcl=   @vxper[6]
                                                   link_to "#{@dpcl} ",
                                                   reports_comment7_path(format: :pdf,
                                                   :param3=> @vpas,
                                                   :param4=> @titproc1,:param5=> @vpac6)

                                         end
                                       end
                                         column("EC ", :class => 'text-right') do |formula|
                                           if formula.orden==1 then
                                           @dpc=  formula.orden
                                           @vpas=[7]
                                           @titproc1="EXPEDIENTES EN DEC"
                                           @dpcl=   @vxper[7]
                                                   link_to "#{@dpcl} ",
                                                   reports_comment7_path(format: :pdf,
                                                   :param3=> @vpas,
                                                   :param4=> @titproc1,:param5=> @vpac7)

                                         end
                                       end

                                        column("TOTAL ", :class => 'text-right') do |formula|
                                          if formula.orden==1 then

                                          @auto=  @vaf
                                          @tita1="Total Procesos en Curso ACFFAA - PERIODO"
                                          @vopc1=4
                                          @vxper0=@vxper
                                          @vpresu0=@vpresu
                                          @vpac10=@vpac1
                                          @vpac20=@vpac2
                                          @vpac30=@vpac3
                                          @vpac40= @vpac4
                                          @vpac50= @vpac5
                                          @le=  @vxper.inject(0, :+).to_s+ "/("+
                                          number_with_delimiter(@vpresu.inject(0, :+).to_i, delimiter: ",").to_s+ ")"
                                                "#{@le} "
                                         else

                                        vautoro=  Item.where(ejecucion:4,modalidad:3,exped2:@vaf,obac: @vuobac)
                                        vautors=  vautoro.sum(:certificado)
                                        vautorc=  vautoro.count.to_s
                                        vautor1=  number_with_delimiter(vautors.to_i, delimiter: ",").to_s
                                        vautor2= vautorc+"/("+vautor1+")"


                                        @tita1="AUTORIZADOS - PERIODO"
                                        @vopc1=6

                                        link_to vautor2, reports_comment2_path(format: :pdf,
                                        :param2=>  @vuobac,  :param3=>   @tita1,:param4=>   @vopc1)

                                       end
                                     end





                                    end # de table_for

                            end #end de panel














end
unless current_admin_user.categoria==24


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
#  li link_to "Personal por area evaluacion",    reports_vhoja4_path(format: "xlsx")
  li    link_to "Personal", "http://172.25.10.6:3001/admin/login"
end

#########################################

end #column 2












    end




  end # content



end
