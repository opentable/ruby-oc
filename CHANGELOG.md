## 0.2.0
 * Changes:
  * Changed Component initialization to accept an unordered options Hash for
    optional arguments.
    
    ```ruby
    # Old
    OpenComponents::RenderedComponent.new('my-component', {name: 'foobar'})
    
    # New
    OpenComponents::RenderedComponent.new('my-component', params: {name: 'foobar'})
    ```
  * Allow Components to accept an optional Hash of HTTP headers to use in
    requests to a registry. Satisfies
    [#8](https://github.com/opentable/ruby-oc/issues/8).
    
    ```ruby
    OpenComponents::RenderedComponent.new('my-component', headers: {accept_language: 'emoji'})
    ```

## 0.1.0
 * Initial Release