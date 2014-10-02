require 'test_helper'

class ProductUseDurationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:product_use_durations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_product_use_duration
    assert_difference('ProductUseDuration.count') do
      post :create, :product_use_duration => { }
    end

    assert_redirected_to product_use_duration_path(assigns(:product_use_duration))
  end

  def test_should_show_product_use_duration
    get :show, :id => product_use_durations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => product_use_durations(:one).id
    assert_response :success
  end

  def test_should_update_product_use_duration
    put :update, :id => product_use_durations(:one).id, :product_use_duration => { }
    assert_redirected_to product_use_duration_path(assigns(:product_use_duration))
  end

  def test_should_destroy_product_use_duration
    assert_difference('ProductUseDuration.count', -1) do
      delete :destroy, :id => product_use_durations(:one).id
    end

    assert_redirected_to product_use_durations_path
  end
end
