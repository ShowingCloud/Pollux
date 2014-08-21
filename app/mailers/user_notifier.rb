class UserNotifier < ActionMailer::Base
  default from: "contact@antshares.org"

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
          :subject => 'Thanks for signing up Antshares' )
  end

  def send_notification(user)
    @user = user
    mail( :to => @user.email,
          :subject => 'Someone donated' )
  end

end
