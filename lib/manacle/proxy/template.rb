require 'delegate'

require 'manacle/proxy'
require 'manacle/proxy/method/constrained'
require 'manacle/proxy/method/unconstrained'

module Manacle
  module Proxy
    class Template
      def self.cut(klass)
        Class.new do |k|
          include Manacle::Proxy::InstanceMethods

          define_method(:proxied_klass) do
            klass
          end
          private :proxied_klass

          methods = klass.instance_methods.reject {|m|
            [:inspect, :new, :class].include?(m)
          }.map {|m|
            Method::Constrained.new(m)
          } +
          Manacle::Constraint::InstanceMethods.instance_methods.map {|m|
            Method::Unconstrained.new(m)
          }


          methods.each do |mth|
            mth.bind(self)
          end
        end
      end
    end
  end
end
