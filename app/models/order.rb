class Order < ActiveRecord::Base
attr_accessor :gold, :will_iden
  belongs_to :will

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "contact@notaryexpress.co.uk",
        #business: "accounts@cd2solutions.co.uk",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: self.price,
        item_name: "full_name_#{id}",
        item_number: 82736489237,
        :currency_code => 'GBP',
        quantity: '1',
        notify_url: "https://expresswills.herokuapp.com/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end
