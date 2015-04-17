module WillsHelper
  def current_will
    @will = Will.find_by(id:params[:will_id]) || Will.find_by(id:params[:id])
  end
  def current_will?
    !current_will.nil?
  end

  def benificiary_details benificiary, share, type, letter

    prefix = (type == "percentage" ? "#{share} to" : "")
    postfix = (benificiary.certain_age && benificiary.certain_age != "no" ? " to be paid only when the aforementioned individual reaches the age of #{benificiary.certain_age}" : " absolutely")
    dead_age = (benificiary.if_dead_certain_age && benificiary.if_dead_certain_age != "no" ? " to be paid only when they reach the age of  #{benificiary.if_dead_certain_age}" : "")
    dead_extra = (benificiary.if_dead == "put_back_into_your_estate" ? "" : ". Should the aforementioned individual predecease me this gift shall instead fall to their child(ren) in equal shares#{dead_age}")
    if benificiary.charity_residuary_general_detail
      charity_no = (benificiary.charity_residuary_general_detail.registered_charity_number.gsub(/\s+/, "") == "" ? "" : ", registered charity number #{benificiary.charity_residuary_general_detail.registered_charity_number}")
      charity_add = (benificiary.charity_residuary_general_detail.address_one.gsub(/\s+/, "") == "" ? "" : ", of #{benificiary.charity_residuary_general_detail.full_address}")
    end
    case benificiary.residuary_type

    when "Individual"
      "(#{letter}) #{prefix} #{benificiary.individual_residuary_general_detail.full_name} of #{benificiary.individual_residuary_general_detail.full_address}#{postfix}#{dead_extra}".html_safe
    when "Charity"
      "(#{letter}) #{prefix} #{benificiary.charity_residuary_general_detail.name}#{charity_no}#{charity_add}".html_safe
    when "My grandchildren"
      "(#{letter}) #{prefix} #{prefix == '' ? 'M' : 'm'}y grandchildren in equal shares #{postfix}#{dead_extra}".html_safe
    when "My children"
      "(#{letter}) #{prefix} #{prefix == '' ? 'M' : 'm'}y children in equal shares #{postfix}#{dead_extra}".html_safe
    end
  end

end
