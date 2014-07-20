require "bootstrap_form/datetimepicker/version"
require "bootstrap_form"

module BootstrapForm
  module Datetimepicker
    def datetime_picker(method, options = {})
      form_group_builder(method, options) do
        prepend_and_append_input(options) do
          input_tag = @template.text_field(object_name, method, options)
          span_tag = content_tag :span, :class => "input-group-addon" do
              content_tag :span, "", :class => "glyphicon glyphicon-calendar"
            end
          content_tag :div, input_tag.concat(span_tag),
            :class => "bootstrap_form-datetimepicker input-group date",
            :data => {
              "date-format" => "YYYY-MM-DD HH:mm:ss"
            }
        end
      end
    end
  end

  FormBuilder.send :include, Datetimepicker
end
