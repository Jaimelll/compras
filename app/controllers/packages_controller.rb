class PackagesController < InheritedResources::Base

  private

    def package_params
      params.require(:package).permit(:item, :moneda, :adjudicado, :presupuestado, :admin_user_id, :contract_id)
    end
end

