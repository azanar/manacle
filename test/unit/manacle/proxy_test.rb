require File.expand_path('../../test_helper', __FILE__)

require 'active_support/duration'
require 'manacle/proxy'

class Manacle::ProxyTest < Test::Unit::TestCase

  def setup
    @mock_constraint = mock

    @mock_constraint.expects(:kind_of?).with(Manacle::Constraint).returns(true)

    proxy_class = Class.new do
      include Manacle::Proxy::InstanceMethods
    end

    @proxy = proxy_class.new(@mock_constraint)
  end

  test "#constrained uncached" do
    mock_constrained = mock
    
    @mock_constraint.expects(:constrain).returns(mock_constrained)

    result = @proxy.constrain

    assert_equal mock_constrained, result
  end

  test "#constrained cached" do
    mock_constrained = mock

    @proxy.instance_variable_set(:@constrained, mock_constrained)

    @mock_constraint.expects(:constrain).never

    result = @proxy.constrain

    assert_equal mock_constrained, result
  end


end
