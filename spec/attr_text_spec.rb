describe AttrText, "Core Text helper class" do
  before do
    @text = AttrText.new
  end

  it "has character_shape(there is no type information in document. So, use :int here. How can I confirm this ?)" do
    @text.character_shape = 1
    @text.character_shape.should.equal 1
    attrs = @text.attributes
    int_ptr = Pointer.new(:int)
    CFNumberGetValue(attrs[KCTCharacterShapeAttributeName], KCFNumberIntType, int_ptr)
    int_ptr[0].should.equal 1
  end

  it "has font_name to set font_name" do
    @text.font_name.should == nil
    @text.font_name = "new_font_name"
    @text.font_name.should.equal "new_font_name"
  end

  it "has font_size" do
    @text.font_size.should == nil
    @text.font_size = 12
    @text.font_size.should.equal 12
  end

  it "has font=(UIFont) method to set font from UIFont" do
    system_font = UIFont.systemFontOfSize(UIFont.systemFontSize)
    @text.font = system_font
    @text.font_name.should.equal system_font.fontName
    @text.font_size.should.equal system_font.pointSize
  end

  it "has kern for kCTKernAttributeName" do
    @text.kern = 1
    @text.kern.should.equal 1.to_f
    @text.attributes[KCTKernAttributeName].should.equal 1.to_f
  end

  it "has ligature for kCTLigatureAttributeName(HoeflerText-Regular could help to confirm this.)" do
    @text.ligature = 2
    @text.ligature.should.equal 2
    @text.attributes[KCTLigatureAttributeName].should.equal 2
  end

  it "has foreground_color=(UIColor) " do
    @text.foreground_color.should == nil
    @text.foreground_color = UIColor.blackColor
    @text.foreground_color.should.equal UIColor.blackColor.CGColor
    @text.attributes[KCTForegroundColorAttributeName].should.equal UIColor.blackColor.CGColor
  end

  it "has foreground_color=(CGColor) " do
    @text.foreground_color = UIColor.blackColor.CGColor
    @text.foreground_color.should.equal UIColor.blackColor.CGColor
    @text.attributes[KCTForegroundColorAttributeName].should.equal UIColor.blackColor.CGColor
  end

  it "has foreground_color_from_context" do
    @text.foreground_color_from_context = true
    @text.foreground_color_from_context.should.equal true
    @text.attributes[KCTForegroundColorFromContextAttributeName].should.equal KCFBooleanTrue
  end

  it "has stroke_width=(width)" do
    float_ptr = Pointer.new(:float)
    @text.stroke_width.should == nil
    @text.stroke_width = 5
    @text.stroke_width.should.equal 5
    CFNumberIsFloatType(@text.attributes[KCTStrokeWidthAttributeName]).should.equal true
    CFNumberGetValue(@text.attributes[KCTStrokeWidthAttributeName], KCFNumberFloatType, float_ptr)
    float_ptr[0].should.equal 5
  end

  it "has stroke_color=(UIColor)" do
    @text.stroke_color.should == nil
    @text.stroke_color = UIColor.blackColor
    @text.stroke_color.should.equal UIColor.blackColor.CGColor
    @text.attributes[KCTStrokeColorAttributeName].should.equal UIColor.blackColor.CGColor
  end

  it "has stroke_color=(CGColor)" do
    @text.stroke_color = UIColor.blackColor.CGColor
    @text.stroke_color.should.equal UIColor.blackColor.CGColor
    @text.attributes[KCTStrokeColorAttributeName].should.equal UIColor.blackColor.CGColor
  end

  it "has superscript" do
    int_ptr = Pointer.new(:int)
    @text.superscript = -1
    @text.superscript.should.equal -1
    CFNumberGetValue(@text.attributes[KCTSuperscriptAttributeName], KCFNumberIntType, int_ptr)
    int_ptr[0].should.equal -1
  end

  it "has underline_color=(UIColor)" do
    @text.underline_color.should == nil
    @text.underline_color = UIColor.blackColor
    @text.underline_color.should.equal UIColor.blackColor.CGColor
    @text.attributes[KCTUnderlineColorAttributeName].should.equal UIColor.blackColor.CGColor
  end

  it "has underline_color=(CGColor)" do
    @text.underline_color = UIColor.blackColor.CGColor
    @text.underline_color.should.equal UIColor.blackColor.CGColor
    @text.attributes[KCTUnderlineColorAttributeName].should.equal UIColor.blackColor.CGColor
  end


  it "has underline_style attribute reader" do
    @text.underline_style.should != nil
  end

  it "has underline and it manages underline style" do
    @text.underline_style.style_none?.should.equal true
    @text.underline_style.style_single?.should.equal false
    @text.underline_style.style_single = true
    @text.underline_style.style_none?.should.equal false
    @text.underline_style.style_single?.should.equal true
    @text.underline_style.style_thick?.should.equal false
    @text.underline_style.style_thick = true
    @text.underline_style.style_single?.should.equal false
    @text.underline_style.style_thick?.should.equal true
    @text.underline_style.style_double?.should.equal false
    @text.underline_style.style_double = true
    @text.underline_style.style_thick?.should.equal false
    @text.underline_style.style_double?.should.equal true
    @text.underline_style.style_none?.should.equal false
    @text.underline_style.style_none = true
    @text.underline_style.style_double?.should.equal false
    @text.underline_style.style_none?.should.equal true
  end

  it "has underline and it manages underline modifier" do
    @text.underline_style.pattern_solid?.should.equal true
    @text.underline_style.pattern_dot?.should.equal false
    @text.underline_style.pattern_dot = true
    @text.underline_style.pattern_solid?.should.equal false
    @text.underline_style.pattern_dot?.should.equal true
    @text.underline_style.pattern_dash?.should.equal false
    @text.underline_style.pattern_dash = true
    @text.underline_style.pattern_dot?.should.equal false
    @text.underline_style.pattern_dash?.should.equal true
    @text.underline_style.pattern_dash_dot?.should.equal false
    @text.underline_style.pattern_dash_dot = true
    @text.underline_style.pattern_dot?.should.equal false
    @text.underline_style.pattern_dash_dot?.should.equal true
    @text.underline_style.pattern_dash_dot_dot?.should.equal false
    @text.underline_style.pattern_dash_dot_dot = true
    @text.underline_style.pattern_dash_dot?.should.equal false
    @text.underline_style.pattern_dash_dot_dot?.should.equal true
    @text.underline_style.pattern_solid = true
    @text.underline_style.pattern_dash_dot_dot?.should.equal false
    @text.underline_style.pattern_solid?.should.equal true
  end

  it "has underline.clear method" do
    @text.underline_style.pattern_dot = true
    @text.underline_style.style_double = true
    @text.underline_style.pattern_solid?.should.equal false
    @text.underline_style.style_none?.should.equal false
    @text.underline_style.clear
    @text.underline_style.pattern_solid?.should.equal true
    @text.underline_style.style_none?.should.equal true
  end

  it "has underline.attribute method for kCTUnderlineStyleAttributeName" do
    @text.underline_style.pattern_dot = true
    @text.underline_style.style_double = true
    @text.underline_style.attribute.should.equal (KCTUnderlineStyleDouble | KCTUnderlinePatternDot)
    @text.attributes[KCTUnderlineStyleAttributeName].should.equal (KCTUnderlineStyleDouble | KCTUnderlinePatternDot)
  end

  it "has vertical_forms" do
    @text.vertical_forms = true
    @text.vertical_forms.should.equal true
    @text.attributes[KCTVerticalFormsAttributeName].should.equal true
  end

  it "has glyph_info for kCTGlyphInfoAttributeName (This test is just check the value is set as expected.)" do
    # This is dummy
    info = Object.new
    @text.glyph_info = info
    @text.glyph_info.should.equal info
    @text.attributes[KCTGlyphInfoAttributeName].should.equal info
  end

  it "has run_delegate for kCTRunDelegateAttributeName" do
    # This is dummy
    delegate = Object.new
    @text.run_delegate = delegate
    @text.run_delegate.should.equal delegate
    @text.attributes[KCTRunDelegateAttributeName].should.equal delegate
  end

  it "has paragraph_style accessor" do
    @text.paragraph_style.should != nil
  end

  it "has first_line_head_indent" do
    @text.paragraph_style.first_line_head_indent.should == nil
    @text.paragraph_style.first_line_head_indent = 1
    @text.paragraph_style.first_line_head_indent.should.equal 1 
  end

  it "has head_indent" do
    @text.paragraph_style.head_indent.should == nil
    @text.paragraph_style.head_indent = 1
    @text.paragraph_style.head_indent.should.equal 1
  end

  it "has tail_indent" do
    @text.paragraph_style.tail_indent.should == nil
    @text.paragraph_style.tail_indent = 1
    @text.paragraph_style.tail_indent.should.equal 1
  end

  it "has paragraph_style.paragraph_spacing" do
    @text.paragraph_style.paragraph_spacing.should == nil
    @text.paragraph_style.paragraph_spacing = 1
    @text.paragraph_style.paragraph_spacing.should.equal 1
  end

  it "has paragraph_style.minimum_line_height" do
    @text.paragraph_style.minimum_line_height.should == nil
    @text.paragraph_style.minimum_line_height = 2
    @text.paragraph_style.minimum_line_height.should.equal 2
  end

  it "has paragraph_style.maximum_line_height" do
    @text.paragraph_style.maximum_line_height.should == nil
    @text.paragraph_style.maximum_line_height = 2
    @text.paragraph_style.maximum_line_height.should.equal 2
  end

  it "has paragraph_style.minimum_line_spacing" do
    @text.paragraph_style.minimum_line_spacing.should == nil
    @text.paragraph_style.minimum_line_spacing = 3
    @text.paragraph_style.minimum_line_spacing.should.equal 3
  end

  it "has paragraph_style.maximum_line_spacing" do
    @text.paragraph_style.maximum_line_spacing.should == nil
    @text.paragraph_style.maximum_line_spacing = 4
    @text.paragraph_style.maximum_line_spacing.should.equal 4
  end

  it "has paragraph_style.create_ct_paragraph_style to create ParagraphStyle instance." do
    @text.paragraph_style.create_ct_paragraph_style.should == nil
    @text.paragraph_style.maximum_line_spacing = 4
    @text.paragraph_style.create_ct_paragraph_style.should != nil
  end

  it "has paragraph_style.alignment and the default value is nil." do
    @text.paragraph_style.alignment.should == nil
    @text.paragraph_style.create_ct_paragraph_style.should == nil
  end

  it "has paragraph_style.alignment can set CTTextAlignment.left" do
    @text.paragraph_style.alignment = CTTextAlignment.left
    @text.paragraph_style.create_ct_paragraph_style.should != nil
  end

  it "has paragraph_style.alignment can set CTTextAlignment.right" do
    @text.paragraph_style.alignment = CTTextAlignment.right
    @text.paragraph_style.create_ct_paragraph_style.should != nil
  end

  it "has paragraph_style.alignment can set CTTextAlignment.ceter" do
    @text.paragraph_style.alignment = CTTextAlignment.center
    @text.paragraph_style.create_ct_paragraph_style.should != nil
  end

  it "has paragraph_style.alignment can set CTTextAlignment.justified" do
    @text.paragraph_style.alignment = CTTextAlignment.justified
    @text.paragraph_style.create_ct_paragraph_style.should != nil
  end

  it "has paragraph_style.alignment can set CTTextAlignment.natural" do
    @text.paragraph_style.alignment = CTTextAlignment.natural
    @text.paragraph_style.create_ct_paragraph_style.should != nil
  end

  it "has init_with_system_font to reset font to use system default font" do
    @text.init_with_system_font
    @text.font_name.should.equal UIFont.systemFontOfSize(10).fontName
    @text.font_size.should.equal UIFont.systemFontSize
  end

  it "has attributes to use NSAttributedString" do
    @text.font_name = "Helvetica"
    @text.font_size = 10
    attrs = @text.attributes
    ctfont = attrs[KCTFontAttributeName]
    @text.init_with_system_font
    attrs = @text.attributes
    attrs[KCTFontAttributeName].should != ctfont
  end
end
