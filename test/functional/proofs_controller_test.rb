require 'test_helper'

class ProofsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:proofs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_proof
    assert_difference('Proof.count') do
      post :create, :proof => { }
    end

    assert_redirected_to proof_path(assigns(:proof))
  end

  def test_should_show_proof
    get :show, :id => proofs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => proofs(:one).id
    assert_response :success
  end

  def test_should_update_proof
    put :update, :id => proofs(:one).id, :proof => { }
    assert_redirected_to proof_path(assigns(:proof))
  end

  def test_should_destroy_proof
    assert_difference('Proof.count', -1) do
      delete :destroy, :id => proofs(:one).id
    end

    assert_redirected_to proofs_path
  end
end
