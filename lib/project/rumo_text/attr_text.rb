module RumoText
#
# AttrText
#
  class AttrText
    LABEL_FONT_SIZE = UIFont.labelFontSize
    BUTTON_FONT_SIZE = UIFont.buttonFontSize
    SMALL_SYSTEM_FONT_SIZE = UIFont.smallSystemFontSize
    SYSTEM_FONT_SIZE = UIFont.systemFontSize

    SYSTEM_FONT_NAME = UIFont.systemFontOfSize(UIFont.systemFontSize).fontName
    BOLD_SYSTEM_FONT_NAME = UIFont.boldSystemFontOfSize(UIFont.systemFontSize).fontName
    ITALIC_SYSTEM_FONT_NAME = UIFont.italicSystemFontOfSize(UIFont.systemFontSize).fontName

    @class_debug = false

    class << self
      attr_accessor :class_debug
    end

    attr_reader :font_name, :font_size, :character_shape, :foreground_color_from_context, :stroke_width, :superscript

    attr_accessor :debug

    def initialize
      @attr_dict = {}
      @underline_style = nil
      @paragraph_style = nil
    end

    def font_name=(font_name)
      clear_cache
      @font_name = font_name
    end

    def font_size=(font_size)
      clear_cache
      @font_size = font_size
    end

    # TODO: This should be change to support options for fonts.
    def font=(font)
      clear_cache
      if font.is_a?(UIFont)
        @font_name = font.fontName
        @font_size = font.pointSize
      else
        fail "Not support font type #{font}"
      end
    end

    def init_with_system_font
      self.font_size = SYSTEM_FONT_SIZE
      self.font_name = SYSTEM_FONT_NAME
    end

    def character_shape=(num)
      @character_shape = num
      @attr_dict[KCTCharacterShapeAttributeName] = to_int_number_ref(num)
    end

    def kern
      @attr_dict[KCTKernAttributeName]
    end

    def kern=(float_value)
      @attr_dict[KCTKernAttributeName] = float_value.to_f
    end

    def ligature
      @attr_dict[KCTLigatureAttributeName]
    end

    def ligature=(number_value)
      @attr_dict[KCTLigatureAttributeName] = number_value
    end

    def foreground_color
      @attr_dict[KCTForegroundColorAttributeName]
    end

    def foreground_color=(color)
      @attr_dict[KCTForegroundColorAttributeName] = to_color(color)
    end

    def foreground_color_from_context=(bool_value)
      @foreground_color_from_context = bool_value
      @attr_dict[KCTForegroundColorFromContextAttributeName] = to_boolean_ref(@foreground_color_from_context)
    end

    def paragraph_style
      clear_cache
      @paragraph_style ||= ParagraphStyle.new
    end

    def stroke_width=(width)
      @stroke_width = width
      @attr_dict[KCTStrokeWidthAttributeName] = to_float_number_ref(width)
    end

    def stroke_color
      @attr_dict[KCTStrokeColorAttributeName]
    end

    def stroke_color=(color)
      @attr_dict[KCTStrokeColorAttributeName] = to_color(color)
    end

    def superscript=(num_value)
      @superscript = num_value
      @attr_dict[KCTSuperscriptAttributeName] = to_int_number_ref(num_value)
    end

    def underline_color
      @attr_dict[KCTUnderlineColorAttributeName]
    end

    def underline_color=(color)
      @attr_dict[KCTUnderlineColorAttributeName] = to_color(color)
    end

    def underline_style
      clear_cache
      @underline_style ||= UnderlineStyle.new
    end

    def vertical_forms
      @attr_dict[KCTVerticalFormsAttributeName]
    end

    def vertical_forms=(bool_value)
      @attr_dict[KCTVerticalFormsAttributeName] = bool_value
    end

    def glyph_info
      @attr_dict[KCTGlyphInfoAttributeName]
    end

    def glyph_info=(ct_glyph_info)
      @attr_dict[KCTGlyphInfoAttributeName] = ct_glyph_info
    end

    def run_delegate
      @attr_dict[KCTRunDelegateAttributeName]
    end

    def run_delegate=(ct_run_delegate)
      @attr_dict[KCTRunDelegateAttributeName] = ct_run_delegate
    end

    def clear_cache
      @reset_attributes = true
    end

    def attributes
      return @attr_dict if @reset_attribute == false
      @reset_attributes = false

      @attr_dict[KCTFontAttributeName] = create_font if @font_name && @font_size
      @attr_dict[KCTUnderlineStyleAttributeName] = @underline_style.attribute if @underline_style

      if @paragraph_style
        para_style = @paragraph_style.create_ct_paragraph_style
        @attr_dict[KCTParagraphStyleAttributeName] = para_style if para_style
      end

      @attr_dict
    end

    def draw(context, rect, text)
      text = text.to_s unless text.is_a?(String)
      attr_str = NSAttributedString.alloc.initWithString(text, attributes: attributes)
      draw_attr_string(context, rect, attr_str)
    end

    private

    # attr_str is NSAttributedString
    def draw_attr_string(context, rect, attr_str)
      framesetter = CTFramesetterCreateWithAttributedString(attr_str)
      frame_path = UIBezierPath.bezierPathWithRect(rect).CGPath
      frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attr_str.length), frame_path, nil)
      draw_ct_frame(context, rect, frame)
    end

    def draw_ct_frame(context, rect, ct_frame)
      CGContextSaveGState(context)
      draw_debug_line(context, rect) if debug_enabled?
      CGContextTranslateCTM(context, 0, rect.origin.y + rect.origin.y + rect.size.height)
      CGContextScaleCTM(context, 1, -1)
      CTFrameDraw(ct_frame, context)
      CGContextRestoreGState(context)
    end

    def draw_debug_line(context, rect)
      margin_x = 5
      margin_y = 5

      debug_start_stop_points(rect, margin_x, margin_y).each do |start_x, start_y, stop_x, stop_y|
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, rect.origin.x + start_x, rect.origin.y + start_y)
        CGContextAddLineToPoint(context, rect.origin.x + stop_x, rect.origin.y + stop_y)
        CGContextClosePath(context)
        CGContextDrawPath(context, KCGPathFillStroke)
      end
    end

    def create_font
      CTFontCreateWithName(@font_name, @font_size, nil)
      # @attr_dict[KCTFontAttributeName] = font
    end

    def to_color(color)
      color.is_a?(UIColor) ? color.CGColor : color
    end

    # https://developer.apple.com/library/mac/documentation/corefoundation/Reference/CFNumberRef/Reference/reference.html
    def to_int_number_ref(num)
      int_ptr = Pointer.new(:int)
      int_ptr[0] = num
      CFNumberCreate(nil, KCFNumberIntType, int_ptr)
    end

    def to_float_number_ref(float_num)
      float_ptr = Pointer.new(:float)
      float_ptr[0] = float_num
      CFNumberCreate(nil, KCFNumberFloatType, float_ptr)
    end

    # https://developer.apple.com/library/mac/documentation/corefoundation/Reference/CFBooleanRef/Reference/reference.html
    def to_boolean_ref(boolean_value)
      boolean_value ? KCFBooleanTrue : KCFBooleanFalse
    end

    def debug_enabled?
      AttrText.class_debug || @debug
    end

    def debug_start_stop_points(rect, margin_x, margin_y)
      [
       [0, - margin_y, 0, rect.size.height + margin_y],
       [rect.size.width, -margin_y, rect.size.width, rect.size.height + margin_y],
       [- margin_x, 0, rect.size.width + margin_x, 0],
       [- margin_x, rect.size.height, rect.size.width + margin_x, rect.size.height]
      ]
    end
  end
end
