class PaymentNotification < ActiveRecord::Base
  belongs_to :cart
  serialize :params
  after_create :mark_cart_as_purchased
  
  private
  
  def mark_cart_as_purchased
    paypal_price = normalize_cents params[:payment_gross].to_s
    our_price    = normalize_cents cart.total_price.to_s
    # if price.slice(price.length-3...price.length) ==".00"
    #   price = price.slice(0...price.length-3)
    # end
    # if price.slice(price.length-2...price.length) ==".0"
    #   price = price.slice(0...price.length-2)
    # end
    logger.info "Validate PayPal Price " + paypal_price + " cart price " + our_price.to_s
    if status == "Completed" && params[:secret] == APP_CONFIG[:paypal_secret] &&
        params[:receiver_email] == APP_CONFIG[:paypal_email] &&
        paypal_price == our_price.to_s && params[:mc_currency] == "USD"
      cart.update_attribute(:purchased_at, Time.now)
      puts 'DONE'
    else
      puts 'SOME THING DIDNT MATCH'
    end
  end
  
  def normalize_cents(p)
    logger.info "Price Before Normilization " + p
    if p.slice(p.length-3...p.length-2) == "."
      # price is ok
    elsif p.slice(p.length-3...p.length) == ".00"
      # price is ok
    elsif p.slice(p.length-2...p.length) == ".0"
      p += "0"
    elsif p.slice(p.length-1, p.length) == "."
      p += "00"
    end
    logger.info "Price After Normilization " + p
    p
  end
end
