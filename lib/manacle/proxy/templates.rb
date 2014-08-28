require 'punchout/fabricable'
require 'punchout/puncher'
require 'punchout/puncher/matchable'
require 'punchout/matcher/class'
require 'manacle/proxy/template/factory'

module Manacle
  module Proxy
    module Templates
      class Factory
        def initialize
          @factory = Manacle::Proxy::Template::Factory.new
        end

        def build(obj)
          matcher = Punchout::Matcher::Klass.new(obj.class)
          built = @factory.build(obj)

          Punchout::Puncher::Matchable.new(matcher, built)
        end
      end

      extend Punchout::Fabricable

      module_function

      def factory
        @factory ||= Factory.new
      end

      def for(obj)
        res = puncher.punch(obj.class)
        unless res.kind_of?(Class)
          raise
        end
        res
      end
    end
  end
end
