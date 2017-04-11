ActiveAdmin.register_page "Dashboard" do

menu  priority: 1,label: proc{ I18n.t("active_admin.dashboard") }





#  action_item :MGP do
#    Formula.where( product_id:15 ).update_all( cantidad:0 )
#    Formula.where( product_id:15 ,orden:2).update_all( cantidad:1 )
#  link_to 'MGP',admin_dashboard_path
#  end




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

     @vitem=Item.where(ejecucion:4,modalidad:2).order('obac ASC')

   when 2

    @vitem=Item.where(ejecucion:4,modalidad:1).order('obac ASC')

  when 3

   @vitem=Item.where(ejecucion:4,modalidad:3).order('obac ASC')

end

@adata=[]
@alabels=[]
@blabels=[]
#@alabels2=[]
#@blabels2=[]
@vinicio = '01/01/2017'
@dfin=(Time.now-@vinicio.to_time).to_i/86400

@aobac=[]
@apec=[]
@adac=[]
@adem=[]
@adpc=[]
@adec=[]






@vitem.each do |item|

  @vfec1=@vinicio
  @vfec2=@vinicio
  @vfec3=@vinicio
  @vfec4=@vinicio
  @vfec5=@vinicio
  @vfec6=@vinicio



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

@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
#@alabels2.push(item.descripcion.first(10))



Detail.where(item_id:item.id).order('pfecha ASC').each do |detail|


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








end





unless @vprord==200

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

end


@aobac.push(@vobac)
@apec.push(@vpec)
@adac.push(@vdac)
@adem.push(@vdem)
@adpc.push(@vdpc)
@adec.push(@vdec)

end
@conta=@alabels.count
@vancho=(@conta/1.6).to_i
@ancho=@vancho.to_s

@blabels.push(@alabels.reverse.join("|"))
#@blabels2.push(@alabels2.reverse.join("|"))


@adata.push(@aobac)
@adata.push(@apec)
@adata.push(@adac)
@adata.push(@adem)
@adata.push(@adpc)
@adata.push(@adec)

@bar =Gchart.bar(
              :size   => '570x500',
              :bar_colors => ['FFFF66', 'FF8C00','33FF33','00BFFF','FF0033','483D8B'],
              :title  => @titulo,
              :legend => ['OBAC', 'PEC','DCA','DEM','DPC','DEC'],
              :orientation => 'horizontal',
              :stacked => true,

              :bg =>'EEEEEE',
              :legend_position => 'bottom',


              :bar_width_and_spacing => @ancho,

              :axis_with_labels => 'y,x,r',

             :axis_labels => [@blabels],


              :axis_range => [nil, [0,@dfin,30], [1,@conta,1]],
            #:min_value => 0,
            #:max_value => 365,
              :data   =>@adata)
              columns do
                column do
                panel "Grafico de Estado de Expeditentes" do
                   li do
                     strong { image_tag @bar}
                      end
                    end
                  end
                     column do
                       panel "PROCESOS Y MONTOS POR LISTAS, MERCADO Y PERIODO" do
                         table_for Formula.where(product_id:3)  do
                              column("Listas ") do |formula|
                                formula.nombre
                              end
                              column("Encargo") do |formula|
                                  Item.where(ejecucion:4,modalidad:2,lista:formula.orden).count.to_s+ "_("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:2,lista:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"

                              end
                              column("Corporativa") do |formula|

                                  Item.where(ejecucion:4,modalidad:1,lista:formula.orden).count.to_s+ "_("+
                                     number_with_delimiter(Item.where(ejecucion:4,modalidad:1,lista:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"

                              end
                              column("Autorizada") do |formula|
                                Item.where(ejecucion:4,modalidad:3,lista:formula.orden).count.to_s+ "_("+
                                   number_with_delimiter(Item.where(ejecucion:4,modalidad:3,lista:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"
                              end
                              column("TOTAL") do |formula|
                                Item.where(ejecucion:4,lista:formula.orden).count.to_s+ "_("+
                                   number_with_delimiter(Item.where(lista:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"
                              end
                          end
                          table_for Formula.where(product_id:6)  do
                               column("Mercado ") do |formula|
                                 formula.nombre
                               end
                               column("Encargo") do |formula|
                                 Item.where(ejecucion:4,modalidad:2,tipo:formula.orden).count.to_s+ "_("+
                                    number_with_delimiter(Item.where(ejecucion:4,modalidad:2,tipo:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"

                               end
                               column("Corporativa") do |formula|
                                 Item.where(ejecucion:4,modalidad:1,tipo:formula.orden).count.to_s+ "_("+
                                    number_with_delimiter(Item.where(ejecucion:4,modalidad:1,tipo:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"

                               end
                               column("Autorizada") do |formula|
                                 Item.where(ejecucion:4,modalidad:3,tipo:formula.orden).count.to_s+ "_("+
                                    number_with_delimiter(Item.where(ejecucion:4,modalidad:3,tipo:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"
                                end
                                column("TOTAL") do |formula|
                                  Item.where(ejecucion:4,tipo:formula.orden).count.to_s+ "_("+
                                     number_with_delimiter(Item.where(ejecucion:4,tipo:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"
                                end
                           end
                           table_for Formula.where(product_id:11)  do
                                column("Periodo ") do |formula|
                                  formula.nombre
                                end
                                column("ACFFAA") do |formula|
                                  Item.where(ejecucion:4,periodo:formula.orden).count.to_s+ "_("+
                                     number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"

                                end
                                column("Instituciones") do |formula|
                                  Item.where.not(ejecucion:4).where(periodo:formula.orden).count.to_s+ "_("+
                                     number_with_delimiter(Item.where.not(ejecucion:4).where(periodo:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"
                                end
                                column("TOTAL") do |formula|
                                  Item.where(periodo:formula.orden).count.to_s+ "_("+
                                     number_with_delimiter(Item.where(periodo:formula.orden).sum(:certificado), delimiter: ",").to_s+ ")"
                                end

                                column("Excluidos") do |formula|
                                  Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:200).select("item_id")).count.to_s+ "_("+
                                     number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:200).select("item_id")).sum(:certificado), delimiter: ",").to_s+ ")"


                                 end
                                 column("Culminados") do |formula|
                                   Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).count.to_s+ "_("+
                                      number_with_delimiter(Item.where(ejecucion:4,periodo:formula.orden).where('id IN(?)',Detail.where(actividad:300).select("item_id")).sum(:certificado), delimiter: ",").to_s+ ")"

                                 end

                   table_for Formula.where(product_id:11)  do
                                      column("Periodo ") do |formula|
                                        formula.nombre
                                      end
                                      column("OBAC") do |formula|
                                        Item.where(periodo: formula.orden,ejecucion:4).count- Item.where(periodo: formula.orden,ejecucion:4).joins(:details).
                                         order("items.id,details.pfecha DESC").
                                          select("items.id,details.pfecha,details.actividad,details.id").
                                           where('(items.id,details.pfecha) IN(?)',Detail.group("item_id").
                                           select("item_id,max(pfecha)")).
                                            where('(items.id,details.id) IN(?)',Detail.group("item_id").
                                             select("item_id,max(id)")).length+ Item.where(periodo: formula.orden,ejecucion:4).joins(:details).
                                               order("items.id,details.pfecha DESC").
                                                select("items.id,details.pfecha,details.actividad,details.id").
                                                 where('(items.id,details.pfecha) IN(?)',Detail.group("item_id").
                                                 select("item_id,max(pfecha)")).
                                                  where('(items.id,details.id) IN(?)',Detail.group("item_id").
                                                   select("item_id,max(id)")). where('actividad IN(?)',Formula .
                                                   where(product_id:12,cantidad:1).select("orden")).length


                                      end
                                           column("PEC") do |formula|
                                             Item.where(periodo: formula.orden,ejecucion:4).joins(:details).
                                              order("items.id,details.pfecha DESC").
                                               select("items.id,details.pfecha,details.actividad,details.id").
                                                where('(items.id,details.pfecha) IN(?)',Detail.group("item_id").
                                                select("item_id,max(pfecha)")).
                                                 where('(items.id,details.id) IN(?)',Detail.group("item_id").
                                                  select("item_id,max(id)")). where('actividad IN(?)',Formula .
                                                  where(product_id:12,cantidad:2).select("orden")).length

                                      end

                                      column("DC") do |formula|
                                        Item.where(periodo: formula.orden,ejecucion:4).joins(:details).
                                         order("items.id,details.pfecha DESC").
                                          select("items.id,details.pfecha,details.actividad,details.id").
                                           where('(items.id,details.pfecha) IN(?)',Detail.group("item_id").
                                           select("item_id,max(pfecha)")).
                                            where('(items.id,details.id) IN(?)',Detail.group("item_id").
                                             select("item_id,max(id)")). where('actividad IN(?)',Formula .
                                             where(product_id:12,cantidad:3).select("orden")).length


                                      end

                                      column("DEM") do |formula|
                                        Item.where(periodo: formula.orden,ejecucion:4).joins(:details).
                                         order("items.id,details.pfecha DESC").
                                          select("items.id,details.pfecha,details.actividad,details.id").
                                           where('(items.id,details.pfecha) IN(?)',Detail.group("item_id").
                                           select("item_id,max(pfecha)")).
                                            where('(items.id,details.id) IN(?)',Detail.group("item_id").
                                             select("item_id,max(id)")). where('actividad IN(?)',Formula .
                                             where(product_id:12,cantidad:4).select("orden")).length

                                       end
                                       column("DPC") do |formula|
                                         Item.where(periodo: formula.orden,ejecucion:4).joins(:details).
                                          order("items.id,details.pfecha DESC").
                                           select("items.id,details.pfecha,details.actividad,details.id").
                                            where('(items.id,details.pfecha) IN(?)',Detail.group("item_id").
                                            select("item_id,max(pfecha)")).
                                             where('(items.id,details.id) IN(?)',Detail.group("item_id").
                                              select("item_id,max(id)")). where('actividad IN(?)',Formula .
                                              where(product_id:12,cantidad:5).select("orden")).length

                                     end
                                     column("DEC") do |formula|
                                       Item.where(periodo: formula.orden,ejecucion:4).joins(:details).
                                        order("items.id,details.pfecha DESC").
                                         select("items.id,details.pfecha,details.actividad,details.id").
                                          where('(items.id,details.pfecha) IN(?)',Detail.group("item_id").
                                          select("item_id,max(pfecha)")).
                                           where('(items.id,details.id) IN(?)',Detail.group("item_id").
                                            select("item_id,max(id)")). where('actividad IN(?)',Formula .
                                            where(product_id:12,cantidad:6).select("orden")).length
                                   end
                                   column("TOTAL") do |formula|
                                     Item.where(periodo: formula.orden,ejecucion:4).count
                                 end
                                   end
                                   end







                      end
                    end
                end




  end # content



end
