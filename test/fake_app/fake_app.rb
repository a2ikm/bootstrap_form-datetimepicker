require "active_record"
require "action_controller/railtie"
require "action_view/railtie"

# config
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

module FakeApp
  class Application < Rails::Application
    config.secret_token = "All I've got to do is to bring my board."
    config.session_store :cookie_store, :key => "_fake_app_session"
    config.active_support.deprecation = :log
    config.eager_load = false
  end
end
FakeApp::Application.initialize!

# routes
FakeApp::Application.routes.draw do
  resources :schedules, :only => [:new]
end

# models
class Schedule < ActiveRecord::Base
end

# helpers
module ApplicationHelper; end

# controllers
class ApplicationController < ActionController::Base
  self.append_view_path File.dirname(__FILE__)
end

# migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    suppress_messages do
      create_table(:schedules) { |t| t.datetime :until }
    end
  end
end
