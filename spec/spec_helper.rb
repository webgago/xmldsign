# encoding: UTF-8
$:.unshift File.expand_path('../../ext/', __FILE__)
require 'rspec'
require 'xmldsign'
require 'pry'
require 'pry-debugger'

module Assets
  def asset(file)
    File.read File.join(RSpec.configuration.assets_dir, file)
  end
end

RSpec.configure do |config|
  config.alias_example_to :fit, focused: true
  config.filter_run focused: true
  config.run_all_when_everything_filtered = true
  config.add_setting :assets_dir, default: File.expand_path('../assets', __FILE__)
  config.include Assets
  config.color_enabled = true
end

