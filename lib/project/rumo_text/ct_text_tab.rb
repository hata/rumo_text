module RumoText
#
# CTTextTab
#
  class CTTextTab < TypeHelper
    def initialize(alignment = CTTextAlignment.left, location = 12, options = nil)
      super(CTTextTabCreate(alignment.value, location, options))
    end

    def alignment
      alignment_value = CTTextTabGetAlignment(@value)
      CTTextAlignment.each do |alignment|
        return alignment if alignment.value == alignment_value
      end
      nil
    end

    def location
      CTTextTabGetLocation(@value)
    end

    def options
      CTTextTabGetOptions(@value)
    end

    def type
      '@'
    end
  end
end
