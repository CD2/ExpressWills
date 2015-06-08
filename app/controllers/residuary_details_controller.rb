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
    redirect_to option_will_residuary_details_path(@will) unless @will.residuary_details.any?
    @residuary_details = @will.residuary_details.where(complete:true)
  end

  def create
    @will = Will.find(params[:will_id])
    if params[:commit] == "I do not wish to specify a beneficiary" || params[:commit] == "I do not wish to specify a secondary beneficiary" || params[:commit] == "I do not wish to specify another secondary beneficiary"
      redirect_to new_will_request_path
    elsif params[:commit] == "I do not wish to specify another beneficiary"
      redirect_to new_will_residuary_path
    else
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
  end


  def destroy
    @residuary_detail = ResiduaryDetail.find(params[:id])
    @will = Will.find(params[:will_id])
    @residuary_detail.destroy

    @residuary_details = @will.residuary_details.where(complete:true)

    unless @residuary_details.where(secondary: false).any?
      @res = @will.residuary_details.all
      @res.destroy_all
    end
    redirect_to will_residuary_details_path(@will)
    flash[:notice] = "Deleted"
  end

  def update
    @will = Will.find(params[:will_id])

    if params[:commit] == "I do not wish to specify a beneficiary" || params[:commit] == "I do not wish to specify a secondary beneficiary" || params[:commit] == "I do not wish to specify another secondary beneficiary"
      redirect_to new_will_request_path
    elsif params[:commit] == "I do not wish to specify another beneficiary"
      redirect_to new_will_residuary_path
    else
    
      if @residuary_detail.update(residuary_detail_params)
        if params[:residuary_detail][:charity_residuary_general_detail_attributes] && params[:residuary_detail][:charity_residuary_general_detail_attributes][:popular_charity] && @residuary_detail.charity_residuary_general_detail.try(:popular_charity)
          @residuary_detail.charity_residuary_general_detail.update_attributes(name: @residuary_detail.popular_charity_name)
        end
        if params[:commit] == "Proceed"
          redirect_to will_residuary_details_path(@will)
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
      params.require(:residuary_detail).permit(:secondary, :popular_charity, :popular_charity_name, :complete, :count, :share, :certain_age, :if_dead, :if_dead_certain_age, :residuary_type,
        individual_residuary_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country], 
        charity_residuary_general_detail_attributes: [:popular_charity, :id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country, :name, :registered_charity_number])
    end
end
