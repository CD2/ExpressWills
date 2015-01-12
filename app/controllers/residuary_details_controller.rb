class ResiduaryDetailsController < ApplicationController
  before_action :set_residuary_detail, only: [:show, :edit, :update, :destroy]
  before_action :skip_option, only: [:option]
  before_action only: :new do
    update_will_progress 12
  end

  def new
    @will = Will.find(params[:will_id])
    @residuary_detail = ResiduaryDetail.new
  end

  def secondary
    @will = Will.find(params[:will_id])
    @residuary_detail = ResiduaryDetail.new
  end

  def edit
    @will = Will.find(params[:will_id])
    @resgen = @residuary_detail.individual_residuary_general_detail || @residuary_detail.build_individual_residuary_general_detail
    @resgens = @residuary_detail.charity_residuary_general_detail || @residuary_detail.build_charity_residuary_general_detail
  end

  def index
    @will = Will.find(params[:will_id])
    @residuary_details = @will.residuary_details.where(complete:true)
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.residuary_details.last && @residuary_detail = @will.residuary_details.find_by(count: params[:residuary_detail][:count])
      @residuary_detail.update(residuary_detail_params)
    else
      @residuary_detail = ResiduaryDetail.new(residuary_detail_params)
      @residuary_detail.will_id = params[:will_id]
    end
    if @residuary_detail.save
      if @residuary_detail.residuary_type == "I do not wish to specify a beneficiary"
        redirect_to new_will_request_path
      elsif @residuary_detail.residuary_type == "Charity"
        redirect_to will_residuary_detail_charity_benificiary_path(@will, @residuary_detail)
      else
        redirect_to will_residuary_detail_people_benificiary_path(@will, @residuary_detail)
      end
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @residuary_detail.update(residuary_detail_params)
      if params[:commit] == "Submit"
        redirect_to will_residuary_details_path(@will)
      elsif params[:commit] == "Add Another"
        if @residuary_detail.secondary
          redirect_to secondary_will_residuary_details_path
        else
          redirect_to new_will_residuary_detail_path
        end
      elsif params[:commit] == "Proceed"
        if @residuary_detail.secondary
          redirect_to new_will_request_path
        else
          redirect_to new_will_residuary_path
        end
      elsif @residuary_detail.residuary_type == "I do not wish to specify a beneficiary"
        redirect_to new_will_request_path
      elsif @residuary_detail.residuary_type == "Charity"
        redirect_to will_residuary_detail_charity_benificiary_path(@will, @residuary_detail)
      else
        redirect_to will_residuary_detail_people_benificiary_path(@will, @residuary_detail)
      end
    else
      if @residuary_detail.residuary_type == "Individual" || @residuary_detail.residuary_type == "My children"||@residuary_detail.residuary_type == "My grandchildren"
        render :people_benificiary
      elsif @residuary_detail.residuary_type == "Charity"
        render :charity_benificiary
      else
        render :edit
      end
    end
  end

  def people_benificiary
    @will = Will.find(params[:will_id])
    @residuary_detail = ResiduaryDetail.find(params[:residuary_detail_id])
    @resgen = @residuary_detail.individual_residuary_general_detail || @residuary_detail.build_individual_residuary_general_detail
  end

  def charity_benificiary
    @will = Will.find(params[:will_id])
    @residuary_detail = ResiduaryDetail.find(params[:residuary_detail_id])
    @resgen = @residuary_detail.charity_residuary_general_detail || @residuary_detail.build_charity_residuary_general_detail
  end

  def option
  end

  private
  
    def skip_option
      @will = Will.find(params[:will_id])
      @residuary_details = @will.residuary_details
      if @residuary_details.any?
        redirect_to will_residuary_details_path(@will)
      else
        redirect_to new_will_residuary_detail_path(@will)
      end
    end

    def set_residuary_detail
      @residuary_detail = ResiduaryDetail.find(params[:id])
    end

    def residuary_detail_params
      params.require(:residuary_detail).permit(:secondary, :complete, :count, :share, :certain_age, :if_dead, :if_dead_certain_age, :residuary_type,
        individual_residuary_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country], 
        charity_residuary_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country, :name, :registered_charity_number])
    end
end
