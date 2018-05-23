ActiveAdmin.register_page "Dpc" do

  menu  priority: 2,label: "Procesos"


  content title: "Procesos" do

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






#################
panel  "I.- ESTATUS DE PROCESOS-AF"+@vaf2 + " - 'PROCESOS/(SOLES)'" do
@tabconta=0
aa=Formula.where(product_id:11).where('orden=? or orden=?', $vaf, $vaf-1).order('orden')
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





column("Convocatoria") do |formula|

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


     link_to "PAC-AF"+"#{formula.nombre}", reports_vhoja21_path(format:  "xlsx",
       :param3=> conv1, :param4=>conv4,
       :param5=> conv3,:param6=> convt,:param8=>conv2,
       :param17=> conv5,:param13=> pac1, :param14=> pac2,
       :param15=> pac3,:param16=> pac4,
       :param18=> pac5,:param7=> @vuobac)


end



column("PREVIOS", :class => 'text-right') do |formula|

  @dpc=  formula.orden
  @titproc1="En Proceso"
  @vopc=4
  conv14=Phase.where(convo:formula.orden ,periodo:$vaf).
             where('sele3=1 or sele3=4').where.not(sele:1).select('id').
             map {|e| e.attributes.values}.flatten
  expr314=Phase.where(convo:formula.orden ,periodo:$vaf).
           where('sele3=1 or sele3=4').where.not(sele:1).count
  cotavus14=Phase.where(convo:formula.orden ,periodo:$vaf).
           where('sele3=1 or sele3=4').where.not(sele:1).sum(:sele2)

 link_to   "#{expr314}"+"/("+"#{number_with_delimiter(cotavus14.to_i, delimiter: ",")}"+")",
  reports_comment4_path(format: :pdf,  :param1=>  @vopc,   :param2=>  conv14,
   :param4=>  @titproc1)

 end







 column("convocados", :class => 'text-right') do |formula|
execute(formula.orden)
   @dpc=  formula.orden
   @titproc1="Procesos Convocados"
   @vopc=1
   conv2=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:2).
              select('id').map {|e| e.attributes.values}.flatten
   expr2=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:2).count

   cotavus2=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:2).sum(:sele2)


link_to "#{expr2}"+"/("+"#{number_with_delimiter(cotavus2.to_i, delimiter: ",")}"+")",
reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv2,
:param4=>  @titproc1)

  end



  column("Adjudicados", :class => 'text-right') do |formula|

      @dpc=  formula.orden
      @titproc1="Procesos No Consentidos"
      @vopc=3
      conv5=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:5).
                 select('id').map {|e| e.attributes.values}.flatten
      expr5=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:5).count

      cotavus5=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:5).sum(:sele2)

    link_to "#{expr5}"+"/("+"#{number_with_delimiter(cotavus5.to_i, delimiter: ",")}"+")",
    reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv5,
    :param4=>  @titproc1)

  end


  column("Consentidos", :class => 'text-right') do |formula|

    @dpc=  formula.orden
    @titproc1="Procesos Adjudicados"
    @vopc=2
    conv3=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:3).
               select('id').map {|e| e.attributes.values}.flatten
    expr3=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:3).count

    cotavus3=Phase.where(convo:formula.orden ,periodo:$vaf,sele3:3).sum(:sele2)

  link_to "#{expr3}"+"/("+"#{number_with_delimiter(cotavus3.to_i, delimiter: ",")}"+")",
  reports_comment4_path(format: :pdf,  :param1=>  @vopc, :param2=>  conv3,
  :param4=>  @titproc1)

end





 column("Total", :class => 'text-right') do |formula|

expr0=Phase.where(convo:formula.orden ,periodo:$vaf).
          where.not(sele:1).count
cotavus0=Phase.where(convo:formula.orden ,periodo:$vaf).
          where.not(sele:1).sum(:sele2)



     if expr0>0 then
       link_to "#{expr0}"+"/("+"#{number_with_delimiter(cotavus0.to_i, delimiter: ",")}"+")",
        reports_vhoja20_path(format:  "xlsx",
               :param7=> @vuobac)

     else
       "#{expr0}"+"/("+"#{number_with_delimiter(cotavus0.to_i, delimiter: ",")}"+")"
     end

    end



end #de table





end##################################estatus



#################   ani 1
   panel  "II.- SEGUIMIENTO DE PROCESOS-AF" +@vaf2  do

 aa=Formula.where(product_id:11).where('orden=? or orden=?', $vaf, $vaf-1).order('orden')
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
             "PAC-AF"+formula.nombre
     end
     column("Nulo/D/C", :class => 'text-right') do |formula|

       @dpc=  formula.orden
       @vpaso=0
       @vpas=1
       @titproc1="PROCESOS EN ESTADO NULO, DESIERTO O CANCELADO"
       @le= Phase.where(convo:formula.orden ,periodo:$vaf,sele:1).count
       @vpro11=Phase.where(convo:formula.orden ,periodo:$vaf,sele:1).
                   select('id').map {|e| e.attributes.values}.flatten
       link_to "#{@le}",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro11,:param2=> @vpaso)

      end


     column("GEX", :class => 'text-right') do |formula|

       @dpc=  formula.orden
       @vpaso=0
       @vpas=2
       @titproc1="PROCESOS EN GEX"
       @le= Phase.where(convo:formula.orden ,periodo:$vaf,sele:2).count
       @vpro12=Phase.where(convo:formula.orden ,periodo:$vaf,sele:2).
                   select('id').map {|e| e.attributes.values}.flatten
       link_to "#{@le}",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro12,:param2=> @vpaso)

      end


     column("DC", :class => 'text-right') do |formula|

       @dpc=  formula.orden
       @vpaso=0
       @vpas=3
       @titproc1="PROCESOS EN DC"
       @le= Phase.where(convo:formula.orden ,periodo:$vaf,sele:3).count
       @vpro13=Phase.where(convo:formula.orden ,periodo:$vaf,sele:3).
                   select('id').map {|e| e.attributes.values}.flatten
       link_to "#{@le}",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro13,:param2=> @vpaso)

      end


     column("DEM", :class => 'text-right') do |formula|

       @dpc=  formula.orden
       @vpaso=0
       @vpas=4
       @titproc1="PROCESOS EN DEM"
       @le= Phase.where(convo:formula.orden ,periodo:$vaf,sele:4).count
       @vpro14=Phase.where(convo:formula.orden ,periodo:$vaf,sele:4).
                   select('id').map {|e| e.attributes.values}.flatten
       link_to "#{@le}",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro14,:param2=> @vpaso)

      end



     column("DPC", :class => 'text-right') do |formula|

       @dpc=  formula.orden
       @vpaso=0
       @vpas=5
       @titproc1="PROCESOS EN DPC"
       @le= Phase.where(convo:formula.orden ,periodo:$vaf,sele:5).count
       @vpro15=Phase.where(convo:formula.orden ,periodo:$vaf,sele:5).
                   select('id').map {|e| e.attributes.values}.flatten
       link_to "#{@le}",
       reports_comment5_path(format: :pdf,
       :param3=> @vpas,
       :param4=> @titproc1,:param5=> @vpro15,:param2=> @vpaso)

      end

      column("FC", :class => 'text-right') do |formula|

        @dpc=  formula.orden
          @vpaso=0
        @vpas=6
        @titproc1="PROCESOS PREVIOS A FIRMA DE CONTRATO"
        @le= Phase.where(convo:formula.orden ,periodo:$vaf,sele:6).count
        @vpro16=Phase.where(convo:formula.orden ,periodo:$vaf,sele:6).
                    select('id').map {|e| e.attributes.values}.flatten
        link_to "#{@le}",
        reports_comment5_path(format: :pdf,
        :param3=> @vpas,
        :param4=> @titproc1,:param5=> @vpro16,:param2=> @vpaso)
      end

        column("EC", :class => 'text-right') do |formula|

          @dpc=  formula.orden
            @vpaso=0
          @vpas=7
          @titproc1="PROCESOS EN EJECUCION CONTRACTUAL"
          @le= Phase.where(convo:formula.orden ,periodo:$vaf,sele:7).count
          @vpro17=Phase.where(convo:formula.orden ,periodo:$vaf,sele:7).
                      select('id').map {|e| e.attributes.values}.flatten
          link_to "#{@le}",
          reports_comment5_path(format: :pdf,
          :param3=> @vpas,
          :param4=> @titproc1,:param5=> @vpro17,:param2=> @vpaso)



      end
      column("TOTAL", :class => 'text-right') do |formula|

        @dpc=  formula.orden
          @vpaso=1
        @vpas=[1,2,3,4,5,6,7]
        @titproc1="RELACION DE PROCESOS"
        @le= Phase.where(convo:formula.orden ,periodo:$vaf).count
        @vpro1t=Phase.where(convo:formula.orden ,periodo:$vaf).
                    select('id').map {|e| e.attributes.values}.flatten
        link_to "#{@le}",
        reports_comment5_path(format: :pdf,
        :param3=> @vpas,
        :param4=> @titproc1,:param5=> @vpro1t,:param2=> @vpaso)







      end








end
##############


      end # panel
#########################seguinmiento end
#########################################


###### leyenda
panel  "Leyenda" do
li "NULO/D/C: En estado Nulo,Desierto o Cancelado"
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
