class UserMailer < ActionMailer::Base
  default :from => "fruitful@fruitfulminds.org"

  # ActionMailer config settings are set in config/application.rb
  @@admin_email = "fruitful@fruitfulminds.org"

  def user_approved_email(user)
    @user = user
    @url  = "http://fruitfulminds.herokuapp.com/login"
    mail(:to => user.email, :subject => "Welcome to fruitfulminds.com")
  end

  def user_disapproved_email(user)
    @user = user
    mail(:to => user.email, :subject => "Registration Status for Fruitfulminds.com")
  end

  def notify_admin(registered_user)
    @user = registered_user
    mail(:to => @@admin_email, :subject => "New User Registered")
  end
end
