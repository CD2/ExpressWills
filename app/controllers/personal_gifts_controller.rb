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
    if @will.personal_gifts.last && @personal_gift = @will.personal_gifts.find_by(count: params[:personal_gift][:count])
      @personal_gift.update(personal_gift_params)
    else
      @personal_gift = PersonalGift.new(personal_gift_params)
      @personal_gift.will_id = params[:will_id]
    end
    if @personal_gift.save
      if params[:commit] == "Add Another"
        redirect_to new_will_personal_gift_path
      elsif params[:commit] == "Proceed"
        @will = Will.find(params[:will_id])
        redirect_to option_will_residuary_details_path
      end
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @personal_gift.update(personal_gift_params)
      if params[:commit] == "Add Another"
        redirect_to new_will_personal_gift_path
      elsif params[:commit] == "Proceed"
        @will = Will.find(params[:will_id])
        redirect_to option_will_residuary_details_path
      end
    else
      render :edit
    end
  end

  def option
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
