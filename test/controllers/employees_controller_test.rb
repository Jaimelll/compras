require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { admin_user_id: @employee.admin_user_id, afp: @employee.afp, ape_mat: @employee.ape_mat, ape_nom: @employee.ape_nom, ape_pat: @employee.ape_pat, cargo: @employee.cargo, correo: @employee.correo, correo_corp: @employee.correo_corp, direccion: @employee.direccion, dni: @employee.dni, esta_civil: @employee.esta_civil, estado: @employee.estado, fec_inicon: @employee.fec_inicon, fec_nacimiento: @employee.fec_nacimiento, fec_tercon: @employee.fec_tercon, foto: @employee.foto, grado: @employee.grado, nombres: @employee.nombres, telefono: @employee.telefono, tip_tra: @employee.tip_tra } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { admin_user_id: @employee.admin_user_id, afp: @employee.afp, ape_mat: @employee.ape_mat, ape_nom: @employee.ape_nom, ape_pat: @employee.ape_pat, cargo: @employee.cargo, correo: @employee.correo, correo_corp: @employee.correo_corp, direccion: @employee.direccion, dni: @employee.dni, esta_civil: @employee.esta_civil, estado: @employee.estado, fec_inicon: @employee.fec_inicon, fec_nacimiento: @employee.fec_nacimiento, fec_tercon: @employee.fec_tercon, foto: @employee.foto, grado: @employee.grado, nombres: @employee.nombres, telefono: @employee.telefono, tip_tra: @employee.tip_tra } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end
