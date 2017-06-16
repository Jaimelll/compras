class PiecesController < InheritedResources::Base

  private

    def piece_params
      params.require(:piece).permit(:codigo, :descripcion, :estado, :moneda, :presupuestado, :referencial, :adjudicado, :postor, :phase_id, :admin_user_id)
    end
end

