require File.expand_path('../../../../test_helper', __FILE__)

require 'manacle/constraint/actuator/nested'

class Manacle::Constraint::Actuator::NestedTest < Test::Unit::TestCase
  def setup
    @mock_nested = mock
    @mock_constraint = mock

    @actuator = Manacle::Constraint::Actuator::Nested.new(@mock_nested, @mock_constraint)

  end

  test '#constrain uncached' do

    mock_ascending_value = mock
    @mock_nested.expects(:constrain).returns(mock_ascending_value)

    mock_constrained = mock
    @mock_constraint.expects(:base_constrain).returns(mock_constrained)

    result = @actuator.constrain

    assert_equal mock_constrained, result
  end

  test '#constrain cached' do
    mock_constrained = mock

    @mock_nested.expects(:constrain).never

    @actuator.instance_variable_set(:@constrained, mock_constrained)

    result = @actuator.constrain

    assert_equal mock_constrained, result
  end

  test '#reconstrain' do
    mock_object = mock

    mock_new_nested = mock
    @mock_nested.expects(:reconstrain).with(mock_object).returns(mock_new_nested)

    mock_new_actuator = mock
    Manacle::Constraint::Actuator::Nested.expects(:new).with(mock_new_nested, @mock_constraint).returns(mock_new_actuator)

    result = @actuator.reconstrain(mock_object)

    assert_equal mock_new_actuator, result
  end

  test '#proxy' do
    mock_proxy = mock
    @mock_nested.expects(:proxy).returns(mock_proxy)

    result = @actuator.proxy
    assert_equal mock_proxy, result
  end
end


