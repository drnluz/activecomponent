# frozen_string_literal: true

module ActiveComponent
  class Base
    attr_reader :object

    def self.template(template)
      @__template = template
    end

    def initialize(object = nil)
      @object = object
    end

    def render(content)
      @__content = content.html_safe if content
      ActiveComponent::Renderer.render(self.class.instance_variable_get(:@__template), self)
    end

    def content
      @__content
    end
  end
end
