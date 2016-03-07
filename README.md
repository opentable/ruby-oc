# opencomponents
[![Build Status](https://travis-ci.org/opentable/ruby-oc.svg?branch=master)][1]
[![Coverage Status](https://coveralls.io/repos/opentable/ruby-oc/badge.svg)][2]
[![Code Climate](https://codeclimate.com/github/opentable/ruby-oc/badges/gpa.svg)][3]
[![Gem Version](https://badge.fury.io/rb/opencomponents.svg)][4]
[![Dependency Status](https://gemnasium.com/opentable/ruby-oc.svg)][5]

[1]:https://travis-ci.org/opentable/ruby-oc
[2]:https://coveralls.io/r/opentable/ruby-oc
[3]:https://codeclimate.com/github/opentable/ruby-oc
[4]:http://badge.fury.io/rb/opencomponents
[5]:https://gemnasium.com/opentable/ruby-oc

[OpenComponents][6] for Ruby

[6]:https://github.com/opentable/oc

## Getting Started
Add the gem to your Gemfile and run `bundle install`:
```ruby
gem 'opencomponents', '~> 0.4.0'
```

By default, the gem will attempt to use a component registry located at
`http://localhost:3030`.
If you want to use a different registry, you can configure OpenComponents to use
it with:
```ruby
OpenComponents.configure { |config| config.registry = 'http://some.other.host' }
```

## Getting Rendered Components
To request an OpenComponent with its rendered HTML, you can create and load a new
`RenderedComponent` object.
```ruby
component = OpenComponents::RenderedComponent.new('my-awesome-component')
component.load
```

Optionally, you can also specify parameters, the component version, and
additional HTTP headers to request:
```ruby
component = OpenComponents::RenderedComponent.new(
  'my-awesome-component',
  params: {name: 'Kate'},
  version: '1.0.2',
  headers: {'Accept-Language' => 'emoji'}
)
```

## Getting Unrendered Components
If you'd like to perform the component rendering yourself, you can request an
unrendered component from a registry using a `UnrenderedComponent` object.
```ruby
component = OpenComponents::UnrenderedComponent.new('my-awesome-component')
component.load
```

You can use the same optional `params`, `version`, and `headers` arguments as
`RenderedComponent`s.

**Note**: `UnrenderedComponent`s will only fetch component data for you - they
do not provide an interface for rendering them. At the moment, it's up to you to
determine the best way to render the template.

## Integrations
Individual integrations for rendering components in Rails and Sinatra are
available.
  * [opencomponents-rails][7]
  * [sinatra-opencomponents][8]

[7]:https://github.com/opentable/opencomponents-rails
[8]:https://github.com/opentable/sinatra-opencomponents

## Contributing
Would be rad. Open a PR or Issue if you have an idea for improvements.

## License
Copyright 2015 OpenTable. See LICENSE for details.
