class FuneralsController < ApplicationController
  before_action :set_funeral, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 3
  end

  def new
    @will = Will.find(params[:will_id])
    @funeral = Funeral.new
  end

  def edit
    
    @will = Will.find(params[:will_id])
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.funeral
      @funeral = @will.funeral
      @funeral.update(funeral_params)
    else
      @funeral = Funeral.new(funeral_params)
      @funeral.will_id = params[:will_id]
    end
    if @funeral.save
      redirect_to new_will_executor_path
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @funeral.update(funeral_params)
      redirect_to new_will_executor_path
    else
      render :edit
    end
  end

  private
    def set_funeral
      @funeral = Funeral.find(params[:id])
    end

    def funeral_params
      params.require(:funeral).permit(:preference, :wishes, :donate_organs, :specific_organs)
    end
end
