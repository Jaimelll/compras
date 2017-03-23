class FormulasController < InheritedResources::Base

  private

    def formula_params
      params.require(:formula).permit(:nombre, :descripcion, :orden, :obs, :cantidad, :admin_user_id, :product_id)
    end
end

