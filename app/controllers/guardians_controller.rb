class GuardiansController < ApplicationController
  before_action :set_guardian, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 6
  end

  def new
    @will = Will.find(params[:will_id])
    @guardian = Guardian.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.guardian
      @guardian = @will.guardian
      @guardian.update(guardian_params)
    else
      @guardian = Guardian.new(guardian_params)
      @guardian.will_id = params[:will_id]
    end
    if @guardian.save
      if @guardian.appoint_future_guardians || @guardian.appoint_current_guardians
        redirect_to will_guardian_first_guardian_path(@will, @guardian)
      else
        redirect_to option_will_cash_gifts_path(@will)
      end
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @guardian.update(guardian_params)
      if params[:commit] == "Update"
        if @guardian.appoint_future_guardians || @guardian.appoint_current_guardians
          redirect_to will_guardian_first_guardian_path(@will, @guardian)
        else
          redirect_to option_will_cash_gifts_path(@will)
        end
      elsif @guardian.replacement_forth_guardian && params[:guardian][:third_replacement_guardian_general_detail_attributes]
        redirect_to will_guardian_forth_replacement_guardian_path(@will, @guardian)
      elsif @guardian.replacement_third_guardian && params[:guardian][:second_replacement_guardian_general_detail_attributes]
        redirect_to will_guardian_third_replacement_guardian_path(@will, @guardian)
      elsif @guardian.replacement_second_guardian && params[:guardian][:first_replacement_guardian_general_detail_attributes]
        redirect_to will_guardian_second_replacement_guardian_path(@will, @guardian)
      elsif params[:guardian][:forth_replacement_guardian_general_detail_attributes] ||
            params[:guardian][:third_replacement_guardian_general_detail_attributes] ||
            params[:guardian][:second_replacement_guardian_general_detail_attributes] ||
            params[:guardian][:first_replacement_guardian_general_detail_attributes] ||
            params[:guardian][:replacement_guardian]
          redirect_to option_will_cash_gifts_path(@will)
      elsif @guardian.forth_guardian && params[:guardian][:third_guardian_general_detail_attributes]
        redirect_to will_guardian_forth_guardian_path(@will, @guardian)
      elsif @guardian.third_guardian && params[:guardian][:second_guardian_general_detail_attributes]
        redirect_to will_guardian_third_guardian_path(@will, @guardian)
      elsif @guardian.second_guardian && params[:guardian][:first_guardian_general_detail_attributes]
        redirect_to will_guardian_second_guardian_path(@will, @guardian)
      else
        redirect_to will_guardian_first_replacement_guardian_path(@will, @guardian)
      end
    else
      if params[:guardian][:forth_replacement_guardian_general_detail_attributes]
        render :forth_replacement_guardian
      elsif params[:guardian][:third_replacement_guardian_general_detail_attributes]
        render :third_replacement_guardian
      elsif params[:guardian][:second_replacement_guardian_general_detail_attributes]
        render :second_replacement_guardian
      elsif params[:guardian][:first_replacement_guardian_general_detail_attributes]
        render :first_replacement_guardian
      elsif params[:guardian][:forth_guardian_general_detail_attributes]
        render :forth_guardian
      elsif params[:guardian][:third_guardian_general_detail_attributes]
        render :third_guardian
      elsif params[:guardian][:second_guardian_general_detail_attributes]
        render :second_guardian
      elsif params[:guardian][:first_guardian_general_detail_attributes]
        render :first_guardian
      else
        render :edit
      end
    end
  end

  def first_guardian
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:guardian_id])
    @guard = @will.first_guardian  || @guardian.build_first_guardian_general_detail
  end
  def second_guardian
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:guardian_id])
    @guard = @will.second_guardian  || @guardian.build_second_guardian_general_detail
  end
  def third_guardian
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:guardian_id])
    @guard = @will.third_guardian  || @guardian.build_third_guardian_general_detail
  end
  def forth_guardian
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:guardian_id])
    @guard = @will.forth_guardian  || @guardian.build_forth_guardian_general_detail
  end
  def first_replacement_guardian
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:guardian_id])
    @guard = @will.first_replacement_guardian  || @guardian.build_first_replacement_guardian_general_detail
  end
  def second_replacement_guardian
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:guardian_id])
    @guard = @will.second_replacement_guardian  || @guardian.build_second_replacement_guardian_general_detail
  end
  def third_replacement_guardian
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:guardian_id])
    @guard = @will.third_replacement_guardian  || @guardian.build_third_replacement_guardian_general_detail
  end
  def forth_replacement_guardian
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:guardian_id])
    @guard = @will.forth_replacement_guardian  || @guardian.build_forth_replacement_guardian_general_detail
    @origin
  end

  private
    def set_guardian
      @guardian = Guardian.find(params[:id])
    end

    def guardian_params
      params.require(:guardian).permit(:appoint_future_guardians, :appoint_current_guardians, :second_guardian, :third_guardian, :forth_guardian, :replacement_guardian, :replacement_second_guardian, :replacement_third_guardian, :replacement_forth_guardian, 
        forth_replacement_guardian_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        third_replacement_guardian_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        second_replacement_guardian_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        first_replacement_guardian_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        forth_guardian_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        third_guardian_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        second_guardian_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        first_guardian_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country])
    end
end
