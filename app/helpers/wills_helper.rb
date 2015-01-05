module WillsHelper
  def current_will
    @will = Will.find_by(id:params[:will_id]) || Will.find_by(id:params[:id])
  end
  def current_will?
    !current_will.nil?
  end
end
