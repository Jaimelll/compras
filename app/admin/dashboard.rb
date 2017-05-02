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
     @vitem=Item.where(ejecucion:4,modalidad:2).order('obac ASC')

   when 2
   #corporativa
     @vitem=Item.where(ejecucion:4,modalidad:1).order('expediente')

  when 3
  # autorizados
     @vitem=Item.where(ejecucion:4,modalidad:3).order('obac ASC')
   #encago la marina
  # @vitem=Item.where(ejecucion:4,modalidad:2).where(obac:2).order('obac ASC')
  when 5
  #excluidos
    @vitem=Item.where(ejecucion:4,modalidad:4).order('expediente')



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

@vinicio = '01/01/2017'
@dfin=(Time.now-@vinicio.to_time).to_i/86400

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




@vitem.each do |item|

  #prueba conta

  #empieza el item
if @conta <29 then

    @conta=@alabels.count+1

    @titu1=" "
else
   if @conta2 <29 then
    @conta=@alabels.count
    @titu2=" 2 de 2"
    @titu1=" 1 de 2"
    @conta2=@alabels2.count+1
  else
    @conta2=@alabels2.count
    @titu3=" 3 de 3"
    @titu2=" 2 de 3"
    @titu1=" 1 de 3"
    @conta3=@alabels3.count+1
  end
end
  @vfec1=@vinicio
  @vfec2=@vinicio
  @vfec3=@vinicio
  @vfec4=@vinicio
  @vfec5=@vinicio
  @vfec6=@vinicio


@vversion=0
@vobac=0
@vpec=0
@vdac=0
@vdem=0
@vdpc=0
@vdec=0



@uproc=1

@cobac=0
@cpec=0
@cdac=0
@cdem=0
@cdpc=0
@cdec=0

if item.obac and item.obac>0 then
    @n1=Formula.where(product_id:1, orden:item.obac).
       select('nombre as dd').first.dd

else
    @n1="s/d"
end

#@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
#@alabels2.push(item.descripcion.first(10))
if @conta <29 then
if @var==2 and item.expediente and item.expediente>="1" then
@alabels.push(Formula.where(product_id:16,orden:item.expediente).
         select('nombre as dd').first.dd+"-"+
         Formula.where(product_id:16,orden:item.expediente).
                  select('descripcion as dd').first.dd+
                  "----"+item.pac+"-"+@n1)
else
#@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
@alabels.push(item.descripcion.underscore.truncate(40)+"----"+item.pac+"-"+@n1)

end
else
 if @conta2 <29 then
    if @var==2 and item.expediente and item.expediente>="1" then
    @alabels2.push(Formula.where(product_id:16,orden:item.expediente).
           select('nombre as dd').first.dd+"-"+
           Formula.where(product_id:16,orden:item.expediente).
                    select('descripcion as dd').first.dd+
                    "----"+item.pac+"-"+@n1)
    else
    #@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
    @alabels2.push(item.descripcion.underscore.truncate(40)+"----"+item.pac+"-"+@n1)
    end
  else
    if @var==2 and item.expediente and item.expediente>="1" then
    @alabels3.push(Formula.where(product_id:16,orden:item.expediente).
           select('nombre as dd').first.dd+"-"+
           Formula.where(product_id:16,orden:item.expediente).
                    select('descripcion as dd').first.dd+
                    "----"+item.pac+"-"+@n1)
    else
    #@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
    @alabels3.push(item.descripcion.underscore.truncate(40)+"----"+item.pac+"-"+@n1)
    end

  end
end



Detail.where(item_id:item.id).order('pfecha ASC,id').each do |detail|
#empieza detail
if detail.pfecha and detail.actividad  then
@vproc=Formula.where(product_id:12,orden:detail.actividad).
                     select('cantidad as dd').first.dd
@vprord=Formula.where(product_id:12,orden:detail.actividad).
            select('orden as dd').first.dd


if @vproc==1 then
  @uproc=1

    if @vobac==0 then


         @vobac=( detail.pfecha.to_time-@vinicio.to_time).to_i/86400

    else
       @vobac=@vobac+( detail.pfecha.to_time-@vfec1.to_time).to_i/86400
     end
   @vfec1= detail.pfecha

 end


if @vproc==2 then
  @uproc=2
    if @vpec==0  then

       @vobac=@vobac+( detail.pfecha.to_time-@vfec1.to_time).to_i/86400

       @vpec=1

    else
         @vpec=@vpec+( detail.pfecha.to_time-@vfec2.to_time).to_i/86400

    end
    @vfec2= detail.pfecha

end



if @vproc==3 then
    @uproc=3
    if @vdac==0  then
        if @vpec==0 then
          @vobac=@vobac+( detail.pfecha.to_time-@vfec1.to_time).to_i/86400
        else
           @vpec= @vpec+( detail.pfecha.to_time-@vfec2.to_time).to_i/86400

        end
       @vdac=1

    else
       @vdac=@vdac+( detail.pfecha.to_time-@vfec3.to_time).to_i/86400
    end
    @vfec3= detail.pfecha


end


if @vproc==4 then
  @uproc=4
    if @vdem==0  then
         if @vdac==0  then
             if @vpec==0  then
                  @vobac=@vobac+( detail.pfecha.to_time-@vfec1.to_time).to_i/86400
             else
                  @vpec= @vpec+( detail.pfecha.to_time-@vfec2.to_time).to_i/86400
             end
         else
               @vdac=@vdac+( detail.pfecha.to_time-@vfec3.to_time).to_i/86400

         end
         @vdem=1

    else
                 @vdem=@vdem+( detail.pfecha.to_time-@vfec4.to_time).to_i/86400
    end
    @vfec4= detail.pfecha

end


if @vproc==5 then
  @uproc=5
  if @vdpc==0  then
      if @vdem==0  then
           if @vdac==0  then
               if @vpec==0  then

                     @vobac=@vobac+( detail.pfecha.to_time-@vfec1.to_time).to_i/86400

               else
                    @vpec= @vpec+( detail.pfecha.to_time-@vfec2.to_time).to_i/86400
               end
           else
                   @vdac=@vdac+( detail.pfecha.to_time-@vfec3.to_time).to_i/86400
           end
      else
                 @vdem=@vdem+( detail.pfecha.to_time-@vfec4.to_time).to_i/86400
      end
      @vdpc=1

    else
               @vdpc=@vdpc+( detail.pfecha.to_time-@vfec5.to_time).to_i/86400
    end

    @vfec5= detail.pfecha

end

if @vproc==6 then
  @uproc=6
if @vdec==0  then
    if @vdpc==0  then
        if @vdem==0  then
             if @vdac==0  then
                 if @vpec==0  then
                      @vobac=@vobac+( detail.pfecha.to_time-@vfec1.to_time).to_i/86400
                 else
                      @vpec= @vpec+( detail.pfecha.to_time-@vfec2.to_time).to_i/86400
                 end
             else
                      @vdac=@vdac+( detail.pfecha.to_time-@vfec3.to_time).to_i/86400
             end
        else
                    @vdem=@vdem+( detail.pfecha.to_time-@vfec4.to_time).to_i/86400
        end

    else
               @vdpc=@vdpc+( detail.pfecha.to_time-@vfec5.to_time).to_i/86400
    end
    @vdec=1

  else
    @vdec=@vdec+( detail.pfecha.to_time-@vfec6.to_time).to_i/86400
  end
    @vfec6= detail.pfecha



      end

      if @vprord==36 then
         @vversion=( detail.pfecha.to_time-@vinicio.to_time).to_i/86400

      end


end




#termina detail??



end





unless @vprord==200 or @vprord==300 or ( @vprord==8 and item.modalidad==3)

  case @uproc
     when 1


       @vobac=@dfin
       @cobac= @cobac+1
            @vpec=0
            @vdac=0
            @vdem=0
            @vdpc=0
            @vdec=0

     when 2
       @vpec=@dfin-@vobac
        @cpec= @cpec+1

           @vdac=0
           @vdem=0
           @vdpc=0
           @vdec=0
     when 3
       @vdac=@dfin-@vobac-@vpec
         @cdac= @cdac+1

          @vdem=0
          @vdpc=0
          @vdec=0

     when 4
       @vdem=@dfin-@vobac-@vpec-@vdac
          @cdem= @cdem+1

          @vdpc=0
          @vdec=0

     when 5

     @vdpc=@dfin-@vobac-@vpec-@vdac-@vdem
     @cdpc= @cdpc+1


       @vdec=0

     when 6

       @vdec=@dfin-@vobac-@vpec-@vdac-@vdem-@vdpc
       @cdec= @cdec+1

  end
  @vobac=@vobac-@vversion

end

if @conta <29 then
@aversion.push(@vversion)
@aobac.push(@vobac)
@apec.push(@vpec)
@adac.push(@vdac)
@adem.push(@vdem)
@adpc.push(@vdpc)
@adec.push(@vdec)
else
  if @conta2 <29 then
    @aversion2.push(@vversion)
     @aobac2.push(@vobac)
     @apec2.push(@vpec)
     @adac2.push(@vdac)
     @adem2.push(@vdem)
     @adpc2.push(@vdpc)
     @adec2.push(@vdec)
  else
    @aversion3.push(@vversion)
    @aobac3.push(@vobac)
    @apec3.push(@vpec)
    @adac3.push(@vdac)
    @adem3.push(@vdem)
    @adpc3.push(@vdpc)
    @adec3.push(@vdec)
  end
end

#termina if
#end
#termina item
end
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
if @conta>0 then
  @bar =Gchart.bar(
              #  :size   => '570x500',
                 :size   => '570x500',
                :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                :title  => @titulo+@titu1,
                :legend => [' ','OBAC', 'GEX','DCA','DEM','DPC','DEC'],
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
              :axis_range => [nil, [0,@dfin,10], [1,@conta,1]],
              #:min_value => 0,
              #:max_value => 365,
                :data   =>@adata)
    end
    if @conta2>0 then
    @bar2 =Gchart.bar(
                #  :size   => '570x500',
                   :size   => '570x500',
                  :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                  :title  => @titulo+@titu2,
                  :legend => [' ','OBAC', 'GEX','DCA','DEM','DPC','DEC'],
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
                :axis_range => [nil, [0,@dfin,10], [1,@conta2,1]],
                #:min_value => 0,
                #:max_value => 365,
                  :data   =>@adata2)
        end
        if @conta3>0 then
        @bar3 =Gchart.bar(
                    #  :size   => '570x500',
                       :size   => '570x500',
                        :bar_colors => ['FFFFFF', 'FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
                      :title  => @titulo+@titu3,
                      :legend => [' ','OBAC', 'GEX','DCA','DEM','DPC','DEC'],
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
                    :axis_range => [nil, [0,@dfin,10], [1,@conta3,1]],
                    #:min_value => 0,
                    #:max_value => 365,
                      :data   =>@adata3)
            end




              columns do

                     column do
                       panel "PROCESOS Y MONTOS POR PERIODO, LISTAS Y MERCADO AF-2017" do
                         table_for Formula.where(product_id:11)  do
                              column("Periodo PAC") do |formula|
                                formula.nombre
                              end
                              column("ACFFAA") do |formula|
                                Item.where(ejecucion:4,periodo:formula.orden).where("modalidad<3").count.to_s+ "/("+
                                   number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where("modalidad<3").sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end


                              column("Instituciones") do |formula|
                                (Item.where.not(ejecucion:4).where(periodo:formula.orden).where.not(modalidad:4).count+
    Item.where(ejecucion:4,periodo:formula.orden).where(modalidad:3).count).to_s+ "/("+
#(number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where(modalidad:3).sum(:certificado)+
number_with_delimiter((Item.where.not(ejecucion:4).where(periodo:formula.orden).where.not(modalidad:4).sum(:certificado)+
                       Item.where(ejecucion:4,periodo:formula.orden).where(modalidad:3).sum(:certificado)).to_i, delimiter: ",").to_s+ ")"




                              end
                              column("TOTAL PAC") do |formula|
                                Item.where(periodo:formula.orden).where.not(modalidad:4).count.to_s+ "/("+
                                   number_with_delimiter(Item.where(periodo:formula.orden).where.not(modalidad:4).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end

                              column("Excluidos ACFFAA") do |formula|
                                Item.where(ejecucion:4,periodo:formula.orden).where(modalidad:4).count.to_s+ "/("+
                                   number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where(modalidad:4).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                               end
                               column("Culminados ACFFAA") do |formula|
                                 Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).count.to_s+ "/("+
                                    number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                               end

                 table_for Formula.where(product_id:11)  do
                   @p=ActiveRecord::Base.connection.execute("SELECT items.periodo,
                   MAX(formulas.cantidad) as acti FROM public.items, public.details,
                   public.formulas WHERE items.id = details.item_id AND
                   details.actividad = formulas.orden AND
                   formulas.product_id = 12 AND items.ejecucion=4 and
                    items.modalidad<3 GROUP BY items.periodo,details.item_id").to_a

                                    column("Avance ACFFAA ") do |formula|
                                      formula.nombre
                                    end
                                    column("OBAC") do |formula|

                                      @p.select {|f| f["acti"]== 1 and f["periodo"]==formula.orden}.count

                                    end
                                         column("GEX") do |formula|

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
                              column("Encargo") do |formula|
                                  Item.where(ejecucion:4,modalidad:2,lista:formula.orden).count.to_s+ "/("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:2,lista:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                              end
                              column("Corporativo") do |formula|

                                  Item.where(ejecucion:4,modalidad:1,lista:formula.orden).count.to_s+ "/("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:1,lista:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                              end

                              column("TOTAL") do |formula|
                                Item.where(ejecucion:4,lista:formula.orden).where("modalidad<3").count.to_s+ "/("+
                                   number_with_delimiter(Item.where(ejecucion:4,lista:formula.orden).where("modalidad<3").sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end
                              column("Autorizacion") do |formula|
                                Item.where(ejecucion:4,modalidad:3,lista:formula.orden).count.to_s+ "/("+
                                   number_with_delimiter(Item.where(ejecucion:4,modalidad:3,lista:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end
                              column("Exclusion") do |formula|
                                Item.where(ejecucion:4,modalidad:4,lista:formula.orden).count.to_s+ "/("+
                                   number_with_delimiter(Item.where(ejecucion:4,modalidad:4,lista:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                              end

                          end
                          table_for Formula.where(product_id:6)  do
                               column("Mercado ACFFAA ") do |formula|
                                 formula.nombre
                               end
                               column("Encargo") do |formula|
                                 Item.where(ejecucion:4,modalidad:2,tipo:formula.orden).count.to_s+ "/("+
                                    number_with_delimiter(Item.where(ejecucion:4,modalidad:2,tipo:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                               end
                               column("Corporativo") do |formula|
                                 Item.where(ejecucion:4,modalidad:1,tipo:formula.orden).count.to_s+ "/("+
                                    number_with_delimiter(Item.where(ejecucion:4,modalidad:1,tipo:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                               end

                                column("TOTAL") do |formula|
                                  Item.where(ejecucion:4,tipo:formula.orden).where("modalidad<3").count.to_s+ "/("+
                                     number_with_delimiter(Item.where(ejecucion:4,tipo:formula.orden).where("modalidad<3").sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                  end
                                column("Autorizacion") do |formula|
                                       Item.where(ejecucion:4,modalidad:3,tipo:formula.orden).count.to_s+ "/("+
                                          number_with_delimiter(Item.where(ejecucion:4,modalidad:3,tipo:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                      end


                                column("Exclusion") do |formula|
                                  Item.where(ejecucion:4,modalidad:4,tipo:formula.orden).count.to_s+ "/("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:4,tipo:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                 end
                           end

                           table_for Formula.where(product_id:1,cantidad:1)  do
                                column("OBAC ACFFAA") do |formula|
                                  formula.nombre
                                end


                                column("con RJ") do |formula|
                                  Item.where(ejecucion:4,modalidad:3,obac:formula.orden).where('id IN(?)',Detail.where(actividad:8).select("item_id")).count.to_s+ "/("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:3,obac:formula.orden).where('id IN(?)',Detail.where(actividad:8).select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                 end
                                column("Autorizacion") do |formula|
                                        Item.where(ejecucion:4,modalidad:3,obac:formula.orden).count.to_s+ "/("+
                                       number_with_delimiter(Item.where(ejecucion:4,modalidad:3,obac:formula.orden).sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                end

                                 column("con RJ") do |formula|
                                   Item.where(ejecucion:4,obac:formula.orden,modalidad:4).where('id IN(?)',Detail.where(actividad:200).select("item_id")).count.to_s+ "/("+
                                      number_with_delimiter(Item.where(ejecucion:4,obac:formula.orden,modalidad:4).where('id IN(?)',Detail.where(actividad:200).select("item_id")).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                  end
                                 column("Exclusion") do |formula|
                                   Item.where(ejecucion:4,obac:formula.orden,modalidad:4).count.to_s+ "/("+
                                      number_with_delimiter(Item.where(ejecucion:4,obac:formula.orden,modalidad:4).sum(:certificado).to_i, delimiter: ",").to_s+ ")"
                                  end
                                  column("Procesos ACFFAA") do |formula|
                                          Item.where(ejecucion:4,obac:formula.orden).where("modalidad<3").count.to_s+ "/("+
                                         number_with_delimiter(Item.where(ejecucion:4,obac:formula.orden).where("modalidad<3").sum(:certificado).to_i, delimiter: ",").to_s+ ")"

                                  end



                            end

                                   end







                      end
                    end

                    column do
                    panel "Grafico de Situacion de Expedientes" do
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
