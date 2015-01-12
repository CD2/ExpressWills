class ExecutorsController < ApplicationController
  before_action :set_executor, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 4
  end

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
      if @executor.first
        unless @executor.notary_express
          redirect_to will_executor_first_executor_path(@will, @executor)
        else
          redirect_to will_executor_second_executor_path(@will, @executor)
             @executor.update_attributes(first: false)
        end
      elsif !@executor.first && !@executor.notary_express
        @executor.update_attributes(second: false)
        redirect_to will_executor_first_replacement_executor_path(@will, @executor)
      elsif @executor.second
        redirect_to will_executor_second_executor_path(@will, @executor)
      else
        redirect_to will_executor_first_replacement_executor_path(@will, @executor)
      end
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @executor.update(executor_params)
      if @executor.first 
        unless @executor.notary_express
          redirect_to will_executor_first_executor_path(@will, @executor)
        else
          redirect_to will_executor_second_executor_path(@will, @executor)
             @executor.update_attributes(first: false)
        end
      elsif params[:commit] == "Update" 
        if @executor.first
          unless @executor.notary_express
            redirect_to will_executor_first_executor_path(@will, @executor)
          else
            redirect_to will_executor_second_executor_path(@will, @executor)
          end
        elsif @executor.second
          redirect_to will_executor_second_executor_path(@will, @executor)
        else
          redirect_to will_executor_first_replacement_executor_path(@will, @executor)
        end
      elsif @executor.replacement_forth && params[:executor][:third_replacement_executor_general_detail_attributes]
        redirect_to will_executor_forth_replacement_executor_path(@will, @executor)
      elsif @executor.replacement_third && params[:executor][:second_replacement_executor_general_detail_attributes]
        redirect_to will_executor_third_replacement_executor_path(@will, @executor)
      elsif @executor.replacement_second && params[:executor][:first_replacement_executor_general_detail_attributes]
        redirect_to will_executor_second_replacement_executor_path(@will, @executor)
      elsif params[:executor][:first_replacement_executor_general_detail_attributes] || 
            params[:executor][:second_replacement_executor_general_detail_attributes] || 
            params[:executor][:third_replacement_executor_general_detail_attributes] || 
            params[:executor][:forth_replacement_executor_general_detail_attributes] ||
            params[:executor][:replacement_first]
        if @executor.notary_express
          redirect_to new_will_guardian_path
        else
          redirect_to new_will_administration_path
        end
      elsif @executor.forth && params[:executor][:third_executor_general_detail_attributes]
        redirect_to will_executor_forth_executor_path(@will, @executor)
      elsif @executor.third && params[:executor][:second_executor_general_detail_attributes]
        redirect_to will_executor_third_executor_path(@will, @executor)
      elsif @executor.second && params[:executor][:first_executor_general_detail_attributes]
        redirect_to will_executor_second_executor_path(@will, @executor)
      else
        redirect_to will_executor_first_replacement_executor_path(@will, @executor)
      end
    else
      if params[:executor][:forth_replacement_executor_general_detail_attributes]
        render :forth_replacement_executor
      elsif params[:executor][:third_replacement_executor_general_detail_attributes]
        render :third_replacement_executor
      elsif params[:executor][:second_replacement_executor_general_detail_attributes]
        render :second_replacement_executor
      elsif params[:executor][:first_replacement_executor_general_detail_attributes]
        render :first_replacement_executor
      elsif params[:executor][:forth_executor_general_detail_attributes]
        render :forth_executor
      elsif params[:executor][:third_executor_general_detail_attributes]
        render :third_executor
      elsif params[:executor][:second_executor_general_detail_attributes]
        render :second_executor
      elsif params[:executor][:first_executor_general_detail_attributes]
        render :first_executor
      else
        render :edit
      end
    end
  end

  def first_executor
    @will = Will.find(params[:will_id])
    @executor = Executor.find(params[:executor_id])
    @first = @will.first_executor || @executor.build_first_executor_general_detail
  end
  def second_executor
    @will = Will.find(params[:will_id])
    @executor = Executor.find(params[:executor_id])
    @second = @will.second_executor || @executor.build_second_executor_general_detail
  end
  def third_executor
    @will = Will.find(params[:will_id])
    @executor = Executor.find(params[:executor_id])
    @third = @will.third_executor || @executor.build_third_executor_general_detail
  end
  def forth_executor
    @will = Will.find(params[:will_id])
    @executor = Executor.find(params[:executor_id])
    @forth = @will.forth_executor || @executor.build_forth_executor_general_detail
  end
  def first_replacement_executor
    @will = Will.find(params[:will_id])
    @executor = Executor.find(params[:executor_id])
    @first_rep = @will.first_replacement_executor || @executor.build_first_replacement_executor_general_detail
  end
  def second_replacement_executor
    @will = Will.find(params[:will_id])
    @executor = Executor.find(params[:executor_id])
    @second_rep = @will.second_replacement_executor || @executor.build_second_replacement_executor_general_detail
  end
  def third_replacement_executor
    @will = Will.find(params[:will_id])
    @executor = Executor.find(params[:executor_id])
    @third_rep = @will.third_replacement_executor || @executor.build_third_replacement_executor_general_detail
  end
  def forth_replacement_executor
    @will = Will.find(params[:will_id])
    @executor = Executor.find(params[:executor_id])
    @forth_rep = @will.forth_replacement_executor || @executor.build_forth_replacement_executor_general_detail
  end


  private
    def set_executor
      @executor = Executor.find(params[:id])
    end

    def executor_params
      params.require(:executor).permit(:notary_express, :first, :second, :third, :forth, :replacement_first, :replacement_second, :replacement_third, :replacement_forth, 
        forth_replacement_executor_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        third_replacement_executor_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        second_replacement_executor_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        first_replacement_executor_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        forth_executor_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        third_executor_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        second_executor_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country],
        first_executor_general_detail_attributes: [:id, :will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country])
    end
end
