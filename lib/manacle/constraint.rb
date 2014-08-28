require 'manacle/constraint/actuator/base'
require 'manacle/constraint/actuator/nested'

module Manacle
  module Constraint
    module InstanceMethods

      def initialize(obj)
        if obj.nil?
          raise
        end

        if obj.class < Manacle::Proxy
          raise
        end

        @actuator = if obj.class < Actuator
                      obj
                    else
                      Actuator.build(obj, self)
                    end
      end

      attr_reader :actuator

      def constrainables
        self.class.constrainables
      end

      def reconstrain(obj)
        r = @actuator.reconstrain(obj)
        self.class.new(r)
      end

      def unconstrain
        @actuator.unconstrain
      end

      def constrain
        @actuator.constrain
      end

      def proxy
        proxy_class = @actuator.proxy
        unless proxy_class.kind_of?(Class)
          raise "#{@actuator.inspect} is proxying non-classes: #{self.levels}"
        end
        proxy_class.new(self)
      end

      def klass
        @actuator.constrain.class
      end

      def levels
        ["CONSTRAINT #{constraint}"] + @actuator.levels
      end
    end

    module ClassMethods
      def constrain(klass)
        self.new(klass).proxy
      end
    end

    def self.included(base)
      base.instance_exec do
        include InstanceMethods
        extend ClassMethods
      end
    end
  end
end
