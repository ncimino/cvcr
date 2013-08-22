class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    exec("(echo \"Subject: Creating Payment\";echo \"#{params}\") | sendmail -f noreply@#{Rails.application.config.action_mailer.default_url_options[:host]} nik.cimino@gmail.com")
    PaymentNotification.create!( :params => params, :cart_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id] )
    render :nothing => true
  end

end