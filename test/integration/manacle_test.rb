require File.expand_path('../test_helper', __FILE__)

require 'active_support'
require 'active_support/core_ext'
require 'date'
require 'manacle/constraint/method'

class Manacle::ConstraintTest < Test::Unit::TestCase
  test '#constrain' do
    mock_constrainable = Class.new do

      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      include Manacle::Constraint::Method

      def constraint
        :utc
      end
    end

    time = Time.new

    orig = mock_constrainable.new(time).proxy

    mod = orig + 1.day + 5.hours + 30.minutes

    assert mod.kind_of?(::Time), "Result of kind #{mod.class.ancestors} instead of Time"
    assert_equal mod.constrain, (time + 1.day + 5.hours + 30.minutes).utc
  end

  test '#constrain comparisons' do
    mock_constrainable = Class.new do

      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      include Manacle::Constraint::Method

      def constraint
        :utc
      end
    end

    time = Time.new

    orig = mock_constrainable.new(time).proxy


    mod = orig + 1.day + 5.hours + 30.minutes

    assert_equal 1, mod <=> orig
    assert_equal -1, orig <=> mod
    assert_equal 0, orig <=> orig

    assert mod.kind_of?(::Time), "Result of kind #{mod.class.ancestors} instead of Time"
    assert_equal mod.constrain, (time + 1.day + 5.hours + 30.minutes).utc
  end

  test '#constrain nesting' do
    mock_constrainable = Class.new do
      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      include Manacle::Constraint::Method

      def constraint
        :utc
      end
    end

    mock_other_constrainable = Class.new do
      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      include Manacle::Constraint::Method

      def constraint
        :beginning_of_day
      end
    end

    time = Time.now.in_time_zone('PST8PDT')
    
    orig_cons = mock_constrainable.new(time)
    oo_cons = mock_other_constrainable.new(orig_cons)
    oo = oo_cons.proxy

    mod = oo + (1.day + 5.hours + 30.minutes)

    assert mod.kind_of?(::Time)
    assert_equal mod.constrain, (time + 1.day).utc.beginning_of_day
    
  end

  test '#constrain repeated' do
    mock_constrainable = Class.new do

      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      include Manacle::Constraint::Method

      def constraint
        :utc
      end
    end

    mock_other_constrainable = Class.new do
      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date] 
      end

      include Manacle::Constraint::Method

      def constraint
        :beginning_of_day
      end
    end

    time = Time.now.in_time_zone('PST8PDT')
    
    orig_cons = mock_constrainable.new(time)
    oo_cons = mock_other_constrainable.new(orig_cons)

    oo = oo_cons.proxy


    5.times do
      oo = oo + (1.day + 5.hours + 30.minutes)
    end

    5.times do
      oo = oo.in_time_zone("PST8PDT")
    end


    assert_kind_of ::Time, oo
    constrained = oo.constrain
    assert_kind_of ::Time, constrained

    expected_time = (time + 5.day).utc.beginning_of_day
    assert_equal expected_time, constrained
    
  end
end

