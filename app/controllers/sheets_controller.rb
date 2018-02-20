class SheetsController < InheritedResources::Base

  private

    def sheet_params
      params.require(:sheet).permit(:codigo_ficha)
    end
end

