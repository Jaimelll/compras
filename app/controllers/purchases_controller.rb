class PurchasesController < InheritedResources::Base

  private

    def purchase_params
      params.require(:purchase).permit(:proceso)
    end
end

