# frozen_string_literal: true

require_relative 'activecomponent/base'
require_relative 'activecomponent/config'
require_relative 'activecomponent/view_helpers'
require_relative 'activecomponent/renderer'
require_relative 'activecomponent/version'
require_relative 'activecomponent/railtie'

module ActiveComponent
  class Error < StandardError; end
  class NotImplemented < StandardError; end
end
