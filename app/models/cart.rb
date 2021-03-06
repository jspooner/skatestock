class Cart < ActiveRecord::Base
  has_many :line_items
  belongs_to :user
  has_many :payment_notifications
  
  named_scope :paid, :conditions => "purchased_at IS NOT NULL"
  
  def get_total_price
    # convert to array so it doesn't try to do sum on database directly
    # need to make this a flot with .00
    self.line_items.to_a.sum(&:price)
  end
  
  def paypal_encrypted(return_url, notify_url)
    values = {
      :business => APP_CONFIG[:paypal_email],
      :cmd => '_cart',
      :upload => 1,
      :return => APP_CONFIG[:domain] + return_url,
      :invoice => self.id.to_s + APP_CONFIG[:invoice_system],
      :notify_url => notify_url,
      :cert_id => APP_CONFIG[:paypal_cert_id]
    }
    line_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.price,
        "item_name_#{index+1}" => item.id.to_s,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => 1
      })
    end
    puts values.to_query
    encrypt_for_paypal(values)
  end
  
  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM    = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM     = File.read("#{Rails.root}/certs/app_key.pem")
  
  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
end
