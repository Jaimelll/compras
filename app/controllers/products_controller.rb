class ProductsController < InheritedResources::Base

  private

    def product_params
      params.require(:product).permit(:nombre, :descripcion, :orden, :obs, :AdminUser_id)
    end
end

