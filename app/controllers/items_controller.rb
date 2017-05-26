class ItemsController < InheritedResources::Base

  private

    def item_params
      params.require(:item).permit(:pac, :periodo, :obac, :lista, :ejecucion, :modalidad, :dependencia, :tipo, :descripcion, :cantidad, :certificado, :constancia, :moneda, :fuente, :ccp, :cpr, :rubro, :admin_user_id, :exped)
    end
end
