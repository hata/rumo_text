module RumoText
#
# TypeObject
# TypeObject.type returns '@' for Objective-C object.
# This can also use CFArray because it is an object.
#
  class TypeObject < TypeHelper
    def initialize(obj)
      super
    end

    def type
      '@'
    end
  end
end
