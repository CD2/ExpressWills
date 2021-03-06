class WillPurchased < ActionMailer::Base
  default from: "web@expresswills.com"


  def purchaser_notify(will)
    @will = will
    attachments["WILLSigningInstructions.pdf"] = File.read("#{Rails.root}/public/WILLSigningInstructions.pdf")
    unless @will.order.full_name == "Gold Service Will"
      attachments["WILL.pdf"] = File.read("#{Rails.root}/tmp/will_#{@will.id}.pdf")
      if @will.mirror_will == "yes"
        attachments["MIRROR_WILL.pdf"] = File.read("#{Rails.root}/tmp/mirror_will_#{@will.id}.pdf")
      end
    end
    mail(to: @will.user.email, subject: "Thank you for your purchase")
    #mail(to: "shane@cd2solutions.co.uk", subject: "Thank you for your purchase")
  end

  def merlin_notify(will)
    @will = will
    mail(to: 'contact@notaryexpress.co.uk', subject: "Will Purchased")
    #mail(to: 'shane@cd2solutions.co.uk', subject: "Will Purchased")
  end

  def resend_will(will)
    @will = will
    attachments["WILL.pdf"] = File.read("#{Rails.root}/tmp/will_#{@will.id}.pdf")
    if @will.mirror_will == "yes"
      attachments["MIRROR_WILL.pdf"] = File.read("#{Rails.root}/tmp/mirror_will_#{@will.id}.pdf")
    end
    attachments["WILLSigningInstructions.pdf"] = File.read("#{Rails.root}/public/WILLSigningInstructions.pdf")
    mail(to: @will.user.email, subject: "Your reviewed will")
    #mail(to: "shane@cd2solutions.co.uk", subject: "Your reviewed will")
  end

end
