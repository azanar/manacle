require 'manacle/constraint/actuator'

module Manacle
  module Constraint
    module Actuator
      class Nested 

        include Manacle::Constraint::Actuator

        def initialize(nested, constraint)
          @nested = nested
          @constraint = constraint
        end

        def unconstrain
          @nested.unconstrain
        end

        def reconstrain(obj)
          res = @nested.reconstrain(obj)
          self.class.new(res, @constraint) 
        end

        def proxy
          @nested.proxy
        end

        def levels
          [self.class] + @nested.levels
        end

        def constrain
          @constrained ||= build_constraint
        end

        private

        def build_constraint
          res = @nested.constrain
          @constraint.base_constrain(res)
        end
      end
    end
  end
end
