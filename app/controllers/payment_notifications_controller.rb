class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    begin
      PaymentNotification.create!( :params => params, :cart_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id] )
      exec("(echo \"Subject: Created Payment\";echo \"#{params}\") | sendmail -f noreply@#{Rails.application.config.action_mailer.default_url_options[:host]} nik.cimino@gmail.com")
    rescue Exception => exc
      exec("(echo \"Subject: FAILED Create Payment\";echo\"#{exc.message}\";echo \"#{params}\") | sendmail -f noreply@#{Rails.application.config.action_mailer.default_url_options[:host]} nik.cimino@gmail.com")
    end
    render :nothing => true
  end

end