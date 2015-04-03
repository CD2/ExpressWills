class Order < ActiveRecord::Base

  belongs_to :will

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "merchant@expresswill.co.uk",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: price,
        currency: 'GBP',
        item_name: full_name,
        item_number: '1',
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end
