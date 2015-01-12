module ApplicationHelper
  def full_title(page_title)
        base_title = "Express Wills"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end
  def question number
    Question.find_by(number: number).question
  end
  def show_errors(object, field_name)
    if object.error.any?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end
  end 

  def will_link(object, name, controller_name)
    @will = current_will if current_will?
    if object
      if params[:controller] == controller_name
        link_to name, [:edit, @will, object], class: "active"
      else
        link_to name, [:edit, @will, object]
      end
    else
      if params[:controller] == controller_name
        content_tag :span, name, class: "active"
      else
        content_tag :span, name
      end
    end
  end

  def will_sub_link(parent, object_spec, object, name)
    @will = current_will if current_will?
    if object_spec
      "<li>#{link_to name, [@will, parent, object]}</li>".html_safe
    end
  end

  
end
