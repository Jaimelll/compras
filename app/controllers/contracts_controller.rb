class ContractsController < InheritedResources::Base

  private

    def contract_params
      params.require(:contract).permit(:numero, :fecha, :descripcion, :obac, :postor, :proveedor, :moneda, :adjudicado, :presupuestado, :admin_user_id)
    end
end

