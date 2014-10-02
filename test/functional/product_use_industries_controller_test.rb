require 'test_helper'

class ProductUseIndustriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:product_use_industries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_product_use_industry
    assert_difference('ProductUseIndustry.count') do
      post :create, :product_use_industry => { }
    end

    assert_redirected_to product_use_industry_path(assigns(:product_use_industry))
  end

  def test_should_show_product_use_industry
    get :show, :id => product_use_industries(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => product_use_industries(:one).id
    assert_response :success
  end

  def test_should_update_product_use_industry
    put :update, :id => product_use_industries(:one).id, :product_use_industry => { }
    assert_redirected_to product_use_industry_path(assigns(:product_use_industry))
  end

  def test_should_destroy_product_use_industry
    assert_difference('ProductUseIndustry.count', -1) do
      delete :destroy, :id => product_use_industries(:one).id
    end

    assert_redirected_to product_use_industries_path
  end
end
