require 'manacle/proxy/method'

module Manacle
  class Proxy
    module Method
      class Constrained
        class Postprocessor
          def initialize(proxy)
            @constraint = proxy.unproxy
          end

          def process(result)
            if @constraint.constrainables.include?(result.class)
              @constraint.reconstrain(result).proxy
            else
              result
            end
          end
        end

        include Manacle::Proxy::Method

        def bind(proxy)
          proxy.instance_exec(@name) do |name|
            define_method(name) do |*args|
              postprocessor = Postprocessor.new(self)
              res = constrain.method(name).call(*args)
              postprocessor.process(res)
            end
          end
        end
      end
    end
  end
end
