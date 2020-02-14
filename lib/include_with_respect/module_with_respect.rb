# frozen_string_literal: true

# Usage in a class:
#
#   class MyClass
#     include IncludeWithRespect::ModuleWithRespect
#     include SomeOtherConcern
#   end
#
# Usage in a Module:
#
#   module MyModule
#     def self.included(base)
#       base.send(:include, IncludeWithRespect::ModuleWithRespect)
#       base.send(:include, SomeOtherModule)
#     end
#   end
module IncludeWithRespect
  module ModuleWithRespect
    def self.included(base)
      # Rename standard include to include_without_respect
      base.define_singleton_method(:include_without_respect, base.method(:include))
      # Rename standard extend to extend_without_respect
      base.define_singleton_method(:extend_without_respect, base.method(:extend))
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Define a new version of include,
      #   which ultimately calls the original include as include_without_respect
      def include(module1, *smth)
        IncludeWithRespect.include_with_respect(self, module1, *smth)
      end

      # Define a new version of extend,
      #   which ultimately calls the original extend as extend_without_respect
      def extend(module1, *smth)
        IncludeWithRespect.extend_with_respect(self, module1, *smth)
      end
    end
  end
end
