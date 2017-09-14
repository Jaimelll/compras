class StudentsController < InheritedResources::Base

  private

    def student_params
      params.require(:student).permit(:employee_id, :centro, :especialidad, :desde, :hasta, :grado, :obs, :admin_user_id)
    end
end

