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
        return ''
      end
    end
  end

private

  def mark_cart_as_purchased
    #if status == "Completed"
    #  cart.update_attribute(:purchased_at, Time.now)
    #end

    if ( params[:payment_status] == "Completed" && params[:secret] == APP_CONFIG[:paypal_secret] )
      cart.update_attribute(:purchased_at, Time.now)
      @payment_email = Parameter.find_by_key('payment-email')
      begin
        body = "echo 'Subject: Payment Received - Invoice: #{cart.id}';"
        body += "echo 'Address';"
        body += "echo '  #{params[:address_name]}';"
        body += "echo '  #{params[:address_street]}';"
        body += "echo '  #{params[:address_city]} #{params[:address_state]}, #{params[:address_zip]}';"
        body += "echo 'Order:';"
        (1..params[:num_cart_items].to_f).each do |i|
          body += "echo '  #{params["quantity#{i}"]} x #{params["item_name#{i}"]}';"
        end
        exec("(#{body}) | sendmail -f noreply@#{Rails.application.config.action_mailer.default_url_options[:host]} #{@payment_email.value}")
        return 0
      rescue
        return 0
      end
    else
      @failure_email = Parameter.find_by_key('failure-email')
      begin
        exec("(echo \"Subject: Payment FAILED\";echo \"#{params}\") | sendmail -f noreply@#{Rails.application.config.action_mailer.default_url_options[:host]} #{@failure_email.value}")
        return 0
      rescue
        return 0
      end
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