require 'manacle/proxy/template'
module Manacle
  module Proxy
    class Factory
      def initialize(constraint)
        @constraint = constraint
        @templates = Manacle::Proxy::Template::Collection.new(@constraint.constrainables)
      end

      def proxyable?(obj)
        @templates.has_key?(obj.class)
      end

      def proxy(obj)
        c = @constraint.new(obj)
        @templates.fetch(obj.class).for(c)
      end
    end
  end
end
