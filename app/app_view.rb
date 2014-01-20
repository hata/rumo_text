include RumoText
#
# AppView
# Top level view to test drawing text.
#
class AppView < UIView
  SAMPLE_TEXT = "January 2nd is not national holiday in U.S. However, it is national holiday in some countries.\nIf it was a national holiday, I would be very happy."

  def drawRect(rect)
    @x = 30
    @y = 0
    @width = 200
    @y_step = 42
    @height = @y_step - 12

    AttrText.class_debug = true
    context = UIGraphicsGetCurrentContext()
    draw_default(context)
    draw_character_shape(context)
    draw_font(context)
    draw_font_name_and_size(context)
    draw_test_size(context)
    draw_test_system_font(context)
    draw_kern(context)
    draw_ligature(context)
    draw_foreground_color(context)
    draw_foreground_color_with_CGColor(context)
    draw_foreground_color_from_context(context)
    draw_paragraph_style(context)
    draw_stroke_width(context)
    draw_stroke_color(context)
    draw_superscript(context)
    draw_underline_color(context)
    draw_underline_style(context)
    draw_vertical_forms(context)
    draw_paragraph_style_first_line_head_indent(context)
    draw_paragraph_style_head_indent(context)
    draw_paragraph_style_tail_indent(context)
    draw_paragraph_style_tab_stops(context)
    draw_paragraph_style_default_tab_interval(context)
    draw_paragraph_style_line_break_mode(context)
    draw_paragraph_style_line_height_multiple(context)
    draw_paragraph_style_maximum_line_height(context)
    draw_paragraph_style_minimum_line_height(context)
    draw_paragraph_style_paragraph_spacing(context)
    draw_paragraph_style_paragraph_spacing_before(context)
    draw_paragraph_style_base_writing_direction(context)
    draw_paragraph_style_maximum_line_spacing(context)
    draw_paragraph_style_minimum_line_spacing(context)
    draw_paragraph_style_line_spacing_adjustment(context)
  end

  def draw_default(context)
    attr_text = AttrText.new
    attr_text.draw(context, create_rect, 'Default text')
  end

  def draw_character_shape(context)
    attr_text = AttrText.new
    attr_text.character_shape = 1
    attr_text.draw(context, create_rect, 'character_shape')
  end

  def draw_font(context)
    attr_text = AttrText.new
    attr_text.font = UIFont.fontWithName('Helvetica-Bold', size: 20)
    attr_text.draw(context, create_rect, 'Helvetica-Bold 20 pt')
  end

  def draw_font_name_and_size(context)
    attr_text = AttrText.new
    attr_text.font_name = 'Georgia'
    attr_text.font_size = 12
    attr_text.draw(context, create_rect, 'Georgia 12 pt')
  end

  def draw_test_size(context)
    attr_text = AttrText.new
    attr_text.font_name = 'GurmukhiMN'
    attr_text.font_size = 20

    [8, 12, 14, 16, 18, 20].each_with_index do |font_size, i|
      attr_text.font_size = font_size
      attr_text.paragraph_style.alignment = CTTextAlignment.center
      attr_text.draw(context, create_rect, "#{font_size} #{attr_text.font_name}")
    end
  end

  def draw_test_system_font(context)
    attr_text = AttrText.new
    attr_text.init_with_system_font
    attr_text.draw(context, create_rect, 'System default font and size')
  end

  def draw_kern(context)
    attr_text = AttrText.new
    [0, 1, 3, 5].each_with_index do |kern, i|
      attr_text.kern = kern
      attr_text.draw(context, create_rect, "kern attribute #{kern}")
    end
  end

  def draw_ligature(context)
    attr_text = AttrText.new
    attr_text.font_name = 'HoeflerText-Regular'
    attr_text.font_size = 20
    [0, 1, 2].each do |ligature|
      attr_text.ligature = ligature
      attr_text.draw(context, create_rect, 'fi and fl')
    end
  end

  def draw_foreground_color(context)
    attr_text = AttrText.new
    attr_text.foreground_color = UIColor.yellowColor
    attr_text.draw(context, create_rect, 'UIColor.yellowColor')
  end

  def draw_foreground_color_with_CGColor(context)
    attr_text = AttrText.new
    attr_text.foreground_color = UIColor.greenColor.CGColor
    attr_text.draw(context, create_rect, 'UIColor.greenColor.CGColor')
  end

  def draw_foreground_color_from_context(context)
    attr_text = AttrText.new
    attr_text.foreground_color_from_context = true
    CGContextSetRGBFillColor(context, 0, 0, 1.0, 1.0)
    attr_text.draw(context, create_rect, 'foreground_color_from_context and it is blue')
  end

  def draw_paragraph_style(context)
    attr_text = AttrText.new
    attr_text.init_with_system_font
    attr_text.paragraph_style.alignment = CTTextAlignment.natural
    attr_text.paragraph_style.first_line_head_indent = 20
    attr_text.paragraph_style.head_indent = 10
    attr_text.paragraph_style.tail_indent = 250
    attr_text.draw(context, create_rect, SAMPLE_TEXT)
  end

  def draw_stroke_width(context)
    attr_text = AttrText.new
    [-3, -1, 0, 1, 3].each do |stroke_width|
      attr_text.stroke_width = stroke_width
      attr_text.draw(context, create_rect, "stroke_width #{stroke_width}")
    end
  end

  def draw_stroke_color(context)
    attr_text = AttrText.new
    # stroke_color looks to be used when stroke_width is set.
    attr_text.stroke_width = 3
    attr_text.stroke_color = UIColor.redColor
    attr_text.draw(context, create_rect, 'stroke_color UIColor.redColor')
    attr_text.stroke_color = UIColor.greenColor.CGColor
    attr_text.draw(context, create_rect, 'stroke_color UIColor.greenColor.CGColor')
  end

  # http://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts
  # I'm not sure it works as expected or not because superscript value may not affect...
  # I used unicode font. So, it is shown. But, the expected behavior is all text
  # show show instead of unicode character.
  def draw_superscript(context)
    attr_text = AttrText.new
    attr_text.init_with_system_font
    u_2070 = '0x2070'.hex.chr(Encoding::UTF_8)
    u_2080 = '0x2080'.hex.chr(Encoding::UTF_8)
    [-1, 0, 1].each do |superscript|
      attr_text.superscript = superscript
      attr_text.draw(context, create_rect, "superscript u2070 #{u_2070} u2080 #{u_2080} #{superscript}")
    end
  end

  def draw_underline_color(context)
    attr_text = AttrText.new
    attr_text.underline_color = UIColor.redColor
    attr_text.underline_style.style_single = true
    attr_text.underline_style.pattern_solid = true
    attr_text.draw(context, create_rect, 'underline solid color:redColor')
  end

  def draw_underline_style(context)
    attr_text = AttrText.new
    attr_text.font = UIFont.fontWithName('Helvetica-Bold', size: 24)
    attr_text.underline_style.style_thick = true
    attr_text.underline_style.pattern_dot = true
    attr_text.draw(context, create_rect, 'underline thick and dot')
    attr_text.underline_style.style_double = true
    attr_text.underline_style.pattern_dash = true
    attr_text.draw(context, create_rect, 'underline double and dash')
    attr_text.underline_style.style_thick = true
    attr_text.underline_style.pattern_dash_dot = true
    attr_text.draw(context, create_rect, 'underline thick and dash_dot')
    attr_text.underline_style.style_single = true
    attr_text.underline_style.pattern_dash_dot_dot = true
    attr_text.draw(context, create_rect, 'underline single and dash_dot_dot')
  end

  def draw_vertical_forms(context)
    # I don't have sample to test it.
  end

  def draw_paragraph_style_first_line_head_indent(context)
    attr_text = AttrText.new
    attr_text.init_with_system_font
    attr_text.paragraph_style.alignment = CTTextAlignment.natural
    [0, 10, 20].each do |indent|
      attr_text.paragraph_style.first_line_head_indent = indent
      attr_text.draw(context, create_rect, "first_line_head_indent is #{indent}." + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_head_indent(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    attr_text.paragraph_style.alignment = CTTextAlignment.natural
    [0, 10, 20].each do |indent|
      attr_text.paragraph_style.head_indent = indent
      attr_text.draw(context, create_rect, "head_indent is #{indent}." + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_tail_indent(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    attr_text.paragraph_style.alignment = CTTextAlignment.natural
    [150, 200, 250].each do |indent|
      attr_text.paragraph_style.tail_indent = indent
      attr_text.draw(context, create_rect, "tail_indent is #{indent}." + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_tab_stops(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    attr_text.paragraph_style.alignment = CTTextAlignment.natural
    [0, 10, 20].each do |location|
      attr_text.paragraph_style.tab_stops = CTTextTab.new(CTTextAlignment.left, location, nil)
      attr_text.draw(context, create_rect, "\ttab_stops is location=#{location}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_default_tab_interval(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    attr_text.paragraph_style.alignment = CTTextAlignment.natural
    [0, 5, 10].each do |interval|
      attr_text.paragraph_style.default_tab_interval = interval
      attr_text.draw(context, create_rect, "\tdefault_tab_interval  is #{interval}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_line_break_mode(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    CTLineBreakMode.each do |line_break_mode|
      attr_text.paragraph_style.line_break_mode = line_break_mode
      attr_text.draw(context, create_rect, "line_break_mode is #{line_break_mode}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_line_height_multiple(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    [0, 0.3, 0.5].each do |height_multiple|
      attr_text.paragraph_style.line_height_multiple = height_multiple
      attr_text.draw(context, create_rect, "line_height_multiple is #{height_multiple}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_maximum_line_height(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    [0, 5, 10].each do |height|
      attr_text.paragraph_style.maximum_line_height = height
      attr_text.draw(context, create_rect, "maximum_line_height is #{height}. " + SAMPLE_TEXT)
    end
  end

  # nothing is changed in this example...
  def draw_paragraph_style_minimum_line_height(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    [0, 5, 10].each do |height|
      attr_text.paragraph_style.minimum_line_height = height
      attr_text.draw(context, create_rect, "minimum_line_height is #{height}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_paragraph_spacing(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 6
    [0, 5, 10].each do |spacing|
      attr_text.paragraph_style.paragraph_spacing = spacing
      attr_text.draw(context, create_rect, "paragraph_spacing.paragraph_spacing is #{spacing}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_paragraph_spacing_before(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 6
    [0, 5, 10].each do |spacing|
      attr_text.paragraph_style.paragraph_spacing_before = spacing
      attr_text.draw(context, create_rect, "paragraph_spacing.paragraph_spacing_before is #{spacing}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_base_writing_direction(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    CTWritingDirection.each do |direction|
      attr_text.paragraph_style.base_writing_direction = direction
      attr_text.draw(context, create_rect, "base_writing_direction is #{direction}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_maximum_line_spacing(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    [0, 1, 2].each do |spacing|
      attr_text.paragraph_style.maximum_line_spacing = spacing
      attr_text.draw(context, create_rect, "maximum_line_spacing is #{spacing}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_minimum_line_spacing(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    [0, 2, 5].each do |spacing|
      attr_text.paragraph_style.minimum_line_spacing = spacing
      attr_text.draw(context, create_rect, "minimum_line_spacing is #{spacing}. " + SAMPLE_TEXT)
    end
  end

  def draw_paragraph_style_line_spacing_adjustment(context)
    attr_text = AttrText.new
    attr_text.font_name = AttrText::SYSTEM_FONT_NAME
    attr_text.font_size = 9
    [0, 2, 5].each do |adjustment|
      attr_text.paragraph_style.line_spacing_adjustment = adjustment
      attr_text.draw(context, create_rect, "line_spacing_adjustment is #{adjustment}. " + SAMPLE_TEXT)
    end
  end

  def create_rect
    @y += @y_step
    CGRectMake(@x, @y, @width, @height)
  end
end
