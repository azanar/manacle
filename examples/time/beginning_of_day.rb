require 'active_support/core_ext/time/calculations'
require 'manacle/constraint/method'

module Manacle
  module Examples
    class BeginningOfDay
      include ::Manacle::Constraint::Method

      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      def constraint
        :beginning_of_day
      end
    end
  end
end

time = Time.now
puts "Time in your timezone is #{time.to_s}"

bod = Manacle::Examples::BeginningOfDay.new(time).proxy
puts "Manacled time at beginning of the day is #{bod.to_s}"

bod_plus_one_hour = bod + 60*60
puts "Manacled time at BOD + 1 hour is #{bod_plus_one_hour.to_s}"

bod_plus_one_day = bod + 24*60*60
puts "Manacled time in BOD + 1 day is #{bod_plus_one_day.to_s}"

bod_plus_25_hours = bod + 25*60*60
puts "Manacled time in BOD + 25 hours is #{bod_plus_25_hours.to_s}"


puts "Manacled time is constrained: #{bod.unproxy.constrained?}"

unproxy = bod.unconstrain
unproxy_plus_one_hour = unproxy + 60*60

puts "Unmanacled time + 1 hour is #{unproxy_plus_one_hour.to_s}"
