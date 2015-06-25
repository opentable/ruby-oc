require 'opencomponents/component'
require 'opencomponents/prerendered_component'
require 'opencomponents/rendered_component'
require 'opencomponents/template'
require 'opencomponents/version'

module OpenComponents
  DEFAULT_REGISTRY = 'http://localhost:3030'

  Configuration = Struct.new(:registry)

  def self.config
    @@_config ||= Configuration.new(DEFAULT_REGISTRY)
  end

  def self.configure
    yield self.config
  end
end
