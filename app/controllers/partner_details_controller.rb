class PartnerDetailsController < ApplicationController
  before_action :set_partner_detail, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 2
  end

  def new
    @will = Will.find(params[:will_id])
    @partner_detail = PartnerDetail.new
    @general_detail = @partner_detail.general_detail || @partner_detail.build_general_detail
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.partner_detail
      @partner_detail = @will.partner_detail
      @partner_detail.update(partner_detail_params)
    else
      @partner_detail = PartnerDetail.new(partner_detail_params)
      @partner_detail.will_id = @will.id
    end
    if @partner_detail.save
      redirect_to new_will_funeral_path
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @partner_detail.update(partner_detail_params)
      redirect_to new_will_funeral_path
    else
      render :edit
    end
  end

  private
    def set_partner_detail
      @partner_detail = PartnerDetail.find(params[:id])
    end

    def partner_detail_params
      params.require(:partner_detail).permit(:phone_no, :gender, :dob, :domicile_country, general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country])
    end
end
