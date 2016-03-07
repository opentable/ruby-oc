module OpenComponents
  # Wrapper object for components using the `rendered` rendering mode.
  class RenderedComponent < Component
    # Public: Returns the HTML String for the rendered component.
    attr_reader :html

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
      @html = response_data['html']

      super
    end
  end
end
