require "bootstrap_form/datetimepicker/version"
require "bootstrap_form"
require "active_support/core_ext/date"
require "active_support/core_ext/time"

module BootstrapForm
  module Datetimepicker
    def datetime_picker(method, options = {})
      datetimepicker_class = options.delete(:datetimepicker_class) || "bootstrap_form-datetimepicker" 
      format_name = options.delete(:format_name) || nil

      initial_value = object.send(method)
      if initial_value.try(:acts_like_time?)
        options[:value] = initial_value.to_s(format_name)
      end

      form_group_builder(method, options) do
        prepend_and_append_input(options) do

          input_tag = @template.text_field(object_name, method, options)
          span_tag = content_tag :span, :class => "input-group-addon" do
              content_tag :span, "", :class => "glyphicon glyphicon-calendar"
            end
          content_tag :div, input_tag.concat(span_tag),
            :class => "#{datetimepicker_class} input-group date",
            :data => {
              "date-format" => "YYYY-MM-DD HH:mm:ss"
            }
        end
      end
    end
  end

  FormBuilder.send :include, Datetimepicker
end
