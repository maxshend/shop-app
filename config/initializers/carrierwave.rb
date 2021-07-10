# frozen_string_literal: true

CarrierWave.configure do |config|
  config.storage :file
  config.asset_host = ENV['ASSET_HOST']
end
