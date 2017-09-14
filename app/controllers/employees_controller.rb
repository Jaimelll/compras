class EmployeesController < InheritedResources::Base

  private

    def employee_params
      params.require(:employee).permit(:dni, :ape_pat, :ape_mat, :nombres, :direccion, :telefono, :correo, :fec_nacimiento, :estado, :tip_tra, :esta_civil, :afp, :admin_user_id, :foto, :ape_nom, :correo_corp, :fec_inicon, :fec_tercon, :grado, :cargo)
    end
end

