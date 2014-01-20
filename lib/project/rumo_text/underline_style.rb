module RumoText
#
# CTUnderlineStyle and CTUnderlineStyleModifiers
#
  class UnderlineStyle
    def initialize
      @style = 0
      @modifier = 0
    end

    def style_none=(enabled)
      @style = KCTUnderlineStyleNone if enabled
    end

    def style_none?
      @style == KCTUnderlineStyleNone
    end

    def style_single=(enabled)
      @style = KCTUnderlineStyleSingle if enabled
    end

    def style_single?
      @style == KCTUnderlineStyleSingle
    end

    def style_thick=(enabled)
      @style = KCTUnderlineStyleThick if enabled
    end

    def style_thick?
      @style == KCTUnderlineStyleThick
    end

    def style_double=(enabled)
      @style = KCTUnderlineStyleDouble if enabled
    end

    def style_double?
      @style == KCTUnderlineStyleDouble
    end

    def pattern_solid=(enabled)
      @modifier = KCTUnderlinePatternSolid if enabled
    end

    def pattern_solid?
      @modifier == KCTUnderlinePatternSolid
    end

    def pattern_dot=(enabled)
      @modifier = KCTUnderlinePatternDot if enabled
    end

    def pattern_dot?
      @modifier == KCTUnderlinePatternDot
    end

    def pattern_dash=(enabled)
      @modifier = KCTUnderlinePatternDash if enabled
    end

    def pattern_dash?
      @modifier == KCTUnderlinePatternDash
    end

    def pattern_dash_dot=(enabled)
      @modifier = KCTUnderlinePatternDashDot if enabled
    end

    def pattern_dash_dot?
      @modifier == KCTUnderlinePatternDashDot
    end

    def pattern_dash_dot_dot=(enabled)
      @modifier = KCTUnderlinePatternDashDotDot if enabled
    end

    def pattern_dash_dot_dot?
      @modifier == KCTUnderlinePatternDashDotDot
    end

    def clear
      self.style_none = true
      self.pattern_solid = true
    end

    def attribute
      @style | @modifier
    end
  end
end
