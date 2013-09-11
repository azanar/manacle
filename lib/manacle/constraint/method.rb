require 'manacle/constraint'

module Manacle
  module Constraint
    module Method
      def self.included(base)
        base.instance_eval do
          include Manacle::Constraint
        end
      end

      def base_constrain(val)
        val.method(constraint).call
      end
    end
  end
end
