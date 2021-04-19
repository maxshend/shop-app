# frozen_string_literal: true

Capybara.register_driver :chrome_headless do |app|
  capabilities = [
    Selenium::WebDriver::Remote::Capabilities.chrome(
      'goog:chromeOptions' => { args: %w[no-sandbox headless disable-gpu window-size=1400,1400] }
    )
  ]

  if ENV['SELENIUM_HUB_URL']
    Capybara::Selenium::Driver.new app, url: ENV['SELENIUM_HUB_URL'], browser: :remote, capabilities: capabilities
  else
    Capybara::Selenium::Driver.new app, browser: :chrome, capabilities: capabilities
  end
end

RSpec.configure do |config|
  app_url = URI.parse ENV['RAILS_APP_URL']
  ip_host = IPSocket.getaddress Socket.gethostname

  config.before(:each, type: :system) do
    driven_by :chrome_headless

    Capybara.app_host = "http://#{ip_host}:#{app_url.port}"
    Capybara.server_host = ip_host
    Capybara.server_port = app_url.port
  end
end
