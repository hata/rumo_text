module RumoText
#
# CTWritingDirection
# https://developer.apple.com/library/mac/documentation/Carbon/reference/CTParagraphStyleRef/Reference/reference.html
#
  class CTWritingDirection < TypeHelper
    @natural = nil
    @left_to_right = nil
    @right_to_left = nil
    @writing_directions = nil

    def self.natural
      @natural ||= CTWritingDirection.new(KCTWritingDirectionNatural)
    end

    def self.left_to_right
      @left_to_right ||= CTWritingDirection.new(KCTWritingDirectionLeftToRight)
    end

    def self.right_to_left
      @right_to_left ||= CTWritingDirection.new(KCTWritingDirectionRightToLeft)
    end

    def self.each
      @writing_directions ||= [natural, left_to_right, right_to_left]
      @writing_directions.each do |writing_direction|
        yield writing_direction
      end
    end

    def type
      'c'
    end

    def to_s
      mode_label = Object.constants.find do |name|
        name =~ /^KCTWritingDirection/ && Object.const_get(name) == @value
      end
      mode_label.to_s
    end
  end
end
