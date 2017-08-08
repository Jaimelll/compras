
ActiveAdmin.register_page "grafico0" do

  menu  priority: 3,label: "Grafico Procesos"

  action_item :only=> :index do
      link_to 'DPC', dpc2_admin_product_formula_path(1, :@num), method: :put

  end

  action_item :only=> :index do
      link_to 'DEC', dec2_admin_product_formula_path(1, :@num), method: :put

  end



  content title: "Grafico" do

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
     #datos de grafico var y titulo, vaf de año fiscal
     @var=Formula.where(product_id:15,numero:1).
                          select('orden as dd').first.dd
     @titulo=Formula.where(product_id:15,numero:1).
                          select('nombre as dd').first.dd
      @vaf=Formula.where(product_id:11,cantidad:1).select('orden as dd').first.dd




      case @var

      when 9
         #dpc2
         @vitem=Phase.where('sele<=5')
         .where(periodo:@vaf)
         @iproce=100

       when 10
       #dec2
       @vitem=Phase.where('sele=6 or sele=7')
       .where(periodo:@vaf)
        @iproce=100
      end #case












    @adata=[]
    @alabels=[]
    @blabels=[]




    @aversion=[]
    @aobac=[]
    @apec=[]
    @adac=[]
    @adem=[]
    @adpc=[]
    @adec=[]
    @aeobac=[]
    @conta=0




    @vproceso=[]

    #*******************************************************************

    @vitem.each do |item|

      #prueba conta

      #empieza el item

    @vfec1=Time.now

    @vproceso=[0,0,0,0,0,0,0,0]

    @uproc=8
    @corta=0

    @nconta1=0


      #@nconta numero de actividades

    #comienza case
    case   @vaf
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


      @nconta=Activity.where(phase_id:item.id).
         where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).count
       @deta2=Activity.where(phase_id:item.id).
              where("pfecha>=? and pfecha<=? ", @vinicio,@vfin ).
             order('pfecha DESC,id DESC')


    @deta1=@deta2.where(phase_id:item.id)




      @vlog=false

    if @deta1.count==0 then

      object = Activity.new(:actividad => 18, :pfecha=> @vinicio,
       :phase_id => item.id,:admin_user_id => 2,:created_at =>@vinicio,
       :updated_at => @vinicio,:tipo =>'automatico')
      object.save


    end

    @deta1.each do |detail|

      #empieza detail
    #end
    #termina cas
      @nconta1=@nconta1+1


    if detail.pfecha and detail.actividad  then
    @vproc=Formula.where(product_id:12,orden:detail.actividad).
                         select('cantidad as dd').first.dd
    #proceso
    @vprord=detail.actividad
    #actividad




    #inicio de phase if 280 al 392*************************************************************

    # fin phase del 280 al 392************************************************************


    @vlog=true


###################





    # empieza @vlog


       unless @vprord==200 or @vprord==300 or ( @vprord==8 and item.modalidad==3)
         if  @uproc>=@vproc then

                @vproceso[@vproc]=@vproceso[@vproc]+
                ( @vfec1-detail.pfecha.to_time).to_i/86400

              #  if @nconta1==1 then
              #     @vproceso[@vproc]=@vproceso[@vproc]+2
              #  end
                @uproc=@vproc
          else
                @vproceso[@uproc]=@vproceso[@uproc]+
                ( @vfec1-detail.pfecha.to_time).to_i/86400


           end
        else
           @corta=( @vfec1-detail.pfecha.to_time).to_i/86400


        end #de unless


        if @nconta1==@nconta then
      #    if @vprord==36 then
               @vproceso[0]= ( detail.pfecha.to_time-
               @vinicio.to_time).to_i/86400
    #       end

         @vproceso[@vproc]=@vproceso[@vproc]+
         ( detail.pfecha.to_time-@vinicio.to_time).to_i/86400-@vproceso[0]



        end  #if  @nconta1


      @vfec1=detail.pfecha.to_time



    end #termina actividad


    end #termina detail??






    # empieza @vlog



    @vversion=@vproceso[0]
       @vobac=@vproceso[1]
        @vpec=@vproceso[2]
        @vdac=@vproceso[3]
        @vdem=@vproceso[4]
        @vdpc=@vproceso[5]
        @vdec=@vproceso[6]
        @veobac=@vproceso[7]












    #@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
    #@alabels2.push(item.descripcion.first(10))
    @desc=item.descripcion.underscore

    if @desc[0,3]=='adq' then
        @desc=@desc[15,54]
    else
     @desc=@desc

    end


    #@alabels.push(item.pac+"--------"+number_with_delimiter(item.certificado, delimiter: ",").to_s+"----"+@n1)
    @lab1=@desc.capitalize.truncate(40)+"-"+item.nomenclatura






       @alabels.push(@lab1)
       @aversion.push(@vversion)
       @aobac.push(@vobac)
       @apec.push(@vpec)
       @adac.push(@vdac)
       @adem.push(@vdem)
       @adpc.push(@vdpc)
       @adec.push(@vdec)
       @aeobac.push(@veobac)





    end #terminia  item
    #termina item***********************************************

    columns do
           column do


#@alabels=@alabels.map { |i| " '" + i + "'" }.join(',')
#@alabels=@alabels.join(",")

               render :partial => "grafico0",
               :locals => { :param1 => @alabels,
                            :param2 => @aversion,
                            :param3 => @aobac,
                            :param4 => @apec,
                            :param5 => @adac,
                            :param6 => @adem,
                            :param7 => @adpc,
                            :param8 => @adec,
                            :param9 => @aeobac,
                            :param20 =>  @titulo+@vtitun}


           end
     end
  end
end
