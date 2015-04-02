class Order < ActiveRecord::Base

  def paypal_url(return_path)
    values = {
        business: "merchant@cd2s.co.uk",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: '100',
        item_name: "this",
        item_number: '1',
        quantity: '1',
        otify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end
