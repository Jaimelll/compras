ActiveAdmin.register_page "Dashboard" do
menu  priority: 1,label: proc{ I18n.t("active_admin.dashboard") }


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
    br
@adata=[]
@alabels=[]
@blabels=[]
@vinicio = '01/01/2017'
@dfin=(Time.now-@vinicio.to_time).to_i/86400

@aobac=[]
@apec=[]
@adac=[]
@adem=[]
@adpc=[]

@vfec1=@vinicio
@vfec2=@vinicio
@vfec3=@vinicio
@vfec4=@vinicio
@vfec5=@vinicio

Item.where(ejecucion:4).order('obac ASC').each do |item|

@vobac=0
@vpec=0
@vdac=0
@vdem=0
@vdpc=0


@uproc=1
if item.obac and item.obac>0 then
    @n1=Formula.where(product_id:1, orden:item.obac).
       select('nombre as dd').first.dd

else
    @n1="s/d"
end

@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
Detail.where(item_id:item.id).order('pfecha ASC').each do |detail|
@vproc=Formula.where(product_id:12,orden:detail.actividad).
                     select('cantidad as dd').first.dd
@vprord=Formula.where(product_id:12,orden:detail.actividad).
            select('orden as dd').first.dd


if @vproc==1 then
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






end





unless @vprord==200
  case @uproc
     when 1
       @vobac=@dfin
     when 2
       @vpec=@dfin-@vobac
    when 3
       @vdac=@dfin-@vobac-@vpec
    when 4
       @vdem=@dfin-@vobac-@vpec-@vdac
     when 5
        @vdpc=@dfin-@vobac-@vpec-@vdac- @vdem
  end
end


@aobac.push(@vobac)
@apec.push(@vpec)
@adac.push(@vdac)
@adem.push(@vdem)
@adpc.push(@vdpc)

end
@blabels.push(@alabels.reverse.join("|"))

@adata.push(@aobac)
@adata.push(@apec)
@adata.push(@adac)
@adata.push(@adem)
@adata.push(@adpc)

@bar =Gchart.bar(
              :size   => '600x500',
              :bar_colors => ['FFD700', 'FF8C00','228B22','2F4F4F','00BFFF'],
              :title  => "Estado de expedientes",
              :legend => ['OBAC', 'PEC','DAC','DEM','DPC'],
              :orientation => 'horizontal',
              :stacked => true,

              :bg =>'EEEEEE',
              :legend_position => 'bottom',


              :bar_width_and_spacing => '5',

              :axis_with_labels => 'y,x',

             :axis_labels => @blabels,


              :axis_range => [nil, [0,@dfin,30]],
            #:min_value => 0,
            #:max_value => 365,
              :data   =>@adata)

   strong { image_tag @bar}


  end # content
end
