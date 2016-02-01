class Admin::WillsController < ApplicationController

  def index 
    @wills = Will.all
    #@wills = wills.includes(:order).where("order.status" => "asd")
  end

end