$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))
$LOAD_PATH.unshift(File.expand_path("..", __FILE__))

require "rails"
require "fake_app/fake_app"
require "rspec/rails"

require "bootstrap_form-datetimepicker"


Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? "schedules"
  end
  config.before :each do
    Schedule.delete_all
  end

  config.include ActionView::TestCase::Behavior
end
