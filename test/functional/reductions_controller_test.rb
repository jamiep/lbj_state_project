require 'test_helper'

class ReductionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reductions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reduction" do
    assert_difference('Reduction.count') do
      post :create, :reduction => { }
    end

    assert_redirected_to reduction_path(assigns(:reduction))
  end

  test "should show reduction" do
    get :show, :id => reductions(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => reductions(:one).id
    assert_response :success
  end

  test "should update reduction" do
    put :update, :id => reductions(:one).id, :reduction => { }
    assert_redirected_to reduction_path(assigns(:reduction))
  end

  test "should destroy reduction" do
    assert_difference('Reduction.count', -1) do
      delete :destroy, :id => reductions(:one).id
    end

    assert_redirected_to reductions_path
  end
end
