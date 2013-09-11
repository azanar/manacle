require File.expand_path('../../../../test_helper', __FILE__)

require 'manacle/constraint/actuator/base'

class Manacle::Constraint::Actuator::BaseTest < Test::Unit::TestCase
  def setup
    @mock_value = mock
    @mock_constraint = mock

    @actuator = Manacle::Constraint::Actuator::Base.new(@mock_value, @mock_constraint)

  end

  puts Test::Unit::TestCase.method(:test).inspect

  test '#constrain uncached' do

    mock_constrained = mock
    @mock_constraint.expects(:base_constrain).returns(mock_constrained)

    result = @actuator.constrain

    assert_equal mock_constrained, result
  end

  test '#constrain cached' do

    mock_constrained = mock

    @mock_value.expects(:constrain).never

    @actuator.instance_variable_set(:@constrained, mock_constrained)

    result = @actuator.constrain

    assert_equal mock_constrained, result
  end

  test '#reconstrain' do
    mock_new_value = mock

    mock_actuator = mock
    Manacle::Constraint::Actuator::Base.expects(:new).with(mock_new_value, @mock_constraint).returns(mock_actuator)

    result = @actuator.reconstrain(mock_new_value)

    assert_equal mock_actuator, result
  end

  test '#proxy' do
    mock_proxy = mock
    Manacle::Proxy::Templates.expects(:for).with(@mock_value).returns(mock_proxy)

    result = @actuator.proxy

    assert_equal mock_proxy, result
  end
end
