require 'test_helper'

class ElementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @element = elements(:one)
  end

  test "should get index" do
    get elements_url
    assert_response :success
  end

  test "should get new" do
    get new_element_url
    assert_response :success
  end

  test "should create element" do
    assert_difference('Element.count') do
      post elements_url, params: { element: { actividad: @element.actividad, admin_user_id: @element.admin_user_id, contract_id: @element.contract_id, importe: @element.importe, inicial: @element.inicial, moneda: @element.moneda, numero: @element.numero, obs: @element.obs, pfecha: @element.pfecha, plan: @element.plan, tipo: @element.tipo } }
    end

    assert_redirected_to element_url(Element.last)
  end

  test "should show element" do
    get element_url(@element)
    assert_response :success
  end

  test "should get edit" do
    get edit_element_url(@element)
    assert_response :success
  end

  test "should update element" do
    patch element_url(@element), params: { element: { actividad: @element.actividad, admin_user_id: @element.admin_user_id, contract_id: @element.contract_id, importe: @element.importe, inicial: @element.inicial, moneda: @element.moneda, numero: @element.numero, obs: @element.obs, pfecha: @element.pfecha, plan: @element.plan, tipo: @element.tipo } }
    assert_redirected_to element_url(@element)
  end

  test "should destroy element" do
    assert_difference('Element.count', -1) do
      delete element_url(@element)
    end

    assert_redirected_to elements_url
  end
end
