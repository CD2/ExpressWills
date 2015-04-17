class PersonalGiftPermissionsController < ApplicationController
  before_action :set_personal_gift_permission, only: [:show, :edit, :update, :destroy]
  after_action only: :create do
    update_will_progress 11
  end

  def new
    @will = Will.find(params[:will_id])
    @personal_gift_permission = PersonalGiftPermission.new
  end

  def edit
    @will = Will.find(params[:will_id])
  end

  def create
    @will = Will.find(params[:will_id])
    if @will.personal_gift_permission
      @personal_gift_permission = @will.personal_gift_permission
      @personal_gift_permission.update(personal_gift_permission_params)
    else
      @personal_gift_permission = PersonalGiftPermission.new(personal_gift_permission_params)
      @personal_gift_permission.will_id = @will.id
    end
    if @personal_gift_permission.save
      redirect_to will_residuary_details_path(@will)
    else
      render :new
    end
  end

  def update
    @will = Will.find(params[:will_id])
    if @personal_gift_permission.update(personal_gift_permission_params)
      redirect_to will_residuary_details_path(@will)
    else
      render :edit
    end
  end

  private
    def set_personal_gift_permission
      @personal_gift_permission = PersonalGiftPermission.find(params[:id])
    end

    def personal_gift_permission_params
      params.require(:personal_gift_permission).permit(:permission, :will_id)
    end
end