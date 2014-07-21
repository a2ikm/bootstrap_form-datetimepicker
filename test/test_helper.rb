$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))
$LOAD_PATH.unshift(File.expand_path("..", __FILE__))

ENV["RAILS_ENV"] = "test"

require "rails"
require "fake_app/fake_app"
require "rails/test_help"

require "bootstrap_form-datetimepicker"
