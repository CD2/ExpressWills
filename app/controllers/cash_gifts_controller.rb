class CashGiftsController < ApplicationController
  before_action :set_cash_gift, only: [:show, :edit, :update, :destroy]
  before_action :skip_option, only: [:option]
  after_action only: :option do
    update_will_progress 7
  end

  def new
    @will = Will.find(params[:will_id])
    @cash_gift = CashGift.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def index
    @will = Will.find(params[:will_id])
    @cash_gifts = @will.cash_gifts
  end

  def create
    @will = Will.find(params[:will_id])
    @cash_gift = CashGift.new(cash_gift_params)
    @cash_gift.will_id = params[:will_id]
    if @cash_gift.save
      redirect_to will_cash_gifts_path(@will)
    else
      render :new
    end
  end

  def option
    @will = Will.find(params[:will_id])
  end

  def update
    @will = Will.find(params[:will_id])
    if @cash_gift.update(cash_gift_params)
      redirect_to will_cash_gifts_path(@will)
    else
      render :edit
    end
  end

  def option
  end

  def destroy
    @cash_gift = CashGift.find(params[:id])
    @will = Will.find(params[:will_id])
    @cash_gift.destroy
    redirect_to will_cash_gifts_path(@will)
    flash[:notice] = "Deleted"
  end

  private
  
    def skip_option
      @will = Will.find(params[:will_id])
      @cash_gifts = @will.cash_gifts
      redirect_to will_cash_gifts_path(@will) if @cash_gifts.any?
    end

    def set_cash_gift
      @cash_gift = CashGift.find(params[:id])
    end

    def cash_gift_params
      params.require(:cash_gift).permit(:count, :shared_to, :amount, :certain_age, :if_dead, :certain_age_if_dead, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country)
    end
end
