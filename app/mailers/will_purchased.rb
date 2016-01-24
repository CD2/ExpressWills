class WillPurchased < ActionMailer::Base
  default from: "web@expresswills.com"


  def purchaser_notify(will)
    @will = will
    mail(to: @will.user.email, subject: "Thank you for your purchase")
  end

  def merlin_notify(will)
    @will = will
    mail(to: 'shane@cd2solutions.co.uk', subject: "Will Purchased")
  end


end