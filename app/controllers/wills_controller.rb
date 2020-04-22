class WillsController < ApplicationController
  before_action :set_will, only: [:show, :edit, :update, :destroy]
  before_action :set_other_will, only: [:purchase, :final_will, :mirror_will]
  before_action :signed_in_user
  before_action :correct_user, except: [:index, :new, :create, :review]

  def index
    @wills = current_user.wills
  end

  def thanks
    @will = Will.find(params[:will_id])
  end

  def purchase
    @will = Will.find(params[:will_id])
    @user = @will.user
    @testator_details = @will.testator_general_details
    @order = Order.new
  end

  def review

  end

  def show
    @user = @will.user
    @testator_details = @will.testator_general_details
    @testator = @will.testator_detail
    @partner_details = @will.partner_general_details
    @partner = @will.partner_detail
    @funeral = @will.funeral
    @executor = @will.executor
    @first_executor = @will.first_executor
    @second_executor = @will.second_executor
    @third_executor = @will.third_executor
    @forth_executor = @will.forth_executor
    @execs = [@first_executor , @second_executor , @third_executor , @forth_executor]
    @first_executor_rep = @will.first_replacement_executor
    @second_executor_rep = @will.second_replacement_executor
    @third_executor_rep = @will.third_replacement_executor
    @forth_executor_rep = @will.forth_replacement_executor
    @exec_reps = [@first_executor_rep , @second_executor_rep , @third_executor_rep , @forth_executor_rep]

    @guardian = @will.guardian
    @personal_gift_permission = @will.personal_gift_permission

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

    @properties = @will.properties.where(complete:true)

    @cash_gifts = @will.cash_gifts

    @charitable_donations = @will.charitable_donations

    @admin = @will.administration

    @request = @will.request

    @residuaries = @will.residuary_details.where(complete:true)

    @personal_gift_permissions = @will.personal_gift_permission
    
  end

  def final_will
    @will = Will.find(params[:will_id])

    unless @will.order && @will.order.status == "Completed"
      flash[:error] = 'You must purchase the will first.'
      redirect_to will_purchase_path(@will)
      return
    end
    
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

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf    => "will",

          :template    => "wills/final_will.pdf.haml",
          :layout      => "pdf_layout.html",
          :margin => {:top                => 15,                     # default 10 (mm)
                     :bottom             => 10,
                     :left               => 10,
                     :right => 10 }, :footer => { :center => 'Page [page] of [topage]', :font_name          => "Times New Roman" },
                     :font_name          => "Times New Roman"
      end
      format.docx do
        render :docx => 'final_will',
               :filename => 'will.docx'
      end
    end
  end

  def mirror_will
    @will = Will.find(params[:will_id])
    @user = @will.user
    @testator_details = @will.partner_general_details
    @testator = @will.testator_detail
    @partner_details = @will.testator_general_details
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

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf    => "will",
          :template    => "wills/final_will_mirror.pdf.haml",
          :layout      => "pdf_layout.html",
          :margin => {:top                => 15,                     # default 10 (mm)
                     :bottom             => 10,
                     :left               => 10,
                     :right => 10 }, :footer => { :center => 'Page [page] of [topage]', :font_name          => "Times New Roman" },
                     :font_name          => "Times New Roman"
      end 
    end
  end

  def new
    if current_user.admin?
      redirect_to admin_wills_path
    end
    @will = Will.new
  end

  def edit
  end

  def email
    save_final_will
    if @will.mirror_will == "yes"
      save_mirror_will
    end
    WillPurchased.resend_will(@will).deliver
    flash[:notice] = "Will emailed"
    redirect_to admin_wills_path
  end

  def create
    @user = current_user
    @will = Will.create(will_params)
    if @will.save
      @will.update_attributes(user_id: current_user.id)
      redirect_to new_will_testator_detail_path(@will), notice: 'Will was successfully created.'
    else
      render :new
    end
  end

  def update
    if @will.update(will_params)
      redirect_to @will, notice: 'Will was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @will.destroy
    redirect_to wills_url, notice: 'Will was successfully destroyed.'
  end

  private
    def set_will
      @will = Will.find(params[:id])
    end

    def set_other_will
      @will = Will.find(params[:will_id])
    end

    def will_params
      params.require(:will).permit(:title, :tc)
    end

    def correct_user
      @will = Will.find_by(id: params[:id]) || Will.find(params[:will_id])
      @user = @will.user
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

  def save_final_will
    @will = Will.find(params[:will_id])
    render :pdf    => "will",
           :template    => "wills/final_will_reviewed.pdf.haml",
           :layout      => "pdf_layout.html",
           :margin => {:top                => 15,                     # default 10 (mm)
                       :bottom             => 10,
                       :left               => 10,
                       :right => 10 }, :footer => { :center => 'Page [page] of [topage]', :font_name          => "Times New Roman" },
           :font_name          => "Times New Roman",
           :save_to_file => Rails.root.join('tmp', "will_#{@will.id}.pdf"),
           :save_only => true

  end

  def save_mirror_will
    @will = Will.find(params[:will_id])
    render :pdf    => "will",
           :template    => "wills/mirror_will_reviewed.pdf.haml",
           :layout      => "pdf_layout.html",
           :margin => {:top                => 15,                     # default 10 (mm)
                       :bottom             => 10,
                       :left               => 10,
                       :right => 10 }, :footer => { :center => 'Page [page] of [topage]', :font_name          => "Times New Roman" },
           :font_name          => "Times New Roman",
           :save_to_file => Rails.root.join('tmp', "mirror_will_#{@will.id}.pdf"),
           :save_only => true

  end
end
