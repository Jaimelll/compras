require 'test_helper'

class AgreementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agreement = agreements(:one)
  end

  test "should get index" do
    get agreements_url
    assert_response :success
  end

  test "should get new" do
    get new_agreement_url
    assert_response :success
  end

  test "should create agreement" do
    assert_difference('Agreement.count') do
      post agreements_url, params: { agreement: { admin_user_id: @agreement.admin_user_id, area: @agreement.area, cod_hor: @agreement.cod_hor, employee_id: @agreement.employee_id, fec_inicon: @agreement.fec_inicon, fec_retiro: @agreement.fec_retiro, fec_tercon: @agreement.fec_tercon, motivo_retir: @agreement.motivo_retir, num_cont: @agreement.num_cont, obs: @agreement.obs, puesto: @agreement.puesto, remuneracion: @agreement.remuneracion, tipo_contra: @agreement.tipo_contra } }
    end

    assert_redirected_to agreement_url(Agreement.last)
  end

  test "should show agreement" do
    get agreement_url(@agreement)
    assert_response :success
  end

  test "should get edit" do
    get edit_agreement_url(@agreement)
    assert_response :success
  end

  test "should update agreement" do
    patch agreement_url(@agreement), params: { agreement: { admin_user_id: @agreement.admin_user_id, area: @agreement.area, cod_hor: @agreement.cod_hor, employee_id: @agreement.employee_id, fec_inicon: @agreement.fec_inicon, fec_retiro: @agreement.fec_retiro, fec_tercon: @agreement.fec_tercon, motivo_retir: @agreement.motivo_retir, num_cont: @agreement.num_cont, obs: @agreement.obs, puesto: @agreement.puesto, remuneracion: @agreement.remuneracion, tipo_contra: @agreement.tipo_contra } }
    assert_redirected_to agreement_url(@agreement)
  end

  test "should destroy agreement" do
    assert_difference('Agreement.count', -1) do
      delete agreement_url(@agreement)
    end

    assert_redirected_to agreements_url
  end
end
