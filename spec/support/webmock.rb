# frozen_string_literal: true

require 'webmock/rspec'

RSpec.configure do |config|
  disable_net = lambda {
    WebMock.disable_net_connect! allow_localhost: true, allow: /#{ENV['SELENIUM_HUB_URL']}/
  }

  disable_net.call

  config.around do |example|
    if example.metadata[:type] == :system
      WebMock.allow_net_connect!
      example.run
      disable_net.call
    else
      example.run
    end
  end
end
