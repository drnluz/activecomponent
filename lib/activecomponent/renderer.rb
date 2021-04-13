# frozen_string_literal: true

module ActiveComponent
  module Renderer
    def self.render(template, context)
      case ActiveComponent.config.template_engine
      when :slim
        Slim::Template.new { template }.render(context)
      when :erb
        raise NotImplemented
      when :haml
        raise NotImplemented
      end
    end
  end
end
