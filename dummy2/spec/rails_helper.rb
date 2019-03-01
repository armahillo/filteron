ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)

require "spec_helper"
require "rspec/rails"
require "capybara/rails"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include AbstractController::Translation
  config.include ActiveSupport::Testing::TimeHelpers
  config.include ActiveJob::TestHelper, type: :job
  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!

  config.before :suite do
    Rails.application.load_tasks

    FactoryBot.lint
    FactoryBot.reload

    Capybara.default_wait_time = 120 if ENV["CI"].present?
    Capybara.asset_host = "http://localhost:3000"
  end

  config.after js: true do
    Capybara.reset_sessions!
    page.driver.reset!
  end
end
