require 'test_helper'

class PriceOptionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:price_options)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_price_option
    assert_difference('PriceOption.count') do
      post :create, :price_option => { }
    end

    assert_redirected_to price_option_path(assigns(:price_option))
  end

  def test_should_show_price_option
    get :show, :id => price_options(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => price_options(:one).id
    assert_response :success
  end

  def test_should_update_price_option
    put :update, :id => price_options(:one).id, :price_option => { }
    assert_redirected_to price_option_path(assigns(:price_option))
  end

  def test_should_destroy_price_option
    assert_difference('PriceOption.count', -1) do
      delete :destroy, :id => price_options(:one).id
    end

    assert_redirected_to price_options_path
  end
end
