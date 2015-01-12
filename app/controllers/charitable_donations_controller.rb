class CharitableDonationsController < ApplicationController
  before_action :set_charitable_donation, only: [:show, :edit, :update, :destroy]
  before_action :skip_option, only: [:option]
  after_action only: :option do
    update_will_progress 8
  end

  def new
    @will = Will.find(params[:will_id])
    @charitable_donation = CharitableDonation.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def index
    @will = Will.find(params[:will_id])
    @charitable_donations = @will.charitable_donations
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.charitable_donations.last && @charitable_donation = @will.charitable_donations.find_by(count: params[:charitable_donation][:count])
      @charitable_donation.update(charitable_donation_params)
    else
      @charitable_donation = CharitableDonation.new(charitable_donation_params)
      @charitable_donation.will_id = params[:will_id]
    end
    if @charitable_donation.save
      if params[:commit] == "Add Another"
        redirect_to new_will_charitable_donation_path
      elsif params[:commit] == "Proceed"
        @will = Will.find(params[:will_id])
        redirect_to new_will_charity_permission_path
      end
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @charitable_donation.update(charitable_donation_params)
      redirect_to new_will_charity_permission_path
    else
      render :edit
    end
  end

  def option
    @will = Will.find(params[:will_id])
  end

  def option
  end

  private
  
    def skip_option
      @will = Will.find(params[:will_id])
      @charitable_donations = @will.charitable_donations
      redirect_to will_charitable_donations_path(@will) if @charitable_donations.any?
    end

    def set_charitable_donation
      @charitable_donation = CharitableDonation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def charitable_donation_params
      params.require(:charitable_donation).permit(:count, :charity_id, :amount, :instruction, :allow_alternate, :popular_charity, :popular_charity_name, :name, :registered_charity_number, :address_one, :address_two, :city, :postcode, :county, :country)
    end
end
