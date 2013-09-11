require 'manacle/constraint/actuator'

require 'manacle/proxy/templates'

module Manacle
  # Include this, and magically each of your decorators will get a time
  # attached, as well as delegation to all the modules contained therein.
  #
  # You can then override the parts of Time you want to change.
  module Constraint
    module Actuator
      class Base

        include Manacle::Constraint::Actuator

        def initialize(val, constraint)
          if val.kind_of?(self.class)
            raise 
          end
          @val = val
          @constraint = constraint
        end

        def unconstrain
          @val
        end

        def levels
          [self.class, @val.class]
        end

        def proxy
          Manacle::Proxy::Templates.for(@val)
        end

        def reconstrain(obj)
          self.class.new(obj, @constraint)
        end

        def constrain
          @constrained ||= @constraint.base_constrain(@val)
        end
      end
    end
  end
end
