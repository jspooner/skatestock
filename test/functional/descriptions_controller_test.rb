require 'test_helper'

class DescriptionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Description.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Description.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Description.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to description_url(assigns(:description))
  end
  
  def test_edit
    get :edit, :id => Description.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Description.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Description.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Description.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Description.first
    assert_redirected_to description_url(assigns(:description))
  end
  
  def test_destroy
    description = Description.first
    delete :destroy, :id => description
    assert_redirected_to descriptions_url
    assert !Description.exists?(description.id)
  end
end
