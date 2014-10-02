require 'test_helper'

class MastersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:masters)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_master
    assert_difference('Master.count') do
      post :create, :master => { }
    end

    assert_redirected_to master_path(assigns(:master))
  end

  def test_should_show_master
    get :show, :id => masters(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => masters(:one).id
    assert_response :success
  end

  def test_should_update_master
    put :update, :id => masters(:one).id, :master => { }
    assert_redirected_to master_path(assigns(:master))
  end

  def test_should_destroy_master
    assert_difference('Master.count', -1) do
      delete :destroy, :id => masters(:one).id
    end

    assert_redirected_to masters_path
  end
end
