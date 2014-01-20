module RumoText
#
# TypeHelper
#
# https://developer.apple.com/library/mac/documentation/cocoa/conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
# ref. https://gist.github.com/jslabovitz/3146276
#
  class TypeHelper
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def pointer
      ptr = Pointer.new(type)
      ptr[0] = @value
      ptr
    end

    def size
      size_ptr = Pointer.new('I')
      align_ptr = Pointer.new('I')
      NSGetSizeAndAlignment(type, size_ptr, align_ptr)
      size_ptr.value
    end

    private

    def type
      fail 'Implement in subclass'
    end
  end
end
