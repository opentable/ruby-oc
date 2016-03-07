require 'json'
require 'net/http'

require 'opencomponents/component'
require 'opencomponents/rendered_component'
require 'opencomponents/renderer'
require 'opencomponents/unrendered_component'
require 'opencomponents/version'

module OpenComponents
  # Public: Default OC registry URL (http://localhost:3030).
  DEFAULT_REGISTRY = 'http://localhost:3030'

  # Public: Default request timeout in seconds (5)
  DEFAULT_TIMEOUT = 5

  # Internal: Custom exception class to raise in the event a component cannot be
  # found in the registry.
  ComponentNotFound = Class.new(RuntimeError)

  # Internal: Custom exception class to raise for response timeouts.
  RegistryTimeout = Class.new(RuntimeError)

  # Internal: Stores configuration data.
  #
  # registry - String for the registry host.
  Configuration = Struct.new(:registry, :timeout)

  # Internal: Wrapper object for unrendered OC templates.
  #
  # src  - String for the template URL.
  # type - String for template engine type.
  # key  - String for template key.
  Template = Struct.new(:src, :type, :key)

  # Public: Getter for OC Configuration.
  #
  # Returns the Configuration if set, a default Configuration if not set.
  def self.config
    @@_config ||= Configuration.new(DEFAULT_REGISTRY, DEFAULT_TIMEOUT)
  end

  # Public: Setter for Configuration.
  #
  # Examples
  #
  #   OpenComponents.configure do |oc|
  #     oc.registry = 'http://my-awesome-oc-registry.com'
  #   end
  #
  # Returns the Configuration.
  def self.configure
    yield self.config
  end
end
