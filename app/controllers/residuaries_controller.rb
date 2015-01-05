class ResiduariesController < ApplicationController
  before_action :set_residuary, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 13
  end

  def new
    @will = Will.find(params[:will_id])
    @residuary = Residuary.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.residuary
      @residuary = @will.residuary
      @residuary.update(residuary_params)
    else
      @residuary = Residuary.new(residuary_params)
      @residuary.will_id = params[:will_id]
    end
    if @residuary.save
      redirect_to secondary_will_residuary_details_path
    else
      render :new
    end
  end

  def update
    if @residuary.update(residuary_params)
      redirect_to secondary_will_residuary_details_path
    else
      render :edit
    end
  end

  private
    def set_residuary
      @residuary = Residuary.find(params[:id])
    end

    def residuary_params
      params.require(:residuary).permit(:amount_allowed_to_distribute)
    end
end
