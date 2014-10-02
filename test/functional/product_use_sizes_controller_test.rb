require 'test_helper'

class ProductUseSizesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:product_use_sizes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_product_use_size
    assert_difference('ProductUseSize.count') do
      post :create, :product_use_size => { }
    end

    assert_redirected_to product_use_size_path(assigns(:product_use_size))
  end

  def test_should_show_product_use_size
    get :show, :id => product_use_sizes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => product_use_sizes(:one).id
    assert_response :success
  end

  def test_should_update_product_use_size
    put :update, :id => product_use_sizes(:one).id, :product_use_size => { }
    assert_redirected_to product_use_size_path(assigns(:product_use_size))
  end

  def test_should_destroy_product_use_size
    assert_difference('ProductUseSize.count', -1) do
      delete :destroy, :id => product_use_sizes(:one).id
    end

    assert_redirected_to product_use_sizes_path
  end
end
