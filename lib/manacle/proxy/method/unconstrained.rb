require 'manacle/proxy/method'

module Manacle
  module Proxy
    module Method
      class Unconstrained
        include Manacle::Proxy::Method
        def bind(proxy)
          proxy.instance_exec(@name) do |name|
            define_method(name) do |*args|
              @constraint.method(name).call(*args)
            end
          end
        end
      end
    end
  end
end
