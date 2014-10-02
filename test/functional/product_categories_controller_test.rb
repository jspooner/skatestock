require 'test_helper'

class ProductCategoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:product_categories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_product_categories
    assert_difference('ProductCategories.count') do
      post :create, :product_categories => { }
    end

    assert_redirected_to product_categories_path(assigns(:product_categories))
  end

  def test_should_show_product_categories
    get :show, :id => product_categories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => product_categories(:one).id
    assert_response :success
  end

  def test_should_update_product_categories
    put :update, :id => product_categories(:one).id, :product_categories => { }
    assert_redirected_to product_categories_path(assigns(:product_categories))
  end

  def test_should_destroy_product_categories
    assert_difference('ProductCategories.count', -1) do
      delete :destroy, :id => product_categories(:one).id
    end

    assert_redirected_to product_categories_path
  end
end
