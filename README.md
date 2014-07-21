[![Build Status](https://travis-ci.org/a2ikm/bootstrap_form-datetimepicker.svg?branch=master)](https://travis-ci.org/a2ikm/bootstrap_form-datetimepicker)

# Datetime Picker with Rails Bootstrap Forms

[bootstrap_form](http://rubygems.org/gems/bootstrap_form) add-on to embed [bootstrap-datetimepicker](http://eonasdan.github.io/bootstrap-datetimepicker/) simply.

## Requirements

* Ruby 2.1+
* Rails 4.1+
* Twitter Bootstrap 3.0+
* bootstrap-datetimepicker
* momentjs

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

will produce HTML like:

```html
<div class="form-group">
  <label class="control-label" for="item_available_since">Available Since</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD HH:mm:ss ZZ">
    <input class="form-control" id="item_available_since" name="item[available_since]" type="text" value="1955-10-23 11:22:33" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
```

Note that `bootstrap_form-datetimepicker` class is used for wrapping div element. So You should initialize widget like:

```javascript
$(function () {
    $('.bootstrap_form-datetimepicker').datetimepicker();
});
```

You can specify the element's class with `:datetimepicker_class` option like:

```erb
<%= bootstrap_form_for(@item) do |f| %>
  <%= f.datetime_picker :available_since, datetimepicker_class: "my-picker-class" %>
<% end %>
```


### Customizing format

You can specify datetime's format with `:format` option like:

```erb
<%= bootstrap_form_for(@item) do |f| %>
  <%= f.datetime_picker :available_since, format: "%Y-%m-%d" %>
<% end %>
```

or format's name defined in `Time::DATE_FORMATS` like:

```erb
<%= bootstrap_form_for(@item) do |f| %>
  <%= f.datetime_picker :available_since, format: :db %>
<% end %>
```

bootstrap-datetimepicker formats datetime with [momentjs](http://momentjs.com), whose [its formating syntax](http://momentjs.com/docs/#/parsing/string-format/) differs from ruby's that. So this gem converts between them automatically, but in some cases, it can't (using `proc`, `%e`, etc). At that time, you should specify bootstrap-datetimepicker's format with `:datetimepicker_format` option like:

```erb
<%= bootstrap_form_for(@item) do |f| %>
  <%= f.datetime_picker :available_since, format: "%e %b", datetimepicker_format: "dd MMM" %>
<% end %>
```


## Contributing

1. Fork it ( https://github.com/a2ikm/bootstrap_form-datetimepicker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
