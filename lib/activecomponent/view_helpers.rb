# frozen_string_literal: true

module ActiveComponent
  module ViewHelpers
    def method_missing(method_name, *args, &block)
      component_constant = "#{method_name.to_s.camelize}Component".constantize

      content = capture(&block) if block
      component_constant.new(*args).render(content).html_safe
    end
    ruby2_keywords :method_missing if respond_to?(:ruby2_keywords, true)
  end
end
