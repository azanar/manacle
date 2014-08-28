manacle
=======
[![Gem Version](https://badge.fury.io/rb/manacle.png)](http://badge.fury.io/rb/manacle)
[![Build Status](https://travis-ci.org/azanar/manacle.png?branch=wip)](https://travis-ci.org/azanar/manacle)
[![Code Climate](https://codeclimate.com/github/azanar/manacle.png)](https://codeclimate.com/github/azanar/manacle)
[![Coverage Status](https://coveralls.io/repos/azanar/manacle/badge.png?branch=master)](https://coveralls.io/r/azanar/manacle?branch=master)
[![Dependency Status](https://gemnasium.com/azanar/manacle.png)](https://gemnasium.com/azanar/manacle)

Want to have a variable in your program be constrained, even as you modify and use it?

Strap a Manacle to it!

Manacle is a framework for the creation of 'sticky' constraints.

Quick Start
===========

A common situation is to want to constrain a Time object in some way or another.

For example, say you want a Time value to always snap to the beginning of the day. You could create a Manacle like follows:

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

You'd then be able to use this manacle in your code as follows:

```ruby
time = Time.now
puts "Time in your timezone is #{time.to_s}"

# Manacle is applied here
bod = Manacle::Examples::BeginningOfDay.new(time).proxy
puts "Manacled time at beginning of the day is #{bod.to_s}"

bod_plus_one_hour = bod + 60*60
puts "Manacled time at BOD + 1 hour is #{bod_plus_one_hour.to_s}"

bod_plus_one_day = bod + 24*60*60
puts "Manacled time in BOD + 1 day is #{bod_plus_one_day.to_s}"

bod_plus_25_hours = bod + 25*60*60
puts "Manacled time in BOD + 25 hours is #{bod_plus_25_hours.to_s}"
```

This would print:

```
Time in your timezone is 2014-08-27 21:42:21 -0700
Manacled time at beginning of the day is 2014-08-27 00:00:00 -0700
Manacled time at BOD + 1 hour is 2014-08-27 00:00:00 -0700
Manacled time in BOD + 1 day is 2014-08-28 00:00:00 -0700
Manacled time in BOD + 25 hours is 2014-08-28 00:00:00 -0700
```

API Documentation
-------------

See [RubyDoc](http://rubydoc.info/github/azanar/manacle/index)

Contributors
------------

See [Contributing](CONTRIBUTING.md) for details.

License
-------

&copy;2014 Ed Carrel. Released under the MIT License.

See [License](LICENSE) for details.
