class WillPurchased < ActionMailer::Base
  default from: "web@expresswills.com"


  def purchaser_notify(will)
    @will = will
    attachments["WILLSigningInstructions.pdf"] = File.read("#{Rails.root}/public/WILLSigningInstructions.pdf")
    attachments["WILL.pdf"] = File.read("#{Rails.root}/tmp/will_#{@will.id}.pdf")
    mail(to: @will.user.email, subject: "Thank you for your purchase")
  end

  def merlin_notify(will)
    @will = will
    mail(to: 'contact@expresswills.com', subject: "Will Purchased")
  end


end
