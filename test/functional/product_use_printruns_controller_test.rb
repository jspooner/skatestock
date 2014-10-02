require 'test_helper'

class ProductUsePrintrunsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:product_use_printruns)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_product_use_printrun
    assert_difference('ProductUsePrintrun.count') do
      post :create, :product_use_printrun => { }
    end

    assert_redirected_to product_use_printrun_path(assigns(:product_use_printrun))
  end

  def test_should_show_product_use_printrun
    get :show, :id => product_use_printruns(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => product_use_printruns(:one).id
    assert_response :success
  end

  def test_should_update_product_use_printrun
    put :update, :id => product_use_printruns(:one).id, :product_use_printrun => { }
    assert_redirected_to product_use_printrun_path(assigns(:product_use_printrun))
  end

  def test_should_destroy_product_use_printrun
    assert_difference('ProductUsePrintrun.count', -1) do
      delete :destroy, :id => product_use_printruns(:one).id
    end

    assert_redirected_to product_use_printruns_path
  end
end
