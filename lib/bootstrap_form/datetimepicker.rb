require "bootstrap_form/datetimepicker/version"
require "bootstrap_form"
require "active_support/core_ext/date"
require "active_support/core_ext/time"

module BootstrapForm
  module Datetimepicker
    STRFTIME_MOMENTJS = {
      "a" => "ddd",
      "A" => "dddd",
      "b" => "MMM",
      "B" => "MMMM",
      "d" => "DD",
      "H" => "HH",
      "I" => "hh",
      "j" => "DDDD",
      "m" => "MM",
      "M" => "mm",
      "p" => "A",
      "S" => "ss",
      "Z" => "z",
      "z" => "ZZ",
      "w" => "d",
      "y" => "YY",
      "Y" => "YYYY",
    }

    def datetime_picker(method, options = {})
      datetimepicker_class = options.delete(:datetimepicker_class) || "bootstrap_form-datetimepicker" 

      format = options.delete(:format)
      if format
        format = Time::DATE_FORMATS[format] if Time::DATE_FORMATS.has_key?(format)
      else
        format = "%Y-%m-%d %H:%M:%S %z"
      end

      initial_value = object.send(method)
      if format.respond_to?(:call)
        options[:value] = format.call(initial_value)
      elsif initial_value.try(:acts_like_time?)
        options[:value] = initial_value.strftime(format)
      else
        options[:value] = initial_value
      end

      date_format = "YYYY-MM-DD HH:mm:ss ZZ"
      if format.is_a?(String)
        date_format = strftime2momentjs(format)
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
              "date-format" => date_format
            }
        end
      end
    end

    private

      def strftime2momentjs(format)
        replaced = format.dup
        STRFTIME_MOMENTJS.each do |key, replacement|
          replaced.gsub!("%#{key}", replacement)
        end
        replaced
      end
  end

  FormBuilder.send :include, Datetimepicker
end
