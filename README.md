# Active Component - View Components For Rails

Active Component is a simple gem to create self contained and reusable view components in Ruby on Rails.

⚠️ This gem is currently a proof of concept and shouldn't be used in production without a thorough test and code review.

## Motivation

### Encapsulation

One recurring problem in Rails applications is the spread of presentation logic in models, controllers and helpers. Decorator libraries such as `Draper` solve this issue to some degree but it's still limited as they just provide a layer on top of a model object. You can't use a decorator to control template logic that's not directly related to the decorated model.

Active Component offers a solution to encapsulate the template along with all the view logic required to render the template.

### Reusability

By having all the logic and the template required to render a component in a single file, components are easier to reuse in a project and between multiple projects.

### Cleaner Templates

The Rails framework provides a simple and easy way to reuse pieces of templates by allowing these pieces to be moved to separate files and used by other templates through `render` calls. These smaller pieces of templates are called `partials`.

One problem with partials become apparent when dealing with large and complex pages where many `render` calls are necessary to compose the page based on many partials. These many `render` calls makes the page template harder to read and maintain.

To solve this problem, Active Component provides helper methods to render components inside existing ActionView templates without the need to manually call `render partial: 'partial'`.

## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'slim-rails'
gem 'activecomponent'
```

And then execute:

    $ bundle install

## Usage

An Active Component is a class that inherits from `ActiveComponent::Base` and defines a `template`. Currently only [slim](https://github.com/slim-template/slim) templates are supported.

```ruby
# app/components/product_component.rb
class ProductComponent < ActiveComponent::Base
  template <<~SLIM
    .product
      h2 Product Name
      p Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  SLIM
end

ProductComponent.new.render
# => "<div class=\"product\"><h2>Product Name</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p></div>"
```

Any object can be passed to a component. This object will be available for use in the component as `object` and can be used to create methods to fetch and format the data required by the component template:

```ruby
# app/components/product_component.rb
class ProductComponent < ActiveComponent::Base
  template <<~SLIM
    .product
      h2 = name
      p = description
      p = price
  SLIM

  def name
    object.name.titleize
  end

  def description
    "#{object.description.first(10)}..."
  end

  def price
    "$#{'%.2f' % object.price}"
  end
end

product = OpenStruct.new(name: 'product name', description: 'Lorem ipsum dolor sit amet', price: 42)
ProductComponent.new(product).render
# => "<div class=\"product\"><h2>Product Name</h2><p>Lorem ipsu...</p><p>$42.00</p></div>"
```

Components can be nested. The inner component markup will be accessible through the `content` method:

```ruby
# app/components/card_component.rb
class CardComponent < ActiveComponent::Base
  template <<~SLIM
    .card
      = content
  SLIM
end

product_html = ProductComponent.new(product).render
CardComponent.new.render(product_html)
# => "<div class=\"card\"><div class=\"product\"><h2>Product Name</h2><p>Lorem ipsu...</p><p>$42.00</p></div></div>"
```

### Action View Helpers

Active Component exposes helper methods to render components in the view. The helper method name convention is the name of the component class minus the "Component" word. A component called `ProductComponent` will be accessible through the `product` helper method.

```slim
/ app/views/products/index.html.slim

h1 Available Products
- @products.each do |p|
  = product(p)
```

Component helper methods can be nested. ...

```slim
/ app/views/products/index.html.slim

h1 Available Products
= card
  - @products.each do |p|
    = product(p)
```

## TODO

- [ ] Support ERB and haml templates
- [ ] Check keyword argument delegation for ruby 3
- [ ] Additional component arguments
- [ ] Configurable helper method name
- [ ] Remove ActionView dependency
- [ ] Make helpers available in components
- [ ] RDoc

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/drnluz/activecomponent.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
