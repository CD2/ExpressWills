class PersonalGiftsController < ApplicationController
  before_action :set_personal_gift, only: [:show, :edit, :update, :destroy]
  before_action :skip_option, only: [:option]
  after_action only: :option do
    update_will_progress 11
  end

  def new
    @will = Will.find(params[:will_id])
    @personal_gift = PersonalGift.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def index
    @will = Will.find(params[:will_id])
    @personal_gifts = @will.personal_gifts
  end

  def create
    @will = Will.find(params[:will_id])
    @personal_gift = PersonalGift.new(personal_gift_params)
    @personal_gift.will_id = params[:will_id]
    if @personal_gift.save
      redirect_to will_personal_gifts_path(@will)
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @personal_gift.save
      redirect_to will_personal_gifts_path(@will)
    else
      render :edit
    end
  end

  def option
  end

  def destroy
    @will = Will.find(params[:will_id])
    @personal_gift.destroy
    redirect_to will_personal_gifts_path(@will)
  end

  private
  
    def skip_option
      @will = Will.find(params[:will_id])
      @personal_gifts = @will.personal_gifts
      redirect_to will_personal_gifts_path(@will) if @personal_gifts.any?
    end

    def set_personal_gift
      @personal_gift = PersonalGift.find(params[:id])
    end

    def personal_gift_params
      params.require(:personal_gift).permit(:count, :description, :as_cash_if_sold, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country)
    end
end
