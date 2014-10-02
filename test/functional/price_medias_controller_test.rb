require 'test_helper'

class PriceMediasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:price_medias)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_price_media
    assert_difference('PriceMedia.count') do
      post :create, :price_media => { }
    end

    assert_redirected_to price_media_path(assigns(:price_media))
  end

  def test_should_show_price_media
    get :show, :id => price_medias(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => price_medias(:one).id
    assert_response :success
  end

  def test_should_update_price_media
    put :update, :id => price_medias(:one).id, :price_media => { }
    assert_redirected_to price_media_path(assigns(:price_media))
  end

  def test_should_destroy_price_media
    assert_difference('PriceMedia.count', -1) do
      delete :destroy, :id => price_medias(:one).id
    end

    assert_redirected_to price_medias_path
  end
end
