class CharityPermissionsController < ApplicationController
  before_action :set_charity_permission, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 9
  end

  def new
    @will = Will.find(params[:will_id])
    @charity_permission = CharityPermission.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.charity_permission
      @charity_permission = @will.charity_permission
      @charity_permission.update(charity_permission_params)
    else
      @charity_permission = CharityPermission.new(charity_permission_params)
      @charity_permission.will_id = @will.id
    end
    if @charity_permission.save
      redirect_to option_will_properties_path(@will)
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @charity_permission.update(charity_permission_params)
      redirect_to option_will_properties_path(@will)
    else
      render :edit
    end
  end

  private
    def set_charity_permission
      @charity_permission = CharityPermission.find(params[:id])
    end

    def charity_permission_params
      params.require(:charity_permission).permit(:permission, :will_id)
    end
end
