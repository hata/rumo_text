module RumoText
#
# CTLineBreakMode
# https://developer.apple.com/library/mac/documentation/Carbon/reference/CTParagraphStyleRef/Reference/reference.html
#
  class CTLineBreakMode < TypeHelper
    @word_wrapping = nil
    @char_wrapping = nil
    @clipping = nil
    @truncating_head = nil
    @truncating_tail = nil
    @truncating_middle = nil
    @line_break_modes = nil

    def self.word_wrapping
      @word_wrapping ||= CTLineBreakMode.new(KCTLineBreakByWordWrapping)
    end

    def self.char_wrapping
      @char_wrapping ||= CTLineBreakMode.new(KCTLineBreakByCharWrapping)
    end

    def self.clipping
      @clinpping ||= CTLineBreakMode.new(KCTLineBreakByClipping)
    end

    def self.truncating_head
      @truncating_head ||= CTLineBreakMode.new(KCTLineBreakByTruncatingHead)
    end

    def self.truncating_tail
      @truncating_tail ||= CTLineBreakMode.new(KCTLineBreakByTruncatingTail)
    end

    def self.truncating_middle
      @truncating_middle ||= CTLineBreakMode.new(KCTLineBreakByTruncatingMiddle)
    end

    def self.each
      @line_break_modes ||= [
        word_wrapping,
        char_wrapping,
        clipping,
        truncating_head,
        truncating_tail,
        truncating_middle]
      @line_break_modes.each do |line_break_mode|
        yield line_break_mode
      end
    end

    def to_s
      mode_label = Object.constants.find do |name|
        name =~ /^KCTLineBreakBy/ && Object.const_get(name) == @value
      end
      mode_label.to_s
    end

    def type
      'C'
    end
  end
end
