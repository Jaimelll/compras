class PhasesController < InheritedResources::Base

  private

    def phase_params
      params.require(:phase).permit(:nomenclatura, :descripcion, :moneda, :valor, :admin_user_id)
    end
end

