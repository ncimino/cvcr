class Cart < ActiveRecord::Base
  has_many :line_items

  def total_price
    # convert to array so it doesn't try to do sum on database directly
    line_items.to_a.sum(&:full_price)+total_shipping
  end

  def total_shipping
    price_1_2 = 5.6
    price_3_6 = 12.35
    price_7_8 = 16.85
    price_other = 0
    if total_items > 8
      price_other
    elsif total_items >= 7
      price_7_8
    elsif total_items >= 3
      price_3_6
    elsif total_items >= 1
      price_1_2
    else
      price_other
    end
  end

  def total_items
    # convert to array so it doesn't try to do sum on database directly
    line_items.to_a.sum(&:quantity)
  end

  def paypal_url(return_url, notify_url)
    values = {
        :business => 'nik.cimino-facilitator@gmail.com',
        :cmd => '_cart',
        :upload => 1,
        :return => return_url,
        :invoice => id,
        :notify_url => notify_url
    }
    line_items.each_with_index do |item, index|
      values.merge!({
                        "amount_#{index+1}" => item.unit_price,
                        "item_name_#{index+1}" => item.product.name,
                        "item_number_#{index+1}" => item.id,
                        "quantity_#{index+1}" => item.quantity
                    })
    end
    'https://www.sandbox.paypal.com/cgi-bin/webscr?' + values.to_query
  end

  def paypal_encrypted(return_url, notify_url)
    values = {
        :business => APP_CONFIG[:paypal_email],
        :cmd => '_cart',
        :upload => 1,
        :return => return_url,
        :invoice => id,
        :notify_url => notify_url,
        :cert_id => APP_CONFIG[:paypal_cert_id],
        :shipping => total_shipping
    }
    line_items.each_with_index do |item, index|
      values.merge!({
                        "amount_#{index+1}" => item.unit_price,
                        "item_name_#{index+1}" => item.product.name,
                        "item_number_#{index+1}" => item.id,
                        "quantity_#{index+1}" => item.quantity
                    })
    end
    encrypt_for_paypal(values)
  end

  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end

end