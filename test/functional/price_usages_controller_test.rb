require 'test_helper'

class PriceUsagesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:price_usages)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_price_usage
    assert_difference('PriceUsage.count') do
      post :create, :price_usage => { }
    end

    assert_redirected_to price_usage_path(assigns(:price_usage))
  end

  def test_should_show_price_usage
    get :show, :id => price_usages(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => price_usages(:one).id
    assert_response :success
  end

  def test_should_update_price_usage
    put :update, :id => price_usages(:one).id, :price_usage => { }
    assert_redirected_to price_usage_path(assigns(:price_usage))
  end

  def test_should_destroy_price_usage
    assert_difference('PriceUsage.count', -1) do
      delete :destroy, :id => price_usages(:one).id
    end

    assert_redirected_to price_usages_path
  end
end
