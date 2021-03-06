ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  include ActiveMerchant::Billing 

  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  # BEGIN address
  def address(options = {})
    { :name     => 'Cody Fauser',
      :address1 => '2500 Oak Mills Road',
      :address2 => 'Suite 1000',
      :city     => 'Beverly Hills', 
      :state    => 'CA',
      :country  => 'US',
      :zip      => '90210'
    }.update(options)
  end
  # END address
  
  # BEGIN credit_card_hash
  def credit_card_hash(options = {})
    { :number     => '1',
      :first_name => 'Cody',
      :last_name  => 'Fauser',
      :month      => '8',
      :year       => "#{ Time.now.year + 1 }",
      :verification_value => '123',
      :type       => 'visa' 
    }.update(options)
  end
  # END credit_card_hash

  # BEGIN credit_card
  def credit_card(options = {})
    ActiveMerchant::Billing::CreditCard.new( credit_card_hash(options) )
  end
  # END credit_card
  # Add more helper methods to be used by all tests here...
end
