require 'manacle/proxy/template'

module Manacle
  module Proxy
    class Template
      class Factory
        def initialize 
          @proxies = {}
        end

        def build(klass)
          @proxies[klass] ||= Template.cut(klass)
        end
      end
    end
  end
end

