class UserMailer < ActionMailer::Base
  default from: "web@expresswills.com"
  def account_activation user
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: "Password Reset"
  end
end
