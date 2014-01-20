describe ParagraphStyle, " for CTParagraphStyleSpecifier" do
  before do
    @para = ParagraphStyle.new
  end

  it "has create_settings" do
    @para.alignment = CTTextAlignment.center
    @para.first_line_head_indent = 1.0
    @para.head_indent = 2
    @para.tail_indent = 3
    @para.tab_stops = CTTextTab.new
    @para.default_tab_interval = 5
    @para.line_break_mode = CTLineBreakMode.clipping
    @para.line_height_multiple = 7
    @para.maximum_line_height = 8
    @para.minimum_line_height = 9
    @para.paragraph_spacing = 11
    @para.paragraph_spacing_before = 12
    @para.base_writing_direction = CTWritingDirection.left_to_right
    @para.maximum_line_spacing = 14
    @para.minimum_line_spacing = 15
    @para.line_spacing_adjustment = 16

    settings = @para.create_settings
    settings.size.should.equal 16

    settings.each do |item|
      item.should != nil
    end
  end

  it "add_tab_stop" do
   @para.add_tab_stop CTTextTab.new(CTTextAlignment.left, 16)
   @para.add_tab_stop CTTextTab.new(CTTextAlignment.right, 18)
   @para.tab_stops.size.should.equal 2
  end

  it "remove_tab_stop" do
   tab = CTTextTab.new
   @para.add_tab_stop tab
   @para.tab_stops.size.should.equal 1
   @para.remove_tab_stop tab
   @para.tab_stops.size.should.equal 0
  end
end
