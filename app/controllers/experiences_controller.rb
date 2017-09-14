class ExperiencesController < InheritedResources::Base

  private

    def experience_params
      params.require(:experience).permit(:employee_id, :empresa, :desde, :hasta, :cargo, :obs, :admin_user_id)
    end
end

