require 'test_helper'

class RepairLogsControllerTest < ActionController::TestCase
  setup do
    @repair_log = repair_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repair_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repair_log" do
    assert_difference('RepairLog.count') do
      post :create, repair_log: @repair_log.attributes
    end

    assert_redirected_to repair_log_path(assigns(:repair_log))
  end

  test "should show repair_log" do
    get :show, id: @repair_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repair_log
    assert_response :success
  end

  test "should update repair_log" do
    put :update, id: @repair_log, repair_log: @repair_log.attributes
    assert_redirected_to repair_log_path(assigns(:repair_log))
  end

  test "should destroy repair_log" do
    assert_difference('RepairLog.count', -1) do
      delete :destroy, id: @repair_log
    end

    assert_redirected_to repair_logs_path
  end
end
