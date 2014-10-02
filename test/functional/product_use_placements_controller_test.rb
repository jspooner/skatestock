require 'test_helper'

class ProductUsePlacementsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:product_use_placements)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_product_use_placement
    assert_difference('ProductUsePlacement.count') do
      post :create, :product_use_placement => { }
    end

    assert_redirected_to product_use_placement_path(assigns(:product_use_placement))
  end

  def test_should_show_product_use_placement
    get :show, :id => product_use_placements(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => product_use_placements(:one).id
    assert_response :success
  end

  def test_should_update_product_use_placement
    put :update, :id => product_use_placements(:one).id, :product_use_placement => { }
    assert_redirected_to product_use_placement_path(assigns(:product_use_placement))
  end

  def test_should_destroy_product_use_placement
    assert_difference('ProductUsePlacement.count', -1) do
      delete :destroy, :id => product_use_placements(:one).id
    end

    assert_redirected_to product_use_placements_path
  end
end
