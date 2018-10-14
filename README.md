# Creatable

[![CodeFactor](https://www.codefactor.io/repository/github/erniebrodeur/creatable/badge)](https://www.codefactor.io/repository/github/erniebrodeur/creatable)

A mixin that adds a `create` method to any class.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'creatable'
```

And then execute:

    bundle

Or install it yourself as:

    gem install creatable

## Class Usage

``` ruby
class A
    # include the class
    include Creatable

    # add an attribute (will default to accessor)
    attribute name: 'an_attribute'

    # add the reader method only
    attribute name: 'an_attribute', type: 'reader'

    # add the writer method only
    attribute name: 'an_attribute', type: 'writer'

    # Restrict the type you can assign to this attribute
    attribute name: 'an_attribute', type: 'accessor', kind_of: String

    # You can assign multiple types
    attribute name: 'an_attribute', type: 'accessor', kind_of: [String, Array, nil]
end
```

## Instance Usage

``` ruby
    i = A.new

    # a hash of the current attributes.
    i.attributes

    # an array of the names
    i.attribute_names

    # The current values of all attributes as a hash
    i.to_parameters
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [github.com](https://github.com/erniebrodeur/creatable).
