class ExecutorsController < ApplicationController
  before_action :set_executor, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 4
  end
  before_action :assign_ivars, only: [:first_executor, :second_executor, :third_executor, :forth_executor, :first_replacement_executor, :second_replacement_executor, :third_replacement_executor, :forth_replacement_executor]


  def new
    @will = Will.find(params[:will_id])
    @executor = Executor.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.executor
      @executor = @will.executor
      @executor.update(executor_params)
    else
      @executor = Executor.new(executor_params)
      @executor.will_id = params[:will_id]
    end
    if @executor.save
      process_exec_update
    else
      process_exec_fail
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @executor.update(executor_params)
      process_exec_update
    else
      process_exec_fail
    end
  end

  def first_executor
    redirect_to will_executor_second_executor_path(@will, @executor) unless @executor.first
    @first = @will.first_executor || @executor.build_first_executor_general_detail
  end

  def second_executor
    redirect_to will_executor_third_executor_path(@will, @executor) unless @executor.second
    @second = @will.second_executor || @executor.build_second_executor_general_detail
  end

  def third_executor
    redirect_to will_executor_forth_executor_path(@will, @executor) unless @executor.third
    @third = @will.third_executor || @executor.build_third_executor_general_detail
  end

  def forth_executor
    redirect_to will_executor_first_replacement_executor_path(@will, @executor) unless @executor.forth
    @forth = @will.forth_executor || @executor.build_forth_executor_general_detail
  end

  def first_replacement_executor
    @first_rep = @will.first_replacement_executor || @executor.build_first_replacement_executor_general_detail
  end

  def second_replacement_executor
    redirect_to will_executor_third_replacement_executor_path(@will, @executor) unless @executor.replacement_second
    @second_rep = @will.second_replacement_executor || @executor.build_second_replacement_executor_general_detail
  end

  def third_replacement_executor
    redirect_to will_executor_forth_replacement_executor_path(@will, @executor) unless @executor.replacement_third
    @third_rep = @will.third_replacement_executor || @executor.build_third_replacement_executor_general_detail
  end

  def forth_replacement_executor
    proceed unless @executor.replacement_forth
    @forth_rep = @will.forth_replacement_executor || @executor.build_forth_replacement_executor_general_detail
  end


  private
  
    def set_executor
      @executor = Executor.find(params[:id])
    end

    def process_exec_update
      case params[:executor][:exec]
      when "new"
        redirect_to will_executor_first_executor_path(@will, @executor) 
      when "edit"
        if @executor.notary_express == false && @executor.first == false 
          @executor.update_attributes(first: false, second: false, third: false, forth: false, replacement_first: false, replacement_second: false, replacement_third: false, replacement_forth: false)
          proceed
        elsif @executor.notary_express == true && @executor.second == false
          @executor.update_attributes(first: false, second: false, third: false, forth: false, replacement_first: false, replacement_second: false, replacement_third: false, replacement_forth: false)
          proceed
        else
          redirect_to will_executor_first_executor_path(@will, @executor) 
        end
      when "first"
        redirect_to will_executor_second_executor_path(@will, @executor) 
      when "second"
        redirect_to will_executor_third_executor_path(@will, @executor) 
      when "third"
        redirect_to will_executor_forth_executor_path(@will, @executor) 
      when "forth"
        if @executor.notary_express
          proceed
        else
          redirect_to will_executor_first_replacement_executor_path(@will, @executor) 
        end
      when "first_rep"
        redirect_to will_executor_second_replacement_executor_path(@will, @executor) 
      when "second_rep"
        redirect_to will_executor_third_replacement_executor_path(@will, @executor) 
      when "third_rep"
        redirect_to will_executor_forth_replacement_executor_path(@will, @executor) 
      when "forth_rep"
        proceed
      end

    end

    def process_exec_fail
      case params[:executor][:exec]
      when "new"
        render :new
      when "edit"
        render :edit
      when "first"
        render :first_executor
      when "second"
        render :second_executor
      when "third"
        render :third_executor
      when "forth"
        render :forth_executor
      when "first_rep"
        render :first_replacement_executor
      when "second_rep"
        render :second_replacement_executor
      when "third_rep"
        render :third_replacement_executor
      when "forth_rep"
        render :forth_replacement_executor
      end
    end

    def proceed
      if @executor.notary_express
        redirect_to new_will_guardian_path
      else
        redirect_to new_will_administration_path
      end
    end

    def assign_ivars
      @will = Will.find(params[:will_id])
      @executor = Executor.find(params[:executor_id])
    end

    def executor_params
      params.require(:executor).permit(:notary_express, :exec, :first, :second, :third, :forth, :replacement_first, :replacement_second, :replacement_third, :replacement_forth, 
        forth_replacement_executor_general_detail_attributes: [:id, :exec, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        third_replacement_executor_general_detail_attributes: [:id, :exec, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        second_replacement_executor_general_detail_attributes: [:id, :exec, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        first_replacement_executor_general_detail_attributes: [:id, :exec, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        forth_executor_general_detail_attributes: [:id, :exec, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        third_executor_general_detail_attributes: [:id, :exec, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        second_executor_general_detail_attributes: [:id, :exec, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        first_executor_general_detail_attributes: [:id, :exec, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country])
    end
end
