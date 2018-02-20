class MovementsController < InheritedResources::Base

  private

    def movement_params
      params.require(:movement).permit(:estado)
    end
end

