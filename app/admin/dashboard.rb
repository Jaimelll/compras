ActiveAdmin.register_page "Dashboard" do

menu  priority: 1,label: proc{ I18n.t("active_admin.dashboard") }

#action_item :Encargo,  if: proc{ current_admin_user.id==2 } do
#Formula.where( product_id:15 ).update_all( cantidad:0 )
#Formula.where( product_id:15 ,orden:2).update_all( cantidad:1 )
#link_to 'Encargo',admin_dashboard_path
#end

action_item :only=> :index do
    link_to 'Encargo', encargo_admin_formula_path( :@num), method: :put
end
#action_item :only=> :index do
#    link_to 'Encargo 2 de 2', mgp_admin_formula_path( :@num), method: :put
#end
action_item :only=> :index do
    link_to 'Corporativos', corporativa_admin_formula_path( :@num), method: :put
end
#action_item :only=> :index do
#   link_to 'Corporativos 2', corporativo_admin_formula_path( :@num), method: :put
#end


action_item :only=> :index do
    link_to 'Autorizaciones', autorizado_admin_formula_path( :@num), method: :put
end

action_item :only=> :index do
    link_to 'Exclusiones', excluido_admin_formula_path( :@num), method: :put
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
case @var
   when 1
     #encargo sin la MGP
     @vitem=Item.where(ejecucion:4,modalidad:2).order('obac ASC,pac')
     @iconta=Item.where(ejecucion:4,modalidad:2).count
   when 2
   #corporativa
     @vitem=Item.where(ejecucion:4,modalidad:1).order('expediente')
      @iconta=Item.where(ejecucion:4,modalidad:1).count
  when 3
  # autorizados
     @vitem=Item.where(ejecucion:4,modalidad:3).order('obac ASC,pac')
      @iconta=Item.where(ejecucion:4,modalidad:3).count
   #encago la marina
  # @vitem=Item.where(ejecucion:4,modalidad:2).where(obac:2).order('obac ASC')
  when 5
  #excluidos
    @vitem=Item.where(ejecucion:4,modalidad:4).order('obac ASC,pac')
     @iconta=Item.where(ejecucion:4,modalidad:4).count



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

@vinicio = '2017/01/01'
@dfin=(Time.now-@vinicio.to_time).to_i/86400
@vfin=Time.now
@aversion=[]
@aobac=[]
@apec=[]
@adac=[]
@adem=[]
@adpc=[]
@adec=[]
@conta=0

@aversion2=[]
@aobac2=[]
@apec2=[]
@adac2=[]
@adem2=[]
@adpc2=[]
@adec2=[]
@conta2=0

@aversion3=[]
@aobac3=[]
@apec3=[]
@adac3=[]
@adem3=[]
@adpc3=[]
@adec3=[]
@conta3=0


@vproceso=[]


@vitem.each do |item|

  #prueba conta

  #empieza el item






  @vfec1=Time.now










@vproceso=[0,0,0,0,0,0,0]
@nconta1=0
@uproc=6
@corta=0

@nconta=Detail.where(item_id:item.id).where("details.pfecha>='2017/01/01' and details.pfecha<=current_date").
order('details.pfecha DESC,details.id').count

Detail.where(item_id:item.id).where("details.pfecha>='2017/01/01' and details.pfecha<=current_date").
order('details.pfecha DESC,details.id').each do |detail|
  #empieza detail

  @nconta1=@nconta1+1






if detail.pfecha and detail.actividad  then
@vproc=Formula.where(product_id:12,orden:detail.actividad).
                     select('cantidad as dd').first.dd
#proceso
@vprord=Formula.where(product_id:12,orden:detail.actividad).
            select('orden as dd').first.dd
#actividad




   unless @vprord==200 or @vprord==300 or ( @vprord==8 and item.modalidad==3)
         if  @uproc>=@vproc then

            @vproceso[@vproc]=@vproceso[@vproc]+ ( @vfec1.to_time-detail.pfecha.to_time).to_i/86400
            @uproc=@vproc
        else
            @vproceso[@uproc]=@vproceso[@uproc]+ ( @vfec1.to_time-detail.pfecha.to_time).to_i/86400


         end
    else
       @corta=( @vfec1.to_time-detail.pfecha.to_time).to_i/86400
    end
   if @nconta1==@nconta  then
         if @vprord==36 then

          @vproceso[0]= ( @vfec1.to_time-@vinicio.to_time).to_i/864000

         end

        @vproceso[1]=@dfin-(@vproceso[0]+ @vproceso[2]+@vproceso[3]+@vproceso[4]+
                         @vproceso[5]+@vproceso[6]+@corta)


   end

  end
@vfec1=detail.pfecha.to_time

#termina detail??
end










@vversion=@vproceso[0]
   @vobac=@vproceso[1]
    @vpec=@vproceso[2]
    @vdac=@vproceso[3]
    @vdem=@vproceso[4]
    @vdpc=@vproceso[5]
    @vdec=@vproceso[6]




#if @dfin<(@vobac+@vpec+@vdac+@vdem+@vdpc+@vdec) then
#  @vobac=@dfin-(@vpec+@vdac+@vdem+@vdpc+@vdec)
#end





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
if @var==2 and item.expediente and item.expediente>="01" then

@lab1=Formula.where(product_id:16,nombre:item.expediente).
         select('nombre as dd').first.dd+"-"+
          Formula.where(product_id:16,nombre:item.expediente).
                    select('descripcion as dd').first.dd.underscore.truncate(30)+
                  "--"+item.pac+"-"+@n1
else
#@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
@lab1=@desc.capitalize.truncate(40)+"--"+item.pac+"-"+@n1

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
   @titu3=" 3 de 3"
   @titu2=" 2 de 3"
   @titu1=" 1 de 3"
   @conta3= @conta3+1
  end
end






#termina if
#end
#termina item
end

#@conta=@alabels.count
#@conta2=@alabels2.count
#@conta3=@alabels3.count



#primer sitio de conta
#@conta=@alabels.count

#@vancho=(280/@conta).to_i
if @conta>0 then
@vancho=(280/@conta).to_i
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
#else
 @adata2.push(@aversion2)
  @adata2.push(@aobac2)
  @adata2.push(@apec2)
  @adata2.push(@adac2)
  @adata2.push(@adem2)
  @adata2.push(@adpc2)
  @adata2.push(@adec2)

#end
@adata3.push(@aversion3)
@adata3.push(@aobac3)
@adata3.push(@apec3)
@adata3.push(@adac3)
@adata3.push(@adem3)
@adata3.push(@adpc3)
@adata3.push(@adec3)

@dif=30*86400
if @alabels.length <=29 then
  @bar =Gchart.bar(
              #  :size   => '570x500',
                 :size   => '570x500',
                :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                :title  => @titulo+@titu1,
                :legend => [' ','S/EXP', 'C/EXP','DCA','DEM','DPC','DEC'],
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
              :axis_range => [nil, [0,@dfin,10], [1,@alabels.length,1]],
              #:min_value => 0,
              #:max_value => 365,
                :data   =>@adata)
    end
    if @alabels2.length <=29 and @alabels2.length >0 then
    @bar2 =Gchart.bar(
                #  :size   => '570x500',
                   :size   => '570x500',
                  :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                  :title  => @titulo+@titu2,
                  :legend => [' ','S/EXP', 'C/EXP','DCA','DEM','DPC','DEC'],
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
                :axis_range => [nil, [0,@dfin,10], [1,@alabels2.length,1]],
                #:min_value => 0,
                #:max_value => 365,
                  :data   =>@adata2)
        end
        if @alabels3.length <=29 and @alabels3.length >0 then
        @bar3 =Gchart.bar(
                    #  :size   => '570x500',
                       :size   => '570x500',
                        :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                      :title  => @titulo+@titu3,
                      :legend => [' ','S/EXP', 'C/EXP','DCA','DEM','DPC','DEC'],
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
                    :axis_range => [nil, [0,@dfin,10], [1,@alabels3.length,1]],
                    #:min_value => 0,
                    #:max_value => 365,
                      :data   =>@adata3)
            end




              columns do

                     column do
                       panel "PROCESOS EN CURSO AF-2017" do
                         table_for Formula.where(product_id:11)  do
                              column("Periodos" ) do |formula|
                                formula.nombre
                              end
                              column("EN ACFFAA 'PAC/(SOLES)'") do |formula|
                                Item.where(ejecucion:4,periodo:formula.orden).where("modalidad<3").count.to_s+ "/("+
                                   number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where("modalidad<3").sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end


                              column("EN OBAC 'PAC/(SOLES)'" ) do |formula|
                                (Item.where.not(ejecucion:4).where(periodo:formula.orden).where.not(modalidad:4).count+
    Item.where(ejecucion:4,periodo:formula.orden).where(modalidad:3).count).to_s+ "/("+
#(number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where(modalidad:3).sum(:certificado)+
number_with_delimiter((Item.where.not(ejecucion:4).where(periodo:formula.orden).where.not(modalidad:4).sum(:certificado)+
                       Item.where(ejecucion:4,periodo:formula.orden).where(modalidad:3).sum(:certificado)).to_i, delimiter: ",").to_s+ ")"




                              end
                              column("TOTAL  'PAC/(SOLES)' ") do |formula|
                                Item.where(periodo:formula.orden).where.not(modalidad:4).count.to_s+ "/("+
                                   number_with_delimiter(Item.where(periodo:formula.orden).where.not(modalidad:4).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end

                          #    column("Excluidos RJ ACFFAA") do |formula|
                          #         Item.where(ejecucion:4,periodo:formula.orden,modalidad:4).where('id IN(?)',Detail.where(actividad:200).select("item_id")).count.to_s+ "/("+
                          #            number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden,modalidad:4).where('id IN(?)',Detail.where(actividad:200).select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                          #     end
                          #     column("Culminados ACFFAA") do |formula|
                          #     Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).count.to_s+ "/("+
                          #          number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                          #    end

                 table_for Formula.where(product_id:11)  do
                   @p=ActiveRecord::Base.connection.execute("SELECT items.periodo,
                   MAX(formulas.cantidad) as acti FROM public.items, public.details,
                   public.formulas WHERE items.id = details.item_id AND
                   details.actividad = formulas.orden AND
                   formulas.product_id = 12 AND items.ejecucion=4 and
                    items.modalidad<3 AND ((details.item_id,details.pfecha)
IN(SELECT   details.item_id,   MAX(details.pfecha)FROM   public.details   GROUP BY   details.item_id)) GROUP BY items.periodo,details.item_id").to_a

                                    column("Avance ACFFAA ") do |formula|
                                      formula.nombre
                                    end
                                    column("S/EXP") do |formula|

                                      @p.select {|f| f["acti"]== 1 and f["periodo"]==formula.orden}.count

                                    end
                                         column("C/EXP") do |formula|

                                       @p.select {|f| f["acti"]== 2 and f["periodo"]==formula.orden}.count


                                    end

                                    column("DC") do |formula|

                                       @p.select {|f| f["acti"]== 3 and f["periodo"]==formula.orden}.count

                                    end

                                    column("DEM") do |formula|
                                          @p.select {|f| f["acti"]== 4 and f["periodo"]==formula.orden}.count
                                     end
                                     column("DPC") do |formula|
                                         @p.select {|f| f["acti"]== 5 and f["periodo"]==formula.orden}.count
                                   end
                                   column("DEC") do |formula|
                                   @p.select {|f| f["acti"]== 6 and f["periodo"]==formula.orden}.count
                                 end
                                 column("TOTAL PAC") do |formula|
                                   @p.select {|f|  f["periodo"]==formula.orden}.count
                               end
                                 end
                         table_for Formula.where(product_id:3)  do
                              column("Listas ACFFAA") do |formula|
                              formula.nombre
                              end
                              column("Encargo 'PAC/(SOLES)'") do |formula|

                              @encargo=  formula.orden

                              @le= Item.where(ejecucion:4,modalidad:2,lista:formula.orden).count.to_s+ "/("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:2,lista:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                              link_to "#{@le} ", reports_comment_path(format: :pdf,:param2=> @encargo)

                              end
                              column("Corporativos 'PAC/(SOLES)'") do |formula|
                             @corporativa=  formula.orden
                                @lc=   Item.where(ejecucion:4,modalidad:1,lista:formula.orden).count.to_s+ "/("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:1,lista:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                               link_to "#{@lc} ", reports_comment2_path(format: :pdf,:param2=> @corporativa)
                              end

                              column("TOTAL 'PAC/(SOLES)'") do |formula|



                                Item.where(ejecucion:4,lista:formula.orden).where("modalidad<3").count.to_s+ "/("+
                                   number_with_delimiter(Item.where(ejecucion:4,lista:formula.orden).where("modalidad<3").sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end


                          end

                           table_for Formula.where(product_id:1,cantidad:1)  do
                                column("Autorizaciones y Exclusiones") do |formula|
                                  formula.nombre
                                end


                                column("Autorizados con RJ") do |formula|
                                    @auto=  formula.orden
                                  @autol=  Item.where(ejecucion:4,modalidad:3,obac:formula.orden)
                                  .where('id IN(?)',Detail.where(actividad:8).select("item_id")).count.to_s+ "/("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:3,
                                     obac:formula.orden).where('id IN(?)',Detail.where(actividad:8).
                                     select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                   link_to "#{@autol} ", reports_comment3_path(format: :pdf,:param2=>   @auto)
                                 end


                                 column("Por Autorizar") do |formula|
                                   @noauto=  formula.orden
                                   @noautol= Item.where(ejecucion:4,modalidad:3,obac:formula.orden)
                                   .where.not('id IN(?)',Detail.where(actividad:8).select("item_id")).count.to_s+ "/("+
                                      number_with_delimiter(Item.where(ejecucion:4,modalidad:3,
                                      obac:formula.orden).where.not('id IN(?)',Detail.where(actividad:8).
                                      select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                    link_to "#{@noautol} ", reports_comment4_path(format: :pdf,:param2=>   @noauto)
                                  end

                                 column("Excluidos con RJ") do |formula|
                                    @noexclu=  formula.orden
                                    @noexclul= Item.where(ejecucion:4,obac:formula.orden,modalidad:4).
                                   where('id IN(?)',Detail.where(actividad:200).select("item_id")).
                                   count.to_s+ "/("+
                                      number_with_delimiter(Item.where(ejecucion:4,obac:formula.orden,modalidad:4).
                                      where('id IN(?)',Detail.where(actividad:200).select("item_id")).
                                      sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                        link_to "#{@noexclul} ", reports_comment5_path(format: :pdf,:param2=>   @noexclu)

                                  end

                                  column("Por Excluir") do |formula|
                                    @pexclu=  formula.orden
                                    @pexclul=   Item.where(ejecucion:4,obac:formula.orden,modalidad:4).
                                    where.not('id IN(?)',Detail.where(actividad:200).select("item_id")).
                                    count.to_s+ "/("+
                                       number_with_delimiter(Item.where(ejecucion:4,obac:formula.orden,modalidad:4).
                                       where.not('id IN(?)',Detail.where(actividad:200).select("item_id")).
                                       sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                 link_to "#{@pexclul} ", reports_comment6_path(format: :pdf,:param2=>   @pexclu)

                                   end



                            end

                                   end







                      end
                    end

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
