module RumoText
#
# CTTextAlignment
#
  class CTTextAlignment < TypeHelper
    @left = nil
    @right = nil
    @center = nil
    @justified = nil
    @natural = nil

    def self.left
      @left ||= CTTextAlignment.new(KCTLeftTextAlignment)
    end

    def self.right
      @right ||= CTTextAlignment.new(KCTRightTextAlignment)
    end

    def self.center
      @center ||= CTTextAlignment.new(KCTCenterTextAlignment)
    end

    def self.justified
      @justified ||= CTTextAlignment.new(KCTJustifiedTextAlignment)
    end

    def self.natural
      @natural ||= CTTextAlignment.new(KCTNaturalTextAlignment)
    end

    def type
      'C'
    end

    def self.each
      @text_alignments ||= [
        left,
        right,
        center,
        justified,
        natural]
      @text_alignments.each do |alignment|
        yield alignment
      end
    end

    def to_s
      label = Object.constants.find do |name|
        name =~ /^KCT.+TextAlignment/ && Object.const_get(name) == @value
      end
      label.to_s
    end
  end
end
