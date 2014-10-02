class Order < ActiveRecord::Base
  # BEGIN has_many_transactions
  has_many :transactions, 
           :class_name => 'OrderTransaction', 
           :dependent => :destroy
  # END has_many_transactions

  # BEGIN acts_as_state_machine
  acts_as_state_machine :initial => :pending

  state :pending
  state :authorized
  state :paid
  state :payment_declined

  event :payment_authorized do
    transitions :from => :pending, 
                :to   => :authorized

    transitions :from => :payment_declined, 
                :to   => :authorized
  end

  event :payment_captured do
    transitions :from => :authorized, 
                :to   => :paid
  end

  event :transaction_declined do
    transitions :from => :pending, 
                :to   => :payment_declined

    transitions :from => :payment_declined, 
                :to   => :payment_declined

    transitions :from => :authorized, 
                :to   => :authorized
  end
  # END acts_as_state_machine

  # BEGIN number
  def number
    CGI::Session.generate_unique_id
  end
  # END number

  # BEGIN authorize_payment
  def authorize_payment(credit_card, options = {})
    options[:order_id] = number
    
        transaction do
    
          authorization = OrderTransaction.authorize(amount, credit_card, options)
          transactions.push(authorization)
    
          if authorization.success?
            payment_authorized!
          else
            transaction_declined!
          end
    
          authorization
        end
  end
  # END authorize_payment

  # BEGIN capture_payment
  def capture_payment(options = {})
    transaction do
      capture = OrderTransaction.capture(amount, authorization_reference, options)
      transactions.push(capture)
      if capture.success?
        payment_captured!
      else
        transaction_declined!
      end

      capture
    end
  end
  # END capture_payment

  # BEGIN authorization_reference
  def authorization_reference
    puts '[call] authorization_reference'
    puts "[call] authorization_reference authorization #{transactions}"
    if authorization = transactions.find_by_action_and_success('authorization', true, :order => 'id ASC')
      authorization.reference
    end
  end
  # END authorization_reference
end
