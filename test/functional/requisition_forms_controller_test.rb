require 'test_helper'

class RequisitionFormsControllerTest < ActionController::TestCase
  setup do
    @requisition_form = requisition_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requisition_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requisition_form" do
    assert_difference('RequisitionForm.count') do
      post :create, requisition_form: {  }
    end

    assert_redirected_to requisition_form_path(assigns(:requisition_form))
  end

  test "should show requisition_form" do
    get :show, id: @requisition_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @requisition_form
    assert_response :success
  end

  test "should update requisition_form" do
    put :update, id: @requisition_form, requisition_form: {  }
    assert_redirected_to requisition_form_path(assigns(:requisition_form))
  end

  test "should destroy requisition_form" do
    assert_difference('RequisitionForm.count', -1) do
      delete :destroy, id: @requisition_form
    end

    assert_redirected_to requisition_forms_path
  end
end
