ActiveAdmin.register_page "Dpc" do

  menu  priority: 2,label: "Procesos"


  content :title => proc {"PROCESOS  "+ Formula.where(product_id:11,orden:current_admin_user.periodo).select('descripcion as dd').first.dd }   do

    ##################
    Formula.where(product_id:1).update_all( numero:2 )
    case current_admin_user.categoria # a_variable is the variable we want to compare
  #  when 21
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

      $vaf=current_admin_user.periodo
       @vaf2=Formula.where(product_id:11,orden:$vaf).select('nombre as dd').first.dd
    case   $vaf
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
  #    column do

  case current_admin_user.categoria
  when 21,22,23,24,29


  else

#else de column abierto


########################################





case current_admin_user.categoria
when 1,2,3,26,4,6,8,9 #adm roy amador italo sectoristas
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

 end #de panel historial periodos

###############################
end

end # de case





#################
panel  "I.- ESTADO DE PROCESOS" + " - 'PROCESOS/(SOLES)'" do
@tabconta=0
aa=Formula.where(product_id:11).where('orden=? or orden=? or orden=20', $vaf, $vaf-1).order('orden')
    table_for aa do


      def execute3(var)
          # ###############   empieza seguimiento
          @vxper=[0,0,0,0,0,0,0,0]
          @vpresu=[0,0,0,0,0,0,0,0]
          @vpac1=[]
          @vpac2=[]
          @vpac3=[]
          @vpac4=[]
          @vpac5=[]
          @vpac6=[]
          @vpac7=[]
          @proj=Formula.where(product_id:12,cantidad:20).select('orden')
          @itep=Item.where(ejecucion:4,exped2:var).where("modalidad<3").where(obac: @vuobac)
          @itep.each do |ite|

          @deta3=Detail.where(item_id:ite.id).
            where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).where.not(actividad:@proj).
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
                        vanno=Formula.where(product_id:11,orden:$vaf).select('nombre as dd').first.dd
                        if Phase.where.not(expediente:0).where(convocatoria:1).find_by(expediente:ite.exped).
                          activities.where.not(actividad:@proj).where("pfecha>=? and extract(year from pfecha) = ?", @vinicio,vanno ).count>0  then



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
                  end# funcion excute3
       end

        def execute(var)

      @vxper3=[0,0,0,0,0,0,0,0]
      @contavus=[0,0,0,0,0,0,0,0]

      @vconv1=[]# actos previos
      @vconv2=[]# convocados
      @vconv3=[]# adjudicados
      @vconv4=[]# desiertos
      @vconv5=[]# no consenti
      @vconvt=[]# totalvinicio







      @vexped=Item.where(obac: @vuobac).where.not(exped:0).select('DISTINCT exped')
      @procp=Phase.where(convo:var,periodo:$vaf,expediente:@vexped).order('id')
      @procp .each do |proceso|  #each hata el final

          @deta4=Activity.where(phase_id:proceso.id).where.not(actividad:@proj).
                 where("pfecha>=?  ", @vinicio ).
                 order('pfecha DESC,id DESC')







               if @deta4.count>0 then  #if 1
                 if @deta4.where("pfecha<=?  ", @vfin ).count>0 then
                    @vactiv3= @deta4.where("pfecha<=?  ", @vfin ).select('actividad as dd').first.dd
                    @vdir=Formula.where(product_id:12,orden:@vactiv3).
                         select('cantidad as dd').first.dd
                #    @vxper2[@vdir]=@vxper2[@vdir]+ 1
                 else
                    @vdir=5
                #    @vxper2[@vdir]=@vxper2[@vdir]+ 1
                 end








               @vconv=0

                vconsen=Piece.where(phase_id:proceso.id).where('estado=2 or estado=11 ').count
                vadjud=Piece.where(phase_id:proceso.id,estado:4).count
                vapel=Piece.where(phase_id:proceso.id,estado:9).count


                 if @deta4.where(actividad:20).count>0 and @vdir>4 then
                    @vconv=2
                 else
                    if @vdir>1 then
                       if proceso.convocatoria==1 then
                         @vconv=1
                       else
                         @vconv=4
                       end
                    end
                  end

                  if  vapel>0 or vadjud>0    then
                     @vconv=5
                  end

                  if vconsen>0   then
                     @vconv=3
                  end




              case @vconv
              when 1 #previos
                  @vconv1.push(proceso.id)
                  @vxper3[1]=@vxper3[1]+1
                  Phase.where(id:proceso.id).update_all( sele3:1 )
                   if proceso.moneda and proceso.valor then

                        @vpv=Formula.where(product_id:7,orden:proceso.moneda,numero:$vaf)
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

               when 2 #convocados
                    @vconv2.push(proceso.id)
                    @vxper3[2]=@vxper3[2]+1
                      Phase.where(id:proceso.id).update_all( sele3:2 )
                    if proceso.valor then

                       @vpv=Formula.where(product_id:7,orden:proceso.moneda,numero:$vaf)
                             .select('cantidad as dd').first.dd.to_i*proceso.valor/100

                       @contavus[2]=  @contavus[2]+@vpv
                        Phase.where(id:proceso.id).update_all( sele2:@vpv )
                    end
                    @vpp=Activity.where(phase_id:proceso.id,actividad:20)
                    .select('pfecha as dd').first.dd
                    Phase.where(id:proceso.id).update_all( pp:@vpp )



                when 3 #consentidos
                    @vconv3.push(proceso.id)
                    @vxper3[3]=@vxper3[3]+1
                      Phase.where(id:proceso.id).update_all( sele3:3 )
                    @vpv=0
                     if  Piece.where(phase_id:proceso.id).
                           where("adjudicado IS NOT NULL and moneda IS NOT NULL and (estado=2 or estado=11)").count>0  then
                           Piece.where(phase_id:proceso.id).
                           where("adjudicado IS NOT NULL  and moneda IS NOT NULL and (estado=2 or estado=11)").each do |adju|
                           @vpv=@vpv+adju.adjudicado*Formula.where(product_id:7,orden:adju.moneda,numero:$vaf)
                           .select('cantidad as dd').first.dd.to_i/100
                     end
                     end

                          @contavus[3]=  @contavus[3]+@vpv
                          Phase.where(id:proceso.id).update_all( sele2:@vpv )

                         @vpp=Activity.where(phase_id:proceso.id,actividad:20)
                             .select('pfecha as dd').first.dd
                           Phase.where(id:proceso.id).update_all( pp:@vpp )

                         if  vapel>0 or vadjud>0    then
                              @vconv5.push(proceso.id)
                              @vpv=0
                            if  Piece.where(phase_id:proceso.id).where("adjudicado IS NOT NULL and moneda IS NOT NULL  and (estado=4 or estado=9)").count>0  then
                                Piece.where(phase_id:proceso.id).where("adjudicado IS NOT NULL and moneda IS NOT NULL  and (estado=4 or estado=9)").each do |adju|
                                @vpv=@vpv+adju.adjudicado*Formula.where(product_id:7,orden:adju.moneda,numero:$vaf)
                                .select('cantidad as dd').first.dd.to_i/100
                               end
                            end

                            @contavus[5]=  @contavus[5]+@vpv


                        end
                  when 4 #de desiertos
                      @vconv4.push(proceso.id)
                      @vxper3[4]=@vxper3[4]+1
                        Phase.where(id:proceso.id).update_all( sele3:1)

                     if proceso.moneda and proceso.valor then

                         @vpv=Formula.where(product_id:7,orden:proceso.moneda,numero:$vaf)
                              .select('cantidad as dd').first.dd.to_i*proceso.valor/100


                         @contavus[4]=  @contavus[4]+ @vpv
                         Phase.where(id:proceso.id).update_all( sele2:@vpv )
                     end

                       if Activity.where(phase_id:proceso.id,actividad:34).count>0 then
                        @vpp=Activity.where(phase_id:proceso.id,actividad:34)
                             .select('pfecha as dd').first.dd
                          Phase.where(id:proceso.id).update_all( pp:@vpp )
                       else
                         Phase.where(id:proceso.id).update_all( pp:Time.now )
                       end


                  when 5 #adjudicados

                          @vxper3[5]=@vxper3[5]+1
                            Phase.where(id:proceso.id).update_all( sele3:5 )
                          @vconv5.push(proceso.id)
                          @vpv=0
                         if  Piece.where(phase_id:proceso.id).
                           where("adjudicado IS NOT NULL and moneda IS NOT NULL  and (estado=4 or estado=9)").count>0  then
                               Piece.where(phase_id:proceso.id).
                               where("adjudicado IS NOT NULL and moneda IS NOT NULL  and (estado=4 or estado=9)").each do |adju|
                            @vpv=@vpv+adju.adjudicado*Formula.where(product_id:7,orden:adju.moneda,numero:$vaf)
                            .select('cantidad as dd').first.dd.to_i/100
                        end
                        end

                             @contavus[5]=  @contavus[5]+@vpv
                              Phase.where(id:proceso.id).update_all( sele2:@vpv )

                            @vpp=Activity.where(phase_id:proceso.id,actividad:20)
                            .select('pfecha as dd').first.dd
                            Phase.where(id:proceso.id).update_all( pp:@vpp )

                 else
                   if proceso.moneda and proceso.valor then

                        @vpv=Formula.where(product_id:7,orden:proceso.moneda,numero:$vaf)
                              .select('cantidad as dd').first.dd.to_i*proceso.valor/100


                          Phase.where(id:proceso.id).update_all( sele2:@vpv )
                   end

                 end #case


               case @vconv
                  when 1,2,3,4,5
                   @vconvt.push(proceso.id)
                   @vxper3[0]=@vxper3[0]+1


                end

            end # if
          end #each





end





column("Procesos") do |formula|
  unless formula.orden==20
  conv1=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:1).where('sele>4').
             select('id').map {|e| e.attributes.values}.flatten
  conv2=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:2).
              select('id').map {|e| e.attributes.values}.flatten
  conv3=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:3).
              select('id').map {|e| e.attributes.values}.flatten
  conv4=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:4).where('sele>4').
              select('id').map {|e| e.attributes.values}.flatten
  conv5=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:5).
              select('id').map {|e| e.attributes.values}.flatten
  convt=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:1).
              select('id').map {|e| e.attributes.values}.flatten
   pac1=Item.where(ejecucion:4,exped2:formula.orden,cuadrante:1).where("modalidad<3").
               select('id').map {|e| e.attributes.values}.flatten
   pac2=Item.where(ejecucion:4,exped2:formula.orden,cuadrante:2).where("modalidad<3").
               select('id').map {|e| e.attributes.values}.flatten
   pac3=Item.where(ejecucion:4,exped2:formula.orden,cuadrante:3).where("modalidad<3").
              select('id').map {|e| e.attributes.values}.flatten
   pac4=Item.where(ejecucion:4,exped2:formula.orden,cuadrante:4).where("modalidad<3").
               select('id').map {|e| e.attributes.values}.flatten
   pac5=Item.where(ejecucion:4,exped2:formula.orden,cuadrante:5).where("modalidad<3").
               select('id').map {|e| e.attributes.values}.flatten


     link_to "DEL-AF"+"#{formula.nombre}", reports_vhoja21_path(format:  "xlsx",
       :param3=> conv1, :param4=>conv4,
       :param5=> conv3,:param6=> convt,:param8=>conv2,
       :param17=> conv5,:param13=> pac1, :param14=> pac2,
       :param15=> pac3,:param16=> pac4,
       :param18=> pac5,:param7=> @vuobac)
   else

     conv1=Phase.where(periodo:$vaf,sele3:1).where('sele>4').
                select('id').map {|e| e.attributes.values}.flatten
     conv2=Phase.where(periodo:$vaf,sele3:2).
                 select('id').map {|e| e.attributes.values}.flatten
     conv3=Phase.where(periodo:$vaf,sele3:3).
                 select('id').map {|e| e.attributes.values}.flatten
     conv4=Phase.where(periodo:$vaf,sele3:4).where('sele>4').
                 select('id').map {|e| e.attributes.values}.flatten
     conv5=Phase.where(periodo:$vaf,sele3:5).
                 select('id').map {|e| e.attributes.values}.flatten
     convt=Phase.where(periodo:$vaf,sele3:1).
                 select('id').map {|e| e.attributes.values}.flatten
      pac1=Item.where(ejecucion:4,cuadrante:1).where('exped2=? or exped2=?',$vaf,$vaf-1).where("modalidad<3").
                  select('id').map {|e| e.attributes.values}.flatten
      pac2=Item.where(ejecucion:4,cuadrante:2).where('exped2=? or exped2=?',$vaf,$vaf-1).where("modalidad<3").
                  select('id').map {|e| e.attributes.values}.flatten
      pac3=Item.where(ejecucion:4,cuadrante:3).where('exped2=? or exped2=?',$vaf,$vaf-1).where("modalidad<3").
                 select('id').map {|e| e.attributes.values}.flatten
      pac4=Item.where(ejecucion:4,cuadrante:4).where('exped2=? or exped2=?',$vaf,$vaf-1).where("modalidad<3").
                  select('id').map {|e| e.attributes.values}.flatten
      pac5=Item.where(ejecucion:5,cuadrante:1).where('exped2=? or exped2=?',$vaf,$vaf-1).where("modalidad<3").
                  select('id').map {|e| e.attributes.values}.flatten

div :class =>"grueso" do
        link_to "#{formula.nombre}", reports_vhoja21_path(format:  "xlsx",
          :param3=> conv1, :param4=>conv4,
          :param5=> conv3,:param6=> convt,:param8=>conv2,
          :param17=> conv5,:param13=> pac1, :param14=> pac2,
          :param15=> pac3,:param16=> pac4,
          :param18=> pac5,:param7=> @vuobac)
end

   end

end


column("EN GEX O DC", :class => 'text-right') do |formula|
    unless formula.orden==20
  @dpc=  formula.orden
  @titproc1="EN GEX O DC"
  @vopc=4
  vphase=Phase.where(convo:formula.orden ,periodo:$vaf).
             where('sele3=1 or sele3=4').where.not(sele:1).where("sele=2 or sele=3")
  conv14=vphase.select('id').
             map {|e| e.attributes.values}.flatten
  expr314=vphase.count
  cotavus14=vphase.sum(:sele2)

 link_to   "#{expr314}"+" / ("+"#{number_with_delimiter(cotavus14.to_i, delimiter: ",")}"+")",
  reports_comment4_path(format: :pdf,  :param1=>  @vopc,   :param2=>  conv14,
   :param4=>  @titproc1)
    else
      @dpc=  formula.orden
      @titproc1="TOTAL EN GEX O DC"
      @vopc=4
      vphase=Phase.where(periodo:$vaf).
                 where('sele3=1 or sele3=4').where.not(sele:1).where("sele=2 or sele=3")
      conv14=vphase.select('id').
                 map {|e| e.attributes.values}.flatten
      expr314=vphase.count
      cotavus14=vphase.sum(:sele2)
    div :class =>"grueso" do
     link_to   "#{expr314}"+" / ("+"#{number_with_delimiter(cotavus14.to_i, delimiter: ",")}"+")",
      reports_comment4_path(format: :pdf,  :param1=>  @vopc,   :param2=>  conv14,
       :param4=>  @titproc1)
    end
    end
 end

###############


column("EN DEM", :class => 'text-right') do |formula|
unless formula.orden==20

  @dpc=  formula.orden
  @titproc1="EN DEM"
  @vopc=4
  vphase=Phase.where(convo:formula.orden ,periodo:$vaf).
             where('sele3=1 or sele3=4').where.not(sele:1).where(sele:4)
  conv14=vphase.select('id').
             map {|e| e.attributes.values}.flatten
  expr314=vphase.count
  cotavus14=vphase.sum(:sele2)

 link_to   "#{expr314}"+" / ("+"#{number_with_delimiter(cotavus14.to_i, delimiter: ",")}"+")",
  reports_comment4_path(format: :pdf,  :param1=>  @vopc,   :param2=>  conv14,
   :param4=>  @titproc1)
else
  @dpc=  formula.orden
  @titproc1="TOTAL EN DEM"
  @vopc=4
  vphase=Phase.where(periodo:$vaf).
             where('sele3=1 or sele3=4').where.not(sele:1).where(sele:4)
  conv14=vphase.select('id').
             map {|e| e.attributes.values}.flatten
  expr314=vphase.count
  cotavus14=vphase.sum(:sele2)
  div :class =>"grueso" do
      link_to   "#{expr314}"+" / ("+"#{number_with_delimiter(cotavus14.to_i, delimiter: ",")}"+")",
      reports_comment4_path(format: :pdf,  :param1=>  @vopc,   :param2=>  conv14,
      :param4=>  @titproc1)
  end
 end

 end


###########
 column("NO CONVOCADOS", :class => 'text-right') do |formula|
  unless formula.orden==20
   @dpc=  formula.orden
   @titproc1="NO CONVOCADOS DEC"
   @vopc=4
   vphase=Phase.where(convo:formula.orden ,periodo:$vaf).
              where('sele3=1 or sele3=4').where.not(sele:1).where(sele:5)
   conv14=vphase.select('id').
              map {|e| e.attributes.values}.flatten
   expr314=vphase.count
   cotavus14=vphase.sum(:sele2)

  link_to   "#{expr314}"+" / ("+"#{number_with_delimiter(cotavus14.to_i, delimiter: ",")}"+")",
   reports_comment4_path(format: :pdf,  :param1=>  @vopc,   :param2=>  conv14,
    :param4=>  @titproc1)

  else
    @dpc=  formula.orden
    @titproc1="NO CONVOCADOS DEC"
    @vopc=4
    vphase=Phase.where(periodo:$vaf).
               where('sele3=1 or sele3=4').where.not(sele:1).where(sele:5)
    conv14=vphase.select('id').
               map {|e| e.attributes.values}.flatten
    expr314=vphase.count
    cotavus14=vphase.sum(:sele2)
   div :class =>"grueso" do
       link_to   "#{expr314}"+" / ("+"#{number_with_delimiter(cotavus14.to_i, delimiter: ",")}"+")",
       reports_comment4_path(format: :pdf,  :param1=>  @vopc,   :param2=>  conv14,
       :param4=>  @titproc1)
    end
  end

  end




 column("convocados", :class => 'text-right') do |formula|
execute(formula.orden)

  unless formula.orden==20
   @dpc=  formula.orden
   @titproc1="Procesos Convocados"
   @vopc=1
   vphase=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:2)
   conv2=vphase.select('id').map {|e| e.attributes.values}.flatten
   expr2=vphase.count

   cotavus2=vphase.sum(:sele2)


     link_to "#{expr2}"+" / ("+"#{number_with_delimiter(cotavus2.to_i, delimiter: ",")}"+")",
      reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv2,
     :param4=>  @titproc1)

   else
     @dpc=  formula.orden
     @titproc1="Procesos Convocados"
     @vopc=1
     vphase=Phase.where(periodo:$vaf,sele3:2)
     conv2=vphase.select('id').map {|e| e.attributes.values}.flatten
     expr2=vphase.count

     cotavus2=vphase.sum(:sele2)

    div :class =>"grueso" do
      link_to "#{expr2}"+" / ("+"#{number_with_delimiter(cotavus2.to_i, delimiter: ",")}"+")",
       reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv2,
      :param4=>  @titproc1)
    end
   end
  end


#######1

  column("Adjudicados", :class => 'text-right') do |formula|
    unless formula.orden==20
      @dpc=  formula.orden
      @titproc1="Procesos No Consentidos"
      @vopc=3
      vphase=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:5)
      conv5=vphase.select('id').map {|e| e.attributes.values}.flatten
      expr5=vphase.count

      cotavus5=vphase.sum(:sele2)

    link_to "#{expr5}"+" / ("+"#{number_with_delimiter(cotavus5.to_i, delimiter: ",")}"+")",
    reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv5,
    :param4=>  @titproc1)
     else
       @dpc=  formula.orden
       @titproc1="Procesos No Consentidos"
       @vopc=3
       vphase=Phase.where(periodo:$vaf,sele3:5)
       conv5=vphase.select('id').map {|e| e.attributes.values}.flatten
       expr5=vphase.count

       cotavus5=vphase.sum(:sele2)
         div :class =>"grueso" do
            link_to "#{expr5}"+" / ("+"#{number_with_delimiter(cotavus5.to_i, delimiter: ",")}"+")",
            reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv5,
           :param4=>  @titproc1)
        end
     end
  end

#######2
column("Consentidos", :class => 'text-right') do |formula|
    unless formula.orden==20
    @dpc=  formula.orden
    @titproc1="Procesos Adjudicados"
    @vopc=2
    vphase=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:3)
    conv3=vphase.select('id').map {|e| e.attributes.values}.flatten
    expr3=vphase.count

    cotavus3=vphase.sum(:sele2)

  link_to "#{expr3}"+" / ("+"#{number_with_delimiter(cotavus3.to_i, delimiter: ",")}"+")",
  reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv3,
  :param4=>  @titproc1)
  else

    @dpc=  formula.orden
    @titproc1="Procesos Adjudicados"
    @vopc=2
    vphase=Phase.where(periodo:$vaf,sele3:3)
    conv3=vphase.select('id').map {|e| e.attributes.values}.flatten
    expr3=vphase.count

    cotavus3=vphase.sum(:sele2)
       div :class =>"grueso" do
        link_to "#{expr3}"+" / ("+"#{number_with_delimiter(cotavus3.to_i, delimiter: ",")}"+")",
        reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv3,
        :param4=>  @titproc1)
       end

  end

end





 column("Total", :class => 'text-right') do |formula|
unless formula.orden==20
vphase=Phase.where(convo:formula.orden ,periodo:$vaf)
expr0=vphase.where.not(sele:1).count
cotavus0=vphase.where.not(sele:1).sum(:sele2)



     if expr0>0 then
       link_to "#{expr0}"+" / ("+"#{number_with_delimiter(cotavus0.to_i, delimiter: ",")}"+")",
        reports_vhoja20_path(format:  "xlsx",
               :param7=> @vuobac)

     else
       "#{expr0}"+" / ("+"#{number_with_delimiter(cotavus0.to_i, delimiter: ",")}"+")"
     end
   else
     vphase=Phase.where(periodo:$vaf)
     expr0=vphase.where.not(sele:1).count
     cotavus0=vphase.where.not(sele:1).sum(:sele2)


         div :class =>"grueso" do
          if expr0>0 then
            link_to "#{expr0}"+" / ("+"#{number_with_delimiter(cotavus0.to_i, delimiter: ",")}"+")",
             reports_vhoja20_path(format:  "xlsx",
                    :param7=> @vuobac)

          else
            "#{expr0}"+" / ("+"#{number_with_delimiter(cotavus0.to_i, delimiter: ",")}"+")"
          end

        end
    end



end #de table


####################




end


end##################################estatus



#################   ani 1
   panel  "II.- SEGUIMIENTO DE PROCESOS"+ " - 'PROCESOS/(SOLES)'"  do

 aa=Formula.where(product_id:11).where('orden=? or orden=? or orden=20', $vaf, $vaf-1).order('orden')
     table_for aa do


def execute2(var)


      @proj=Formula.where(product_id:12,cantidad:20).select('orden')

    @vexped=Item.where(obac: @vuobac).where.not(exped:0).select('DISTINCT exped')
    @procp=Phase.where(convo:var,periodo:$vaf,expediente:@vexped).order('id')
    @procp .each do |proceso|  #each hasta el final

        @deta4=Activity.where(phase_id:proceso.id).
               where("pfecha>=?  ", @vinicio ).where.not(actividad:@proj).
               order('pfecha DESC,id DESC')



             if @deta4.count>0 then  #if 1
               if @deta4.where("pfecha<=?  ", @vfin ).count>0 then
                  @vactiv3= @deta4.where("pfecha<=?  ", @vfin ).select('actividad as dd').first.dd
                  @vdir=Formula.where(product_id:12,orden:@vactiv3).
                       select('cantidad as dd').first.dd

               else
                  @vdir=5

               end





                 case @vdir
                 when 1

                   Phase.where(id:proceso.id).update_all( sele:1 )
                 when 2

                   Phase.where(id:proceso.id).update_all( sele:2 )
                 when 3

                   Phase.where(id:proceso.id).update_all( sele:3 )
                 when 4

                   Phase.where(id:proceso.id).update_all( sele:4 )
                   when 5

                     Phase.where(id:proceso.id).update_all( sele:5 )
                   when 6

                      Phase.where(id:proceso.id).update_all(sele:6  )
                    when 7

                       Phase.where(id:proceso.id).update_all(sele:7  )
                  end #case

    end


              end# de if 1


    end# del each









     column("Procesos") do |formula|
              execute2(formula.orden)
        unless formula.orden==20
             "DEL-AF"+formula.nombre
        else
            div :class =>"grueso" do
            "TOTAL"
            end
        end
     end
     column("N/D/C", :class => 'text-right') do |formula|
     unless formula.orden==20
       @dpc=  formula.orden
       @vpaso=0
       @vpas=1
       @titproc1="PROCESOS EN ESTADO NULO, DESIERTO O CANCELADO"
       phase=Phase.where(convo:formula.orden ,periodo:$vaf,sele:1)
       le= phase.count
       sle= phase.sum(:sele2)
       @vpro11=phase.select('id').map {|e| e.attributes.values}.flatten
       link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro11,:param2=> @vpaso)
    else
      @dpc=  formula.orden
      @vpaso=0
      @vpas=1
      @titproc1="PROCESOS EN ESTADO NULO, DESIERTO O CANCELADO"
      phase=Phase.where(periodo:$vaf,sele:1)
      le= phase.count
      sle= phase.sum(:sele2)
      @vpro11=phase.select('id').map {|e| e.attributes.values}.flatten

        div :class =>"grueso" do
         link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
         reports_comment5_path(format: :pdf,
         :param3=> @vpas,
         :param4=> @titproc1,:param5=> @vpro11,:param2=> @vpaso)
       end
    end





      end


     column("GEX", :class => 'text-right') do |formula|
       unless formula.orden==20
       @dpc=  formula.orden
       @vpaso=0
       @vpas=2
       @titproc1="PROCESOS EN GEX"
         phase=Phase.where(convo:formula.orden ,periodo:$vaf,sele:2)
       le= phase.count
       sle= phase.sum(:sele2)
       @vpro12=phase.select('id').map {|e| e.attributes.values}.flatten
       link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro12,:param2=> @vpaso)
      else
        @dpc=  formula.orden
        @vpaso=0
        @vpas=2
        @titproc1="PROCESOS EN GEX"
          phase=Phase.where(periodo:$vaf,sele:2)
        le= phase.count
        sle= phase.sum(:sele2)
        @vpro12=phase.select('id').map {|e| e.attributes.values}.flatten

          div :class =>"grueso" do
            link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
            reports_comment5_path(format: :pdf,
            :param3=> @vpas,
            :param4=> @titproc1,:param5=> @vpro12,:param2=> @vpaso)

         end
       end
      end


     column("DC", :class => 'text-right') do |formula|
       unless formula.orden==20
       @dpc=  formula.orden
       @vpaso=0
       @vpas=3
       @titproc1="PROCESOS EN DC"
          phase=Phase.where(convo:formula.orden ,periodo:$vaf,sele:3)
       le=phase.count
       sle= phase.sum(:sele2)
       @vpro13=phase.select('id').map {|e| e.attributes.values}.flatten
       link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro13,:param2=> @vpaso)
       else
         @dpc=  formula.orden
         @vpaso=0
         @vpas=3
         @titproc1="PROCESOS EN DC"
            phase=Phase.where(periodo:$vaf,sele:3)
         le=phase.count
         sle= phase.sum(:sele2)
         @vpro13=phase.select('id').map {|e| e.attributes.values}.flatten
           div :class =>"grueso" do
              link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
             reports_comment5_path(format: :pdf,
             :param3=> @vpas,
            :param4=> @titproc1,:param5=> @vpro13,:param2=> @vpaso)
          end
       end

      end


     column("DEM", :class => 'text-right') do |formula|
      unless formula.orden==20
       @dpc=  formula.orden
       @vpaso=0
       @vpas=4
       @titproc1="PROCESOS EN DEM"
       phase=Phase.where(convo:formula.orden ,periodo:$vaf,sele:4)
       le= phase.count
       sle= phase.sum(:sele2)
       @vpro14=phase.select('id').map {|e| e.attributes.values}.flatten
        link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro14,:param2=> @vpaso)
      else
        @dpc=  formula.orden
        @vpaso=0
        @vpas=4
        @titproc1="PROCESOS EN DEM"
        phase=Phase.where(periodo:$vaf,sele:4)
        le= phase.count
        sle= phase.sum(:sele2)
        @vpro14=phase.select('id').map {|e| e.attributes.values}.flatten

        div :class =>"grueso" do
         link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
        reports_comment5_path(format: :pdf,
        :param3=> @vpas,
        :param4=> @titproc1,:param5=> @vpro14,:param2=> @vpaso)
        end
      end

    end

     column("DPC", :class => 'text-right') do |formula|
       unless formula.orden==20
       @dpc=  formula.orden
       @vpaso=0
       @vpas=5
       @titproc1="PROCESOS EN DPC"
       phase=Phase.where(convo:formula.orden ,periodo:$vaf,sele:5)
       le= phase.count
       sle= phase.sum(:sele2)
       @vpro15=phase.select('id').map {|e| e.attributes.values}.flatten
         link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro15,:param2=> @vpaso)
       else
         @dpc=  formula.orden
         @vpaso=0
         @vpas=5
         @titproc1="PROCESOS EN DPC"
         phase=Phase.where(periodo:$vaf,sele:5)
         le= phase.count
         sle= phase.sum(:sele2)
         @vpro15=phase.select('id').map {|e| e.attributes.values}.flatten
         div :class =>"grueso" do
           link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
         reports_comment5_path(format: :pdf,
         :param3=> @vpas,
         :param4=> @titproc1,:param5=> @vpro15,:param2=> @vpaso)
         end
     end
      end

      column("FC", :class => 'text-right') do |formula|
       unless formula.orden==20
        @dpc=  formula.orden
          @vpaso=0
        @vpas=6
        @titproc1="PROCESOS PREVIOS A FIRMA DE CONTRATO"
        phase=Phase.where(convo:formula.orden ,periodo:$vaf,sele:6)
        le= phase.count
        sle= phase.sum(:sele2)
        @vpro16=phase.select('id').map {|e| e.attributes.values}.flatten
         link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
        reports_comment5_path(format: :pdf,
        :param3=> @vpas,
        :param4=> @titproc1,:param5=> @vpro16,:param2=> @vpaso)
        else
          @dpc=  formula.orden
            @vpaso=0
          @vpas=6
          @titproc1="PROCESOS PREVIOS A FIRMA DE CONTRATO"
          phase=Phase.where(periodo:$vaf,sele:6)
          le= phase.count
          sle= phase.sum(:sele2)
          @vpro16=phase.select('id').map {|e| e.attributes.values}.flatten

          div :class =>"grueso" do
           link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
          reports_comment5_path(format: :pdf,
          :param3=> @vpas,
          :param4=> @titproc1,:param5=> @vpro16,:param2=> @vpaso)

        end
      end
      end

        column("EC", :class => 'text-right') do |formula|
        unless formula.orden==20
          @dpc=  formula.orden
            @vpaso=0
          @vpas=7
          @titproc1="PROCESOS EN EJECUCION CONTRACTUAL"
          phase=Phase.where(convo:formula.orden ,periodo:$vaf,sele:7)
          le= phase.count
          sle= phase.sum(:sele2)
          @vpro17=phase.select('id').map {|e| e.attributes.values}.flatten
           link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
          reports_comment5_path(format: :pdf,
          :param3=> @vpas,
          :param4=> @titproc1,:param5=> @vpro17,:param2=> @vpaso)
          else
            @dpc=  formula.orden
              @vpaso=0
            @vpas=7
            @titproc1="PROCESOS EN EJECUCION CONTRACTUAL"
            phase=Phase.where(periodo:$vaf,sele:7)
            le= phase.count
            sle= phase.sum(:sele2)
            @vpro17=phase.select('id').map {|e| e.attributes.values}.flatten

            div :class =>"grueso" do
             link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
            reports_comment5_path(format: :pdf,
            :param3=> @vpas,
            :param4=> @titproc1,:param5=> @vpro17,:param2=> @vpaso)

          end
       end

      end
      column("TOTAL", :class => 'text-right') do |formula|
       unless formula.orden==20
        @dpc=  formula.orden
          @vpaso=1
        @vpas=[1,2,3,4,5,6,7]
        @titproc1="RELACION DE PROCESOS"
        phase=Phase.where(convo:formula.orden ,periodo:$vaf)
        le= phase.count
        sle= phase.sum(:sele2)
        @vpro1t=phase.select('id').map {|e| e.attributes.values}.flatten
       link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
        reports_comment5_path(format: :pdf,
        :param3=> @vpas,
        :param4=> @titproc1,:param5=> @vpro1t,:param2=> @vpaso)
        else
          @dpc=  formula.orden
            @vpaso=1
          @vpas=[1,2,3,4,5,6,7]
          @titproc1="RELACION DE PROCESOS"
          phase=Phase.where(periodo:$vaf)
          le= phase.count
          sle= phase.sum(:sele2)
          @vpro1t=phase.select('id').map {|e| e.attributes.values}.flatten
          div :class =>"grueso" do
         link_to   "#{le}"+" / ("+"#{number_with_delimiter(sle.to_i, delimiter: ",")}"+")",
          reports_comment5_path(format: :pdf,
          :param3=> @vpas,
          :param4=> @titproc1,:param5=> @vpro1t,:param2=> @vpaso)

        end



      end


      end








end
##############


      end # panel
#########################seguinmiento end
#########################################
case current_admin_user.categoria
when 1,2,3
    panel  link_to "INGRESO PERSONAL", "http://172.25.10.6:3001/admin/login" do
  #  li    link_to "Personal", "https://secure-harbor-85875.herokuapp.com"
  #   li    link_to "INGRESO PERSONAL", "http://172.25.10.6:3001/admin/login"
  #  li    link_to "Compras local", "http://172.25.10.6:3000/admin/login"
   end
   panel link_to "IR A ARTICULOS", admin_phases_path do
 #  li    link_to "Personal", "https://secure-harbor-85875.herokuapp.com"
 #   li    link_to "INGRESO PERSONAL", "http://172.25.10.6:3001/admin/login"
 #  li    link_to "Compras local", "http://172.25.10.6:3000/admin/login"
  end
end

###### leyenda
panel  "Leyenda" do
li "N/D/C: En estado Nulo,Desierto o Cancelado"
  li "GEX: Proceso en Gestion de Expediente ACFFAA"
    li "DC: Dirección de Catalogación ACFFAA"
      li "DEM: Dirección de Estudio de Mercado ACFFAA"
        li "DPC: Dirección de Procesos de Compras ACFFAA"
         li "FC: Previo a Firma de Contrato ACFFAA "
          li "EC:En Ejecucion de Contrato"





end
################################ ani1
  #   end #colum




#column do

  #################dddd estatus


 end   #column
#end  #columns
end #content
end #pag
