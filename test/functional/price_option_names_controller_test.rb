require 'test_helper'

class PriceOptionNamesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:price_option_names)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_price_option_name
    assert_difference('PriceOptionName.count') do
      post :create, :price_option_name => { }
    end

    assert_redirected_to price_option_name_path(assigns(:price_option_name))
  end

  def test_should_show_price_option_name
    get :show, :id => price_option_names(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => price_option_names(:one).id
    assert_response :success
  end

  def test_should_update_price_option_name
    put :update, :id => price_option_names(:one).id, :price_option_name => { }
    assert_redirected_to price_option_name_path(assigns(:price_option_name))
  end

  def test_should_destroy_price_option_name
    assert_difference('PriceOptionName.count', -1) do
      delete :destroy, :id => price_option_names(:one).id
    end

    assert_redirected_to price_option_names_path
  end
end
