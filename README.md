[![Gem Version](https://badge.fury.io/rb/manacle.png)](http://badge.fury.io/rb/manacle)
[![Build Status](https://travis-ci.org/azanar/manacle.png?branch=master)](https://travis-ci.org/azanar/manacle)
[![Code Climate](https://codeclimate.com/github/azanar/manacle.png)](https://codeclimate.com/github/azanar/manacle)
[![Coverage Status](https://coveralls.io/repos/azanar/manacle/badge.png?branch=master)](https://coveralls.io/r/azanar/manacle?branch=master)
[![Dependency Status](https://gemnasium.com/azanar/manacle.png)](https://gemnasium.com/azanar/manacle)

manacle
=======

Manacle is a library for the creation of 'sticky' constraints.

What is a 'sticky' constraint?
============================

Say you changing pricing a product, and always want the price to end with 99. 

Typically, when you modify the price, you'll have to redo the calculation to make it end in 99.

A 'sticky' constraint means you have to declare your intent once, and the price enforces its own constraint as you make changes, even changes that would otherwise make it not end in 99.

Quick Start
===========

A common situation is to want to constrain a Time object in some way or another.

For example, say you want a Time value to always snap to the beginning of the day.

### Defining the manacle

```ruby
require 'manacle/constraint/method'

module Manacle
  module Examples
    class BeginningOfDay
      include ::Manacle::Constraint::Method

      # Defines what types of values this manacle can constrain
      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      # Defines the constraint to call each time the underlying object is modified.
      def constraint
        :beginning_of_day
      end
    end
  end
end
```

### Using the manacle

```ruby
time = Time.now
puts "1. Time in your timezone is #{time.to_s}"

# Manacle is applied here
bod = Manacle::Examples::BeginningOfDay.new(time).proxy
puts "2. Manacled time at beginning of the day is #{bod.to_s}"

bod_plus_one_hour = bod + 60*60
puts "3. Manacled time at BOD + 1 hour is #{bod_plus_one_hour.to_s}"

bod_plus_one_day = bod + 24*60*60
puts "4. Manacled time in BOD + 1 day is #{bod_plus_one_day.to_s}"

bod_plus_25_hours = bod + 25*60*60
puts "5. Manacled time in BOD + 25 hours is #{bod_plus_25_hours.to_s}"
```


If the time was `2014-08-27 21:42:21 -0700`, this would print:

```
1. Time in your timezone is 2014-08-27 21:42:21 -0700
2. Manacled time at beginning of the day is 2014-08-27 00:00:00 -0700
3. Manacled time at BOD + 1 hour is 2014-08-27 00:00:00 -0700
4. Manacled time in BOD + 1 day is 2014-08-28 00:00:00 -0700
5. Manacled time in BOD + 25 hours is 2014-08-28 00:00:00 -0700
```

### Unconstraining

This time is now constrained forever to be beginning of the day. Unless you don't want it to be.

You can unmanacle any object, by calling `#unconstrain`. From the example above:

```rb
unproxy = bod.unconstrain
unproxy_plus_one_hour = unproxy + 60*60

puts "Unmanacled time + 1 hour is #{unproxy_plus_one_hour.to_s}"
```

This would print:

```
Unmanacled time + 1 hour is 2014-08-27 22:58:33 -0700
```

API Documentation
-------------

See [RubyDoc](http://rubydoc.info/github/azanar/manacle/index)

Contributors
------------

See [Contributing](CONTRIBUTING.md) for details.

License
-------

&copy;2016 Ed Carrel. Released under the MIT License.

See [License](LICENSE) for details.
