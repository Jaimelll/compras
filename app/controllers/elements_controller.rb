class ElementsController < InheritedResources::Base

  private

    def element_params
      params.require(:element).permit(:actividad, :tipo, :numero, :pfecha, :importe, :obs, :admin_user_id, :contract_id, :moneda, :plan, :inicial)
    end
end

