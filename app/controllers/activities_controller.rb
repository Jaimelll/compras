class ActivitiesController < InheritedResources::Base

  private

    def activity_params
      params.require(:activity).permit(:actividad, :tipo, :numero, :pfecha, :plan, :moneda, :importe, :obs, :phase_id, :admin_user_id)
    end
end

