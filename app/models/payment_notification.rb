class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :cart_id, :status, :transaction_id

  belongs_to :cart
  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased
    @payment_email = Parameter.find_by_key('payment-email')
    if !@payment_email.nil?
      @body = params_as_str(params)
    end
    if  status == "Completed" &&
        params[:secret] == APP_CONFIG[:paypal_secret] &&
        params[:receiver_email] == APP_CONFIG[:paypal_email] &&
        params[:mc_gross] == cart.total_price.to_s &&
        params[:mc_currency] == "USD"
      cart.update_attribute(:purchased_at, Time.now)
      ActionMailer::Base.mail(
          :from => "noreply@#{Rails.application.config.action_mailer.default_url_options.host}",
          :to => @payment_email,
          :subject => "Payment Received - #{Time.new.strftime('%Y/%m/%d')}",
          :body => @body
      ).deliver
    else
      @payment_email = Parameter.find_by_key('payment-email')
      ActionMailer::Base.mail(
          :from => "noreply@#{Rails.application.config.action_mailer.default_url_options.host}",
          :to => @payment_email,
          :subject => "Payment FAILED - #{Time.new.strftime('%Y/%m/%d')}",
          :body => "#{@body}\n"+
              "EXPECTED:\n"+
              "\"Completed\" == status #{status}\n"+
              "APP_CONFIG[:paypal_secret] (#{APP_CONFIG[:paypal_secret]}) == params[:secret] (#{params[:secret]})\n"+
              "APP_CONFIG[:paypal_email] (#{APP_CONFIG[:paypal_email]}) == params[:receiver_email] (#{params[:receiver_email]})\n"+
              "cart.total_price.to_s (#{cart.total_price.to_s}) == params[:mc_gross] (#{params[:mc_gross]})\n"+
              "\"USD\" == params[:mc_currency] (#{params[:mc_currency]})\n"
      ).deliver
    end
  end

  def params_as_str(parameters)
    begin
      parameters.map{ |k, v| "#{k} = #{v}" }.join("\n")
    rescue
      begin
        eval(parameters).map{ |k, v| "#{k} = #{v}" }.join("\n")
      rescue
        ''
      end
    end
  end

end