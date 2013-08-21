class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    PaymentNotification.create!( :params => params, :cart_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id] )
    @email = Parameter.find_by_key('payment-email')
    if !@email.nil?
      mail( :to => @email, :subject => 'Welcome to My Awesome Site' )
      ActionMailer::Base.mail(
          :from => "noreply@#{Rails.application.config.action_mailer.default_url_options.host}",
          :to => @email,
          :subject => "Payment Received - #{Time.new.strftime('%Y/%m/%d')}",
          :body => eval(params).map { |k, v| "#{k} = #{v}" }.join("\n")
      ).deliver
    end
    render :nothing => true
  end

end