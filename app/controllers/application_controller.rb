class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :require_login

  def update_will_progress number
    @will = Will.find(params[:will_id])
    if @will.progress < number
      @will.update_attributes(progress:number)
    end
  end
  
end
