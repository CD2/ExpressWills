class Admin::WillsController < ApplicationController

  def index 
    @wills = Will.all
    #@wills = wills.includes(:order).where("order.status" => "asd")
  end

  def review
    @will = Will.find(params[:will_id])
  end

  def update
    @will = Will.find(params[:id])
    if @will.update(will_params)
      redirect_to admin_wills_path
    else
      render :review
    end
  end

  private

    def will_params
      params.require(:will).permit(:final_will)
    end

end