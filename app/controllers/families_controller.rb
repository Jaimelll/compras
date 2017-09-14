class FamiliesController < InheritedResources::Base

  private

    def family_params
      params.require(:family).permit(:employee_id, :tipo_rela, :ape_nom, :fec_nac, :admin_user_id)
    end
end

