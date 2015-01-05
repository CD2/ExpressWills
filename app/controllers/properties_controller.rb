class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :skip_option, only: [:option]
  after_action only: :option do
    update_will_progress 10
  end

  def new
    @will = Will.find(params[:will_id])
    @property = Property.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def index
    @will = Will.find(params[:will_id])
    @properties = @will.properties
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.properties.last && @property = @will.properties.find_by(count: params[:property][:count])
      @property.update(property_params)
    else
      @property = Property.new(property_params)
      @property.will_id = params[:will_id]
    end
    if @property.save
      redirect_to will_property_benificiaries_path(@will, @property)
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @property.update(property_params)
      if params[:commit] == "Add Another"
        redirect_to new_will_property_path
      elsif params[:commit] == "Proceed"
        @will = Will.find(params[:will_id])
        redirect_to option_will_personal_gifts_path(@will)
      else
        redirect_to will_property_benificiaries_path(@will, @property)
      end
    else
      if params[:action] == "edit"
        render :edit
      else
        render :benificiaries
      end
    end
  end

  def option
    @will = Will.find(params[:will_id])
  end

  def benificiaries
    @will = Will.find(params[:will_id])
    @property = Property.find(params[:property_id])
    @b1 = @property.benificiary_general_details || @property.build_benificiary_general_details
    @b2 = @property.second_benificiary_general_details || @property.build_second_benificiary_general_details if @property.recipient_no > 1
    @b3 = @property.third_benificiary_general_details || @property.build_third_benificiary_general_details if @property.recipient_no > 2
    @b4 = @property.forth_benificiary_general_details || @property.build_forth_benificiary_general_details if @property.recipient_no > 3
    @b5 = @property.replacement_benificiary_general_details || @property.build_replacement_benificiary_general_details
    @b6 = @property.second_replacement_benificiary_general_details || @property.build_second_replacement_benificiary_general_details if @property.life_beneficiary_no > 1
    @b7 = @property.third_replacement_benificiary_general_details || @property.build_third_replacement_benificiary_general_details if @property.life_beneficiary_no > 2
    @b8 = @property.forth_replacement_benificiary_general_details || @property.build_forth_replacement_benificiary_general_details if @property.life_beneficiary_no > 3
  end

  def option
  end

  private
  
    def skip_option
      @will = Will.find(params[:will_id])
      @properties = @will.properties
      redirect_to will_properties_path(@will) if @properties.any?
    end
    
    def set_property
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:complete, :count, :sole_residence, :recipient_no, :joint_or_common, :responsible_for_charges, :as_cash_if_sold, :held_in_trust, :life_beneficiary_no, :will_id, :land_reg_number, :address_one, :address_two, :city, :county, :country, :postcode,
        benificiary_general_details_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        second_benificiary_general_details_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        third_benificiary_general_details_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        forth_benificiary_general_details_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        replacement_benificiary_general_details_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        second_replacement_benificiary_general_details_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        third_replacement_benificiary_general_details_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        forth_replacement_benificiary_general_details_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country])
    end
end
