# frozen_string_literal: true

module ActiveComponent
  class << self
    def configure
      yield config
    end

    def config
      @__config ||= Config.new
    end
  end

  class Config
    attr_accessor :template_engine

    def initialize
      @template_engine = :slim
    end
  end
end
