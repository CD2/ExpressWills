class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login
  protect_from_forgery except: [:hook, :show]

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
    redirect_to will_thanks_path(@order.will)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    if @order.save
      if params[:order][:gold]
        @order.update_attributes(gold: true)
      end
      redirect_to @order.paypal_url(order_path(@order))
    else
      render :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end


  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"

      @order = Order.find params[:invoice]

      WillPurchased.purchaser_notify(@order.will).deliver
      WillPurchased.merlin_notify(@order.will).deliver
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  def shortcut
    @order = Order.new(order_params)
    if @order.save
      save_final_will
      WillPurchased.purchaser_notify(@order.will).deliver
     # WillPurchased.merlin_notify(@order.will).deliver
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
      redirect_to will_thanks_path(@order.will)
    end
  end

  private

  def save_final_will
    @will = @order.will
    @user = @will.user
    @testator_details = @will.testator_general_details
    @testator = @will.testator_detail
    @partner_details = @will.partner_general_details
    @funeral = @will.funeral
    @executor = @will.executor
    @first_executor = @will.first_executor
    @second_executor = @will.second_executor
    @third_executor = @will.third_executor
    @forth_executor = @will.forth_executor
    @first_executor_rep = @will.first_replacement_executor
    @second_executor_rep = @will.second_replacement_executor
    @third_executor_rep = @will.third_replacement_executor
    @forth_executor_rep = @will.forth_replacement_executor
    @exec_reps = [@first_executor_rep , @second_executor_rep , @third_executor_rep , @forth_executor_rep]

    @guardian = @will.guardian

    @first_guardian = @will.first_guardian
    @second_guardian = @will.second_guardian
    @third_guardian = @will.third_guardian
    @forth_guardian = @will.forth_guardian
    @guardians = [@first_guardian, @second_guardian, @third_guardian, @forth_guardian]

    @first_replacement_guardian = @will.first_replacement_guardian
    @second_replacement_guardian = @will.second_replacement_guardian
    @third_replacement_guardian = @will.third_replacement_guardian
    @forth_replacement_guardian = @will.forth_replacement_guardian
    @guardians_rep = [@first_replacement_guardian, @second_replacement_guardian, @third_replacement_guardian, @forth_replacement_guardian]

    @personal_gifts = @will.personal_gifts

    @properties = @will.properties.where(complete: true)

    @cash_gifts = @will.cash_gifts

    @charitable_donations = @will.charitable_donations

    @admin = @will.administration

    @request = @will.request
    @residuary = @will.residuary

    #residuary vars
    @residuaries = @will.residuary_details.where(complete:true)
    @primary_residuaries = @residuaries.where(secondary: false)
    @secondary_residuaries = @residuaries.where(secondary: true)

    @equal_shares = @primary_residuaries.where(share:"Equal shares")
    @trustees = @primary_residuaries.where(share:"Trustees to decide")
    @percents = @primary_residuaries - @equal_shares - @trustees

    @secondary_equal_shares = @will.residuary_details.where(secondary: true).where(share:"Equal shares")
    @secondary_trustees = @will.residuary_details.where(secondary: true).where(share:"Trustees to decide")
    @secondary_percents = @will.residuary_details.where(secondary: true).where.not(share:"Trustees to decide").where.not(share:"Equal shares")
    @will.update_attributes(final_will: render_to_string('wills/final_will.pdf'))
        render :pdf    => "will",
               :template    => "wills/final_will.pdf.haml",
               :layout      => "pdf_layout.html",
               :margin => {:top                => 15,                     # default 10 (mm)
                           :bottom             => 10,
                           :left               => 10,
                           :right => 10 }, :footer => { :center => 'Page [page] of [topage]', :font_name          => "Times New Roman" },
               :font_name          => "Times New Roman",
               :save_to_file => Rails.root.join('tmp', "will_#{@will.id}.pdf"),
               :save_only => true

  end
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:full_name, :email_address, :will_id, :price, :gold)
    end
end
