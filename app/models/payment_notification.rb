class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :cart_id, :status, :transaction_id

  belongs_to :cart
  serialize :params
  after_create :mark_cart_as_purchased

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

private

  def mark_cart_as_purchased
    @payment_email = Parameter.find_by_key('payment-email')
    if ( status == "Completed" && params[:secret] == APP_CONFIG[:paypal_secret] )
      cart.update_attribute(:purchased_at, Time.now)
      exec("sendmail -f noreply@#{Rails.application.config.action_mailer.default_url_options[:host]} #{@payment_email} < \"Subject: Payment Received\n#{params_as_str(params)}\"")
    else
      exec("sendmail -f noreply@#{Rails.application.config.action_mailer.default_url_options[:host]} #{@payment_email} < \"Subject: Payment FAILED\n#{params_as_str(params)}\"")
    end

    #@payment_email = Parameter.find_by_key('payment-email')
    #if !@payment_email.nil?
    #  @body = params_as_str(params)
    #end
    #gross = cart.nil? ? 0 : cart.total_price.to_s
    #if ( status == "Completed" &&
    #    params[:secret] == APP_CONFIG[:paypal_secret] &&
    #    params[:receiver_email] == APP_CONFIG[:paypal_email] &&
    #    params[:mc_gross] == gross &&
    #    params[:mc_currency] == "USD" )
    #  cart.update_attribute(:purchased_at, Time.now)
    #  ActionMailer::Base.mail(
    #      :from => "noreply@#{Rails.application.config.action_mailer.default_url_options[:host]}",
    #      :to => @payment_email.to_s,
    #      :subject => "Payment Received - #{Time.new.strftime('%Y/%m/%d')}",
    #      :body => @body.to_s
    #  ).deliver
    #else
    #  ActionMailer::Base.mail(
    #      :from => "noreply@#{Rails.application.config.action_mailer.default_url_options[:host]}",
    #      :to => @payment_email.to_s,
    #      :subject => "Payment FAILED - #{Time.new.strftime('%Y/%m/%d')}",
    #      :body => "#{@body}\n"+
    #          "EXPECTED:\n"+
    #          "\"Completed\" == status #{status}\n"+
    #          "APP_CONFIG[:paypal_secret] (#{APP_CONFIG[:paypal_secret]}) == params[:secret] (#{params[:secret]})\n"+
    #          "APP_CONFIG[:paypal_email] (#{APP_CONFIG[:paypal_email]}) == params[:receiver_email] (#{params[:receiver_email]})\n"+
    #          "cart.total_price.to_s (#{gross}) == params[:mc_gross] (#{params[:mc_gross]})\n"+
    #          "\"USD\" == params[:mc_currency] (#{params[:mc_currency]})\n"
    #  ).deliver
    #end
  end

end