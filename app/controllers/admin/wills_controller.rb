class Admin::WillsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user

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

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

  def admin_user
    unless current_user.admin?
      store_location
      redirect_to signin_url, notice: "Please sign in as admin."
    end
  end

end