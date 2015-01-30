class GuardiansController < ApplicationController
  before_action :set_guardian, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 6
  end
  before_action :assign_ivars, only: [:first_guardian,:second_guardian,:third_guardian,:forth_guardian,:first_replacement_guardian,:second_replacement_guardian,:third_replacement_guardian,:forth_replacement_guardian]

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
      process_guardian_save
    else
      process_guardian_fail
    end
  end

  def update
    @will = Will.find(params[:will_id])
    @guardian = Guardian.find(params[:id])
    if @guardian.update(guardian_params)
      process_guardian_save
    else
      process_guardian_fail
    end
  end

  def first_guardian
    redirect_to will_guardian_second_guardian_path(@will, @guardian) unless @guardian.appoint_future_guardians || @guardian.appoint_current_guardians
    @guard = @will.first_guardian  || @guardian.build_first_guardian_general_detail
  end
  def second_guardian
    redirect_to will_guardian_third_guardian_path(@will, @guardian) unless @guardian.second_guardian
    @guard = @will.second_guardian  || @guardian.build_second_guardian_general_detail
  end
  def third_guardian
    redirect_to will_guardian_forth_guardian_path(@will, @guardian) unless @guardian.third_guardian
    @guard = @will.third_guardian  || @guardian.build_third_guardian_general_detail
  end
  def forth_guardian
    redirect_to will_guardian_first_replacement_guardian_path(@will, @guardian) unless @guardian.forth_guardian
    @guard = @will.forth_guardian  || @guardian.build_forth_guardian_general_detail
  end
  def first_replacement_guardian
    proceed unless @guardian.appoint_future_guardians || @guardian.appoint_current_guardians
    @guard = @will.first_replacement_guardian  || @guardian.build_first_replacement_guardian_general_detail
  end
  def second_replacement_guardian
    redirect_to will_guardian_third_replacement_guardian_path(@will, @guardian) unless @guardian.replacement_second_guardian
    @guard = @will.second_replacement_guardian  || @guardian.build_second_replacement_guardian_general_detail
  end
  def third_replacement_guardian
    redirect_to will_guardian_forth_replacement_guardian_path(@will, @guardian) unless @guardian.replacement_third_guardian
    @guard = @will.third_replacement_guardian  || @guardian.build_third_replacement_guardian_general_detail
  end
  def forth_replacement_guardian
    proceed unless @guardian.replacement_forth_guardian
    @guard = @will.forth_replacement_guardian  || @guardian.build_forth_replacement_guardian_general_detail
  end

  private
    def set_guardian
      @guardian = Guardian.find(params[:id])
    end

    def process_guardian_save
      case params[:guardian][:exec]
      when "new"
        redirect_to will_guardian_first_guardian_path(@will, @guardian)
      when "edit"
        if @will.testator_detail.children != "no" && @will.testator_detail.children_age
          if @guardian.appoint_current_guardians
            redirect_to will_guardian_first_guardian_path(@will, @guardian)
          else
            @first = GeneralDetail.find_by(first_guardian_id: @guardian.id)
            @second = GeneralDetail.find_by(second_guardian_id: @guardian.id)
            @third = GeneralDetail.find_by(third_guardian_id: @guardian.id)
            @forth = GeneralDetail.find_by(forth_guardian_id: @guardian.id)
            @firsta = GeneralDetail.find_by(first_replacement_guardian_id: @guardian.id)
            @seconda = GeneralDetail.find_by(second_replacement_guardian_id: @guardian.id)
            @thirda = GeneralDetail.find_by(third_replacement_guardian_id: @guardian.id)
            @fortha = GeneralDetail.find_by(forth_replacement_guardian_id: @guardian.id)

            @first.destroy if @first
            @second.destroy if @second
            @third.destroy if @third
            @forth.destroy if @forth
            @firsta.destroy if @firsta
            @seconda.destroy if @seconda
            @thirda.destroy if @thirda
            @fortha.destroy if @fortha
            
            proceed
          end
        else
          if @guardian.appoint_future_guardians
            redirect_to will_guardian_first_guardian_path(@will, @guardian)
          else
            @first = GeneralDetail.find_by(first_guardian_id: @guardian.id)
            @second = GeneralDetail.find_by(second_guardian_id: @guardian.id)
            @third = GeneralDetail.find_by(third_guardian_id: @guardian.id)
            @forth = GeneralDetail.find_by(forth_guardian_id: @guardian.id)
            @firsta = GeneralDetail.find_by(first_replacement_guardian_id: @guardian.id)
            @seconda = GeneralDetail.find_by(second_replacement_guardian_id: @guardian.id)
            @thirda = GeneralDetail.find_by(third_replacement_guardian_id: @guardian.id)
            @fortha = GeneralDetail.find_by(forth_replacement_guardian_id: @guardian.id)

            @first.destroy if @first
            @second.destroy if @second
            @third.destroy if @third
            @forth.destroy if @forth
            @firsta.destroy if @firsta
            @seconda.destroy if @seconda
            @thirda.destroy if @thirda
            @fortha.destroy if @fortha

            proceed
          end
        end
      when "first"
        redirect_to will_guardian_second_guardian_path(@will, @guardian)
      when "second"
        redirect_to will_guardian_third_guardian_path(@will, @guardian)
      when "third"
        redirect_to will_guardian_forth_guardian_path(@will, @guardian)
      when "forth"
        redirect_to will_guardian_first_replacement_guardian_path(@will, @guardian)
      when "first_rep"
        redirect_to will_guardian_second_replacement_guardian_path(@will, @guardian) 
      when "second_rep"
        redirect_to will_guardian_third_replacement_guardian_path(@will, @guardian)
      when "third_rep"
        redirect_to will_guardian_forth_replacement_guardian_path(@will, @guardian) 
      when "forth_rep"
        proceed
      end

    end

    def process_guardian_fail
      case params[:guardian][:exec]
      when "new"
        render :new
      when "edit"
        render :edit
      when "first"
        render :first_guardian
      when "second"
        render :second_guardian
      when "third"
        render :third_guardian
      when "forth"
        render :forth_guardian
      when "first_rep"
        render :first_replacement_guardian
      when "second_rep"
        render :second_replacement_guardian
      when "third_rep"
        render :third_replacement_guardian
      when "forth_rep"
        render :forth_replacement_guardian
      end
    end

    def proceed
      redirect_to option_will_cash_gifts_path(@will)
    end

    def assign_ivars
      @will = Will.find(params[:will_id])
      @guardian = Guardian.find(params[:guardian_id])
    end

    def guardian_params
      params.require(:guardian).permit(:exec, :appoint_future_guardians, :appoint_current_guardians, :second_guardian, :third_guardian, :forth_guardian, :replacement_guardian, :replacement_second_guardian, :replacement_third_guardian, :replacement_forth_guardian, 
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
