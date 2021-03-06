# spec/support/anycable_setup.rb
RSpec.configure do |config|
  # Only start RPC server if system tests are included into the run
  next if config.filter.opposite.rules[:type] == "system" || config.exclude_pattern.match?(%r{spec/system})

  require "anycable/cli"
  AnyCable::CLI.embed!

  # Make sure AnyCable pubsub adapter is used in system tests (and test adapter otherwise, so we can run unit tests)
  config.before(:each, type: :system) do
    next if ActionCable.server.pubsub.is_a?(ActionCable::SubscriptionAdapter::AnyCable)

    @__was_pubsub_adapter__ = ActionCable.server.pubsub

    adapter = ActionCable::SubscriptionAdapter::AnyCable.new(ActionCable.server)
    ActionCable.server.instance_variable_set(:@pubsub, adapter)
  end

  config.after(:each, type: :system) do
    next unless instance_variable_defined?(:@__was_pubsub_adapter__)
    ActionCable.server.instance_variable_set(:@pubsub, @__was_pubsub_adapter__)
  end
end