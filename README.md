# Datetime Picker with Rails Bootstrap Forms

Add on for [bootstra@_form](http://rubygems.org/gems/bootstrap_form) to embed [bootstrap-datetimepicker](http://eonasdan.github.io/bootstrap-datetimepicker/) simply.

## Requirements

* Ruby 2.1+
* Rails 4.1+
* Twitter Bootstrap 3.0+

## Installation

Add this line to your application's Gemfile:

    gem 'bootstrap_form-datetimepicker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bootstrap_form-datetimepicker

## Usage

Call `datetime_picker` within `bootstrap_form_for`:

```erb
<%= bootstrap_form_for(@item) do |f| %>
  <%= f.datetime_picker :available_since %>
<% end %>
```

## Contributing

1. Fork it ( https://github.com/a2ikm/bootstrap_form-datetimepicker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
