class GeneralDetailsController < ApplicationController
  before_action :set_general_detail, only: [:show, :edit, :update, :destroy]

  # GET /general_details
  def index
    @general_details = GeneralDetail.all
  end

  # GET /general_details/1
  def show
  end

  # GET /general_details/new
  def new
    @general_detail = GeneralDetail.new
    @question = Question.all
  end

  # GET /general_details/1/edit
  def edit
  end

  # POST /general_details
  def create
    @general_detail = GeneralDetail.new(general_detail_params)

    if @general_detail.save
      redirect_to @general_detail, notice: 'General detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /general_details/1
  def update
    if @general_detail.update(general_detail_params)
      redirect_to @general_detail, notice: 'General detail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /general_details/1
  def destroy
    @general_detail.destroy
    redirect_to general_details_url, notice: 'General detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_general_detail
      @general_detail = GeneralDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def general_detail_params
      params.require(:general_detail).permit(:will_id, :relationship, :first_name, :middle_name, :surname, :address_one, :address_two, :city, :county, :postcode, :country)
    end
end
