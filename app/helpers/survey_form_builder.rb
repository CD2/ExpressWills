class SurveyFormBuilder < ActionView::Helpers::FormBuilder

  def self.create_tagged_field(method_name)
    define_method(method_name) do |label, *args|
      q = Question.all
      question = args.first[:question] unless args.first.blank?
      display_question = q.find_by(number:question).question if question
        @template.content_tag("label", display_question, :for => "#{@object_name}_#{label} ") + super(label, *args)
    end
  end

  field_helpers.each do |name|
    create_tagged_field(name)
  end
end