class DetailsController < InheritedResources::Base

  private

    def detail_params
      params.require(:detail).permit(:actividad, :tipo, :numero, :pfecha, :importe, :obs, :admin_user_id, :item_id)
    end
end

