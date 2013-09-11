module Manacle
  class Proxy
    module InstanceMethods
      def inspect
        "#<Manacle::Proxy::#{self.class} #<Manacle::Constraint::#{@constraint.class} #{@constraint.inspect}>"
      end

      def unproxy
        @constraint
      end

      def constrain
        @constrained ||= @constraint.constrain
      end

      def unconstrain
        @constraint.unconstrain
      end

      def initialize(constraint)
        if constraint.nil?
          raise
        end
        unless constraint.kind_of?(Manacle::Constraint)
          raise
        end
        @constraint = constraint
      end
    end
  end
end
