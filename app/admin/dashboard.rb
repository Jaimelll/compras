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


action_item :only=> :index do
    link_to 'Encargo', encargo_admin_product_formula_path(1, :@num), method: :put

end
#action_item :only=> :index do
#    link_to 'Encargo 2 de 2', mgp_admin_formula_path( :@num), method: :put
#end
action_item :only=> :index do
    link_to 'Corporativos', corporativa_admin_product_formula_path( 1,:@num), method: :put
end



action_item :only=> :index do
    link_to 'Autorizaciones', autorizado_admin_product_formula_path( 1,:@num), method: :put
end

action_item :only=> :index do
    link_to 'Exclusiones', excluido_admin_product_formula_path(1, :@num), method: :put
end


action_item :only=> :index do
   link_to 'GEX', gex_admin_product_formula_path( 1,:@num), method: :put
end

action_item :only=> :index do
   link_to 'DEM', dem_admin_product_formula_path( 1,:@num), method: :put
end

action_item :only=> :index do
   link_to 'DPC', dpc_admin_product_formula_path( 1,:@num), method: :put
end

action_item :only=> :index do
   link_to 'DEC', dec_admin_product_formula_path(1, :@num), method: :put
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

     @var=Formula.where(product_id:15,cantidad:1).
                          select('orden as dd').first.dd
     @titulo=Formula.where(product_id:15,cantidad:1).
                          select('nombre as dd').first.dd
      @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd
case @var
   when 1
     #encargo
     @vitem=Item.where(ejecucion:4,modalidad:2)
     .where(exped2:@vaf).order('periodo,obac ASC,pac')
     @iproce=100
   when 2
   #corporativa
     @vitem=Item.where(ejecucion:4,modalidad:1)
     .where(exped2:@vaf).order('periodo,exped,obac')
    @iproce=100
  when 3
  # autorizados
     @vitem=Item.where(ejecucion:4,modalidad:3)
     .where(exped2:@vaf).order('obac ASC,pac')
     @iproce=100
 when 4
#DEC proceso 6
  @vitem=Item.where(ejecucion:4).where("modalidad<3")
  .where(exped2:@vaf).order('periodo,exped,obac')
   @iproce=6

  when 5
  #excluidos
    @vitem=Item.where(ejecucion:4,modalidad:4)
    .where(exped2:@vaf).order('obac ASC,pac')
    @iproce=100

 when 6
#dpc
@vitem=Item.where(ejecucion:4).where("modalidad<3")
.where(exped2:@vaf).order('periodo,exped,obac')
 @iproce=5

 when 7
#dem
@vitem=Item.where(ejecucion:4).where("modalidad<3")
.where(exped2:@vaf).order('periodo,exped,obac')
 @iproce=4

when 8
#gex
@vitem=Item.where(ejecucion:4).where("modalidad<3")
.where(exped2:@vaf).order('periodo,exped,obac')
 @iproce=2
end





@adata=[]
@alabels=[]
@blabels=[]

@adata2=[]
@alabels2=[]
@blabels2=[]

@adata3=[]
@alabels3=[]
@blabels3=[]

@vinicio = Date.parse('2017/01/01')
@dfin=(Time.now-@vinicio.to_time).to_i/86400
@vfin=Time.now
@aversion=[]
@aobac=[]
@apec=[]
@adac=[]
@adem=[]
@adpc=[]
@adec=[]
@aeobac=[]
@conta=0

@aversion2=[]
@aobac2=[]
@apec2=[]
@adac2=[]
@adem2=[]
@adpc2=[]
@adec2=[]
@aeobac2=[]
@conta2=0

@aversion3=[]
@aobac3=[]
@apec3=[]
@adac3=[]
@adem3=[]
@adpc3=[]
@adec3=[]
@aeobac3=[]
@conta3=0


@vproceso=[]


@vitem.each do |item|

  #prueba conta

  #empieza el item

@vfec1=Time.now

@vproceso=[0,0,0,0,0,0,0,0]

@uproc=7
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

     @nconta=Detail.where(item_id:item.id).
        where("details.pfecha>='2015/01/01'and details.pfecha<='2015/12/31' and
        details.pfecha<=current_date").count
      @deta2=Detail.where("details.pfecha>='2015/01/01' and
       details.pfecha<='2015/12/31' and details.pfecha<=current_date").
      order('details.pfecha DESC,details.id DESC')


    when 2
      @vinicio = Date.parse('2016/01/01')
      @dfin=365
      @vfin=Date.parse('2016/12/31')
       @vrang=30
       @vtitun=" AF-2016"

      @nconta=Detail.where(item_id:item.id).
         where("details.pfecha>='2016/01/01'and details.pfecha<='2016/12/31' and
         details.pfecha<=current_date").count
       @deta2=Detail.where("details.pfecha>='2016/01/01' and
        details.pfecha<='2016/12/31' and details.pfecha<=current_date").
       order('details.pfecha DESC,details.id DESC')


     when 3
       @vinicio = Date.parse('2017/01/01')
       @dfin=(Time.now-@vinicio.to_time).to_i/86400
       @vfin=Time.now
        @vrang=15
        @vtitun=" AF-2017"

       @nconta=Detail.where(item_id:item.id).
          where("details.pfecha>='2017/01/01' and details.pfecha<=current_date").count
        @deta2=Detail.where("details.pfecha>='2017/01/01' and details.pfecha<=current_date").
        order('details.pfecha DESC,details.id DESC')
  end #termina case

@deta1=@deta2.where(item_id:item.id)









@deta1.each do |detail|

  #empieza detail
#end
#termina cas
  @nconta1=@nconta1+1


if detail.pfecha and detail.actividad  then
@vproc=Formula.where(product_id:12,orden:detail.actividad).
                     select('cantidad as dd').first.dd
#proceso
@vprord=Formula.where(product_id:12,orden:detail.actividad).
            select('orden as dd').first.dd
#actividad


if  @nconta1==1 then
      @vlog=false
   if @vproc==@iproce or @iproce==100 then
    @vlog=true
   end
end

if @vlog  then
# empieza @vlog


   unless @vprord==200 or @vprord==300 or ( @vprord==8 and item.modalidad==3)
     if  @uproc>=@vproc then

            @vproceso[@vproc]=@vproceso[@vproc]+
            ( @vfec1-detail.pfecha.to_time).to_i/86400

            if @nconta1==1 then
               @vproceso[@vproc]=@vproceso[@vproc]+2
            end
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



if @alabels.length <29  then
   @alabels.push(@lab1)
   @aversion.push(@vversion)
   @aobac.push(@vobac)
   @apec.push(@vpec)
   @adac.push(@vdac)
   @adem.push(@vdem)
   @adpc.push(@vdpc)
   @adec.push(@vdec)
   @aeobac.push(@veobac)
   @conta=@conta+1
   @titu1=" "
else
   if @alabels2.length  <29  then
      @alabels2.push(@lab1)
      @aversion2.push(@vversion)
       @aobac2.push(@vobac)
       @apec2.push(@vpec)
       @adac2.push(@vdac)
       @adem2.push(@vdem)
       @adpc2.push(@vdpc)
       @adec2.push(@vdec)
      @aeobac2.push(@veobac)
      @titu2=" 2 de 2"
      @titu1=" 1 de 2"
      @conta2=  @conta2+1
   else

   @alabels3.push(@lab1)
   @aversion3.push(@vversion)
   @aobac3.push(@vobac)
   @apec3.push(@vpec)
   @adac3.push(@vdac)
   @adem3.push(@vdem)
   @adpc3.push(@vdpc)
   @adec3.push(@vdec)
  @aeobac3.push(@veobac)
   @titu3=" 3 de 3"
   @titu2=" 2 de 3"
   @titu1=" 1 de 3"
   @conta3= @conta3+1
  end
# termina @vlog
end

# admin
end





#termina item
end


if @conta>0 then
@vancho=(280/@conta).to_i
if @vancho>30 then
  @vancho=30
end
end
@ancho=@vancho.to_s

@blabels.push(@alabels.reverse.join("|"))
@blabels2.push(@alabels2.reverse.join("|"))
@blabels3.push(@alabels3.reverse.join("|"))

#if @conta <29 then
@adata.push(@aversion)
@adata.push(@aobac)
@adata.push(@apec)
@adata.push(@adac)
@adata.push(@adem)
@adata.push(@adpc)
@adata.push(@adec)
@adata.push(@aeobac)
#else
 @adata2.push(@aversion2)
  @adata2.push(@aobac2)
  @adata2.push(@apec2)
  @adata2.push(@adac2)
  @adata2.push(@adem2)
  @adata2.push(@adpc2)
  @adata2.push(@adec2)
  @adata2.push(@aeobac2)

#end
@adata3.push(@aversion3)
@adata3.push(@aobac3)
@adata3.push(@apec3)
@adata3.push(@adac3)
@adata3.push(@adem3)
@adata3.push(@adpc3)
@adata3.push(@adec3)
@adata3.push(@aeobac3)

@dif=30*86400
if @alabels.length <=29 and @alabels.length>0 then
  @bar =Gchart.bar(
              #  :size   => '570x500',
                 :size   => '570x500',
                :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                :title  => @titulo+@titu1+@vtitun,
                :legend => ['  ','S/EXP', 'C/EXP','DCA','DEM','DPC','DEC'],
                :orientation => 'horizontal',
                :stacked => true,

                :bg =>'EEEEEE',
                :legend_position => 'bottom',


                :bar_width_and_spacing => @ancho,

                :axis_with_labels => 'y,x,r',

               :axis_labels => [@blabels],

        #   :axis_range => [nil, [@vinicio.to_time.
        #     strftime("%b %y"), Time.now.strftime("%b %y"),
        #     DateTime.new(0,1,1)], [0,@conta,1]],

            #:axis_range => [nil, [@vinicio.to_time,Time.now], [1,@conta,1]],
              :axis_range => [nil, [0,@dfin, @vrang], [1,@alabels.length,1]],
              #:min_value => 0,
              #:max_value => 365,
                :data   =>@adata)
    end
    if @alabels2.length <=29 and @alabels2.length >0 then
    @bar2 =Gchart.bar(
                #  :size   => '570x500',
                   :size   => '570x500',
                  :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                  :title  => @titulo+@titu2+@vtitun,
                  :legend => ['  ','S/EXP', 'C/EXP','DCA','DEM','DPC','DEC'],
                  :orientation => 'horizontal',
                  :stacked => true,

                  :bg =>'EEEEEE',
                  :legend_position => 'bottom',


                  :bar_width_and_spacing => @ancho,

                  :axis_with_labels => 'y,x,r',

                 :axis_labels => [@blabels2],

          #   :axis_range => [nil, [@vinicio.to_time.
          #     strftime("%b %y"), Time.now.strftime("%b %y"),
          #     DateTime.new(0,1,1)], [0,@conta,1]],

              #:axis_range => [nil, [@vinicio.to_time,Time.now], [1,@conta,1]],
                :axis_range => [nil, [0,@dfin, @vrang], [1,@alabels2.length,1]],
                #:min_value => 0,
                #:max_value => 365,
                  :data   =>@adata2)
        end
        if @alabels3.length <=29 and @alabels3.length >0 then
        @bar3 =Gchart.bar(
                    #  :size   => '570x500',
                       :size   => '570x500',
                      :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                      :title  => @titulo+@titu3+@vtitun,
                      :legend => ['  ','S/EXP', 'C/EXP','DCA','DEM','DPC','DEC'],
                      :orientation => 'horizontal',
                      :stacked => true,

                      :bg =>'EEEEEE',
                      :legend_position => 'bottom',


                      :bar_width_and_spacing => @ancho,

                      :axis_with_labels => 'y,x,r',

                     :axis_labels => [@blabels3],

              #   :axis_range => [nil, [@vinicio.to_time.
              #     strftime("%b %y"), Time.now.strftime("%b %y"),
              #     DateTime.new(0,1,1)], [0,@conta,1]],

                  #:axis_range => [nil, [@vinicio.to_time,Time.now], [1,@conta,1]],
                    :axis_range => [nil, [0,@dfin, @vrang], [1,@alabels3.length,1]],
                    #:min_value => 0,
                    #:max_value => 365,
                      :data   =>@adata3)
            end




              columns do

                     column do
                       panel  "I.- HISTORIAL PERIODOS  - 'PAC/(SOLES)'" do
                         table_for Formula.where(product_id:11).order('orden')  do


                              column("Periodos" ) do |formula|
                                formula.nombre
                              end

                              column("EN ACFFAA ") do |formula|
                              @auto=  formula.orden
                              @tita1="Procesos en ACFFAA - PERIODO"
                              @vopc1=4

                            @le1=  Item.where(ejecucion:4,exped2:formula.orden)
                                .where("modalidad<3")

                            @le= @le1.count.to_s+ "/("+
                                   number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                            link_to "#{@le} ", reports_comment_path(format: :pdf,
                            :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                            end





                              column("EN OBAC " ) do |formula|


                                @auto=  formula.orden
                                @tita1="Procesos en OBAC - PERIODO"
                                @vopc1=5

                              @le1=  Item.where("(ejecucion<>4 and modalidad<>4) or (ejecucion=4 and modalidad=3)")
                              .where(exped2:formula.orden)

                              @le= number_with_delimiter((@le1.count).to_i, delimiter: ",").to_s+ "/("+
                                     number_with_delimiter(@le1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                case   formula.orden
                            when 3
                              link_to "#{@le} ", reports_comment2_path(format: :pdf,
                              :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)
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
                      end #de panel historial periodos
               @vaf=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
               panel  "II.- LISTAS GENERALES DE COMPRAS ACFFAA "+@vaf+ " - 'PAC/(SOLES)'" do

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
                                   .where(exped2:@vaf)

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
                                    .where(exped2:@vaf)

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
                                        .where(exped2:@vaf)
                                @ls=   @ls1.count.to_s+ "/("+
                                     number_with_delimiter(@ls1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                     link_to "#{@ls} ", reports_comment_path(format: :pdf,
                                     :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                              end






                          end # de table for listas
                        end # panel listas


                          @vaf=Formula.where(product_id:11,cantidad:1).select('descripcion as dd').first.dd
                          panel  "III.- TIPO DE COMPRA POR MERCADO  ACFFAA "+@vaf+ " - 'PAC/(SOLES)'" do

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
                                              .where(exped2:@vaf)

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
                                               .where(exped2:@vaf)

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
                                                   .where(exped2:@vaf)
                                           @ls=   @ls1.count.to_s+ "/("+
                                                number_with_delimiter(@ls1.sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                                link_to "#{@ls} ", reports_comment_path(format: :pdf,
                                                :param2=>   @auto,:param3=>   @tita1,:param4=>   @vopc1)



                                         end






                                     end # de table for Mercado
                                   end # panel mercado


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
                            @itep=Item.where(ejecucion:4,exped2:@vaf1).where("modalidad<3")
                            @itep.each do |ite|
                                      if @deta2.where(item_id:ite.id).count>0 then
                                        @vactiv=@deta2.where(item_id:ite.id).
                                           select('actividad as dd').first.dd     #linea 209
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

                                        end #case

                                      else
                                         @vxper[0]=@vxper[0]+ 1
                                         @vpresu[0]=@vpresu[0]+ ite.certificado
                                         @vpac1.push(ite.id)
                                      end
                               end
                       column("Avance") do |formula|
                               "PAC"
                       end
                       column("S/EXP") do |formula|

                         @titproc1="PAC SIN EXPEDIENTE DE INICIO"
                         @vpas=1
                         @dpcl=   @vxper[0]+ @vxper[1]
                               link_to "#{@dpcl} ",
                                reports_comment7_path(format: :pdf,
                                :param3=> @vpas,
                                :param4=> @titproc1,:param5=> @vpac1)
                        end

                       column("C/EXP") do |formula|
                        @dpc=  formula.orden
                        @vpas=2
                        @titproc1="PAC CON EXPEDIENTE DE INICIO"
                        @dpcl=      @vxper[2]
                             link_to "#{@dpcl} ",
                             reports_comment7_path(format: :pdf,
                             :param3=> @vpas,
                             :param4=> @titproc1,:param5=> @vpac2)
                        end

                       column("DC") do |formula|

                         @dpc=  formula.orden
                         @vpas=3
                         @titproc1="EXPEDIENTES EN CATALOGACION"
                         @dpcl=   @vxper[3]
                               link_to "#{@dpcl} ",
                                reports_comment7_path(format: :pdf,
                                :param3=> @vpas,
                                :param4=> @titproc1,:param5=> @vpac3)

                        end

                       column("DEM") do |formula|
                         @dpc=  formula.orden
                         @vpas=4
                         @titproc1="EXPEDIENTES EN ESTUDIO DE MERCADO"
                         @dpcl=  @vxper[4]
                               link_to "#{@dpcl} ",
                                reports_comment7_path(format: :pdf,
                                :param3=> @vpas,
                                :param4=> @titproc1,:param5=> @vpac4)

                        end

                       column("DPC") do |formula|
                       @dpc=  formula.orden
                        @vpas=5
                        @titproc1="EXPEDIENTES EN PROCESO DE COMPRAS"
                         @dpcl=  @vxper[5]
                               link_to "#{@dpcl} ",
                                reports_comment7_path(format: :pdf,
                                :param3=> @vpas,
                                :param4=> @titproc1,:param5=> @vpac5)

                        end

                       column("DEC ") do |formula|
                         @dpc=  formula.orden
                         @vpas=6
                         @titproc1="EXPEDIENTES EN DEC"
                         @dpcl=   @vxper[6].to_s+ "/("+
                         number_with_delimiter(@vpresu[6].to_i, delimiter: ",").to_s+ ")"
                                 link_to "#{@dpcl} ",
                                 reports_comment7_path(format: :pdf,
                                 :param3=> @vpas,
                                 :param4=> @titproc1,:param5=> @vpac6)

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


  panel  "V.- CALENDARIO DE PROCESOS CONVOCADOS  ACFFAA "+@vaf + " - 'Procesos/(PACs)'" do
  #  ul do

  #li link_to "Historial  ", reports_comment4_path(format: :pdf,  :param1=> 2)
    #    li link_to "Programados ", reports_comment4_path(format: :pdf,  :param1=> 1)

  #  end
      table_for  Formula.where(product_id:11,orden:@vaf1).order('orden') do
        @activities=Phase.joins(:activities).where("activities.actividad=19 " )

         column("Avance") do
            "Procesos"
         end
         column("Historial") do

           @conta=0
           @activities.where("pfecha<current_date").each do |activ|
             if activ.expediente>0 then
             Item.where(exped:activ.expediente).each do
                @conta=  @conta+1
              end #item
            end #if
          end #activ
         @le=@activities.where("pfecha<current_date").count.to_s

            link_to "#{@le}"+"/("+"#{@conta}"+")", reports_comment4_path(format: :pdf,  :param1=> 2)
         end

         column("Programados") do
           @conta=0
           @activities.where("pfecha>=current_date").each do |activ|
             if activ.expediente>0 then
             Item.where(exped:activ.expediente).each do
                @conta=  @conta+1
              end #item
            end #if
          end #activ
          @le=@activities.where("pfecha>=current_date").count.to_s

            link_to "#{@le}"+"/("+"#{@conta}"+")", reports_comment4_path(format: :pdf,  :param1=> 1)



         end

         column("Total") do
           @conta=0
           @activities.each do |activ|
             if activ.expediente>0 then
             Item.where(exped:activ.expediente).each do
                @conta=  @conta+1
              end #item
            end #if
          end #activ
          @le=@activities.count.to_s

            link_to "#{@le}"+"/("+"#{@conta}"+")", reports_comment4_path(format: :pdf,  :param1=> 3)


         end
      end
  end





                    end# de columns

                    column do
                    panel "Grafico del Estado de los Procesos PAC" do
                       li do
                         if @conta>0 then
                         strong { image_tag @bar}
                        end
                          end

                      #  panel "Grafico de Situacion de Expedientes" do
                           li do
                             if @conta2>0 then
                             strong { image_tag @bar2}
                            end
                              end


                            li do
                              if @conta3>0 then
                              strong { image_tag @bar3}
                             end
                               end

                     end

end
              end




  end # content



end
