class Admin::WillsController < ApplicationController

  def index 
    @wills = Will.all
    #@wills = wills.includes(:order).where("order.status" => "asd")
  end

  def review
    @will = Will.find(params[:will_id])
  end

end