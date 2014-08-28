require File.expand_path('../../test_helper', __FILE__)

require 'manacle/constraint'

class Manacle::ConstraintTest < Test::Unit::TestCase
  def setup
    @mock_constrainable = Class.new do

      def self.constrainables
        [ActiveSupport::TimeWithZone, ::Time, ::Date]
      end

      include Manacle::Constraint

      def constraint=(constraint)
        @constraint = constraint
      end

      def constraint
        @constraint
      end
    end

    @mock_obj = mock
  end

  class ClassMethodsTest < self
    test '.constrain' do
      m = @mock_constrainable.constrain(@mock_obj)
    end
  end

  class InstanceMethodsTest < self
    def setup
      super 

      @mock_obj = mock

      @mock_actuator = mock

      Manacle::Constraint::Actuator.expects(:build).with(@mock_obj, instance_of(@mock_constrainable)).returns(@mock_actuator)

      @constraint = @mock_constrainable.new(@mock_obj)

      @mock_constraint = mock

      @constraint.constraint = @mock_constraint
    end

    test "#proxy" do
      mock_proxy_klass = mock
      mock_proxy_klass.expects(:kind_of?).with(Class).returns(true)
      
      mock_proxy_instance = mock

      mock_proxy_klass.expects(:new).with(@constraint).returns(mock_proxy_instance)

      @mock_actuator.expects(:proxy).returns(mock_proxy_klass)

      res = @constraint.proxy

      assert_equal res, mock_proxy_instance
    end

    test "#proxy not found" do
      mock_proxy_klass = mock
      mock_proxy_klass.expects(:kind_of?).with(Class).returns(false)

      @mock_actuator.expects(:proxy).returns(mock_proxy_klass)
      @mock_actuator.expects(:levels).returns([])

      assert_raises do
        @constraint.proxy
      end
    end

    test "#klass" do
      mock_val = mock
      @mock_actuator.expects(:constrain).returns(mock_val)

      mock_val_class = mock
      mock_val.expects(:class).returns(mock_val_class)

      result = @constraint.klass
      assert_equal mock_val_class, result
    end

    test "#unconstrain" do
      @mock_actuator.expects(:unconstrain).returns(@mock_obj)

      result = @constraint.unconstrain

      assert_equal @mock_obj, result
    end

    test "#reconstrain" do
      mock_new_obj = mock
      @mock_actuator.expects(:reconstrain).returns(mock_new_obj)

      mock_new_actuator = mock
      Manacle::Constraint::Actuator.expects(:build).with(mock_new_obj, instance_of(@mock_constrainable)).returns(mock_new_actuator)

      result = @constraint.reconstrain(mock_new_obj)
    end
  end
end
