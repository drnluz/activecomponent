# frozen_string_literal: true

require 'rails/railtie'

module ActiveComponent
  class Railtie < Rails::Railtie
    initializer "activecomponent.setup_view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include ActiveComponent::ViewHelpers
      end
    end
  end
end
