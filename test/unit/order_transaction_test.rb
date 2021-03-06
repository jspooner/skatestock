require 'test_helper'

class OrderTransactionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
 
  def setup 
    @amount = 100 
  end 
  def test_successful_authorization 
    auth = OrderTransaction.authorize( 
              @amount, 
              credit_card(:number => '1') 
            ) 
    assert auth.success 
    assert_equal 'authorization', auth.action 
    assert_equal BogusGateway::SUCCESS_MESSAGE, auth.message 
    assert_equal BogusGateway::AUTHORIZATION, auth[:reference] 
  end 

  def test_failed_authorization 
    auth = OrderTransaction.authorize( 
              @amount, 
              credit_card(:number => '2') 
            ) 
    assert !auth.success 
    assert_equal 'authorization', auth.action 
    assert_equal BogusGateway::FAILURE_MESSAGE, auth.message 
  end 

  def test_exception_during_authorization 
    auth = OrderTransaction.authorize( 
              @amount, 
              credit_card(:number => '3') 
            ) 
    assert !auth.success 
    assert_equal 'authorization', auth.action 
    assert_equal BogusGateway::ERROR_MESSAGE, auth.message 
  end
              
              
              
              
              
              
end
