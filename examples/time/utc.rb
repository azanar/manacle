require 'active_support/time_with_zone'
require 'manacle/constraint/method'

module Manacle
  module Examples
    class Utc
      include ::Manacle::Constraint::Method

      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      def constraint
        :utc
      end
    end
  end
end

time = Time.now
puts "Time in your timezone is #{time.to_s}"

utc = Manacle::Examples::Utc.new(time).proxy
puts "Time in UTC is #{utc.to_s}"

utc_plus_one_hour = utc + 60*60
puts "Time in UTC + 1 hour is #{utc_plus_one_hour.to_s}"

local_plus_one_hour = utc.localtime
puts "Time in UTC is #{local_plus_one_hour.to_s}"
