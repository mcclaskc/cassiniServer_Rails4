require 'test_helper'

class EphemsControllerTest < ActionController::TestCase
  setup do
    @ephem = ephems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ephems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ephem" do
    assert_difference('Ephem.count') do
      post :create, ephem: { body_id: @ephem.body_id, timestamp: @ephem.timestamp, x: @ephem.x, y: @ephem.y, z: @ephem.z }
    end

    assert_redirected_to ephem_path(assigns(:ephem))
  end

  test "should show ephem" do
    get :show, id: @ephem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ephem
    assert_response :success
  end

  test "should update ephem" do
    patch :update, id: @ephem, ephem: { body_id: @ephem.body_id, timestamp: @ephem.timestamp, x: @ephem.x, y: @ephem.y, z: @ephem.z }
    assert_redirected_to ephem_path(assigns(:ephem))
  end

  test "should destroy ephem" do
    assert_difference('Ephem.count', -1) do
      delete :destroy, id: @ephem
    end

    assert_redirected_to ephems_path
  end
end
