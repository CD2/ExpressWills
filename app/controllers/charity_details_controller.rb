class CharityDetailsController < ApplicationController
  before_action :set_charity_detail, only: [:show, :edit, :update, :destroy]

  # GET /charity_details
  def index
    @charity_details = CharityDetail.all
  end

  # GET /charity_details/1
  def show
  end

  # GET /charity_details/new
  def new
    @charity_detail = CharityDetail.new
  end

  # GET /charity_details/1/edit
  def edit
  end

  # POST /charity_details
  def create
    @charity_detail = CharityDetail.new(charity_detail_params)

    if @charity_detail.save
      redirect_to @charity_detail, notice: 'Charity detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /charity_details/1
  def update
    if @charity_detail.update(charity_detail_params)
      redirect_to @charity_detail, notice: 'Charity detail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /charity_details/1
  def destroy
    @charity_detail.destroy
    redirect_to charity_details_url, notice: 'Charity detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charity_detail
      @charity_detail = CharityDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def charity_detail_params
      params.require(:charity_detail).permit(:will_id, :name, :registered_charity_number, :address_one, :address_two, :city, :county, :country)
    end
end
