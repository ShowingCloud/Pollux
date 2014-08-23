class UserNotifier < ActionMailer::Base
  default from: "contact@antshares.org"

  def send_signup_email(address)
    @address = address
    mail( :to => @address.email,
          :subject => 'Thanks for signing up Antshares' )
  end

  def send_notification(address)
    @address = address
    mail( :to => @address.email,
          :subject => 'Someone donated' )
  end

end
