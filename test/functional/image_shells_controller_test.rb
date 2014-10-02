require 'test_helper'

class ImageShellsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ImageShell.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    ImageShell.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    ImageShell.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to image_shell_url(assigns(:image_shell))
  end
  
  def test_edit
    get :edit, :id => ImageShell.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    ImageShell.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ImageShell.first
    assert_template 'edit'
  end
  
  def test_update_valid
    ImageShell.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ImageShell.first
    assert_redirected_to image_shell_url(assigns(:image_shell))
  end
  
  def test_destroy
    image_shell = ImageShell.first
    delete :destroy, :id => image_shell
    assert_redirected_to image_shells_url
    assert !ImageShell.exists?(image_shell.id)
  end
end
