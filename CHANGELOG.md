## 1.0.0.pre
 * Changes:
  * Dropped support for Ruby 1.9.3.
  * Dropped `rest-client` dependency.
  * Request headers now use string keys instead of symbols.
    ```ruby
    # Old
    { accept_language: 'en_us' }

    # New
    { 'Accept-Language' => 'en_us' }
    ```

## 0.5.0
 * Changes:
  * OpenComponents::PrerenderedComponent is now OpenComponents::UnrenderedComponent

## 0.4.0
 * Changes:
  * Default request timeout length shortened to 5 seconds.
  * Registry request timeout lengths can be configured.
    ```ruby
    OpenComponents.configure { |c| c.timeout = 10 }
    ```

 * Bugfixes
  * Fixed an issue where catching a request timeout would result in an infinite
    loop.

## 0.3.0
 * Changes:
  * Registry request timeouts now raise `OpenComponents::RegistryTimeout`.

## 0.2.0
 * Changes:
  * Changed Component initialization to accept an options Hash for
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
