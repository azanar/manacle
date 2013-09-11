module Manacle
  module Constraint
    module Actuator
      module_function

      def build(subject, constraint)
        if subject.class < Constraint
          Actuator::Nested.new(subject.actuator, constraint)
        else
          Actuator::Base.new(subject, constraint)
        end
      end
    end
  end
end
