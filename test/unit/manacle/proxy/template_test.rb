require File.expand_path('../../../test_helper', __FILE__)

require 'manacle/proxy/template'

class Manacle::Proxy::TemplateTest < Test::Unit::TestCase
  class MockClass ; end


  test ".ancestors" do
    mock_klass = MockClass

    mock_instance_methods = 5.times.map {|x|
      "method_#{x}".to_sym
    }

    mock_klass.expects(:instance_methods).returns(mock_instance_methods)

    mock_proxy_klass = Manacle::Proxy::Template.cut(mock_klass)

    mock_proxy_klass.ancestors.include?(MockClass)
  end

  test ".cut" do
    mock_klass = MockClass

    mock_instance_methods = 5.times.map {|x|
      "method_#{x}".to_sym
    }

    mock_instance_methods.each {|m|
      mock_method_obj = mock
      #mock_klass.expects(:instance_method).returns(mock_method_obj)
    }

    mock_klass.expects(:instance_methods).returns(mock_instance_methods)

    mock_proxy_klass = Manacle::Proxy::Template.cut(mock_klass)

    mock_constraint = mock
    mock_constraint.expects(:kind_of?).with(Manacle::Constraint).returns(true)

    mock_proxy_instance = mock_proxy_klass.new(mock_constraint)

    mock_instance_methods.each {|m|
      assert mock_proxy_instance.respond_to?(m), "mock class does not respond to #{m}"
    }
  end
end
