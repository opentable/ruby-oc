module OpenComponents
  # Wrapper object for components using the `unrendered` rendering mode.
  class UnrenderedComponent < Component
    # Internal: Default HTTP headers to send when requesting a component.
    DEFAULT_HEADERS = {'Accept' => 'application/vnd.oc.unrendered+json'}

    # Public: Returns a Hash of data to use when rendering the component.
    attr_reader :data

    # Public: Returns a Template with data for rendering the raw component.
    attr_reader :template

    # Public: Initializes a new UnrenderedComponent.
    #
    # name - The String name of the component to request.
    #
    # Options
    #   params  - A Hash of parameters to send in the component request (default: {}).
    #   version - The String version of the component to request (default: nil).
    #   headers - A Hash of HTTP request headers to include in the request (default: DEFAULT_HEADERS).
    def initialize(name, params: {}, version: nil, headers: {})
      super

      @headers.merge!(DEFAULT_HEADERS)
    end

    # Public: Executes a request for the Component against the configured
    # registry and sets the component attributes.
    #
    # Examples
    #
    #   component = OpenComponents::RenderedComponent.new('my-component')
    #   component.load
    #   # => #<OpenComponents::RenderedComponent: ... >
    #
    # Returns the Component with attributes set.
    def load
      template_data = response_data['template']

      @data     = response_data['data']
      @template = Template.new(
        template_data['src'], template_data['type'], template_data['key']
      )

      super
    end
  end
end
