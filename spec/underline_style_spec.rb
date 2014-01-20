describe UnderlineStyle, " for underline attribute" do
  before do
    @underline = UnderlineStyle.new
  end

  it "has style_none" do
    @underline.style_none?.should.equal true
    @underline.style_double = true
    @underline.style_none?.should.equal false
    @underline.style_none = true
    @underline.style_none?.should.equal true
    @underline.attribute.should.equal KCTUnderlineStyleNone
  end

  it "has style_single" do
    @underline.style_single?.should.equal false
    @underline.style_single = true
    @underline.style_single?.should.equal true
    @underline.attribute.should.equal KCTUnderlineStyleSingle
  end

  it "has style_thick" do
    @underline.style_thick?.should.equal false
    @underline.style_thick = true
    @underline.style_thick?.should.equal true
    @underline.attribute.should.equal KCTUnderlineStyleThick
  end

  it "has style_double" do
    @underline.style_double?.should.equal false
    @underline.style_double = true
    @underline.style_double?.should.equal true
    @underline.attribute.should.equal KCTUnderlineStyleDouble
  end

  it "has pattern_solid" do
    @underline.pattern_solid?.should.equal true
    @underline.pattern_solid = true
    @underline.pattern_solid?.should.equal true
    @underline.attribute.should.equal KCTUnderlinePatternSolid
  end

  it "has pattern_dot" do
    @underline.pattern_dot?.should.equal false
    @underline.pattern_dot = true
    @underline.pattern_dot?.should.equal true
    @underline.attribute.should.equal KCTUnderlinePatternDot
  end

  it "has pattern_dash" do
    @underline.pattern_dash?.should.equal false
    @underline.pattern_dash = true
    @underline.pattern_dash?.should.equal true
    @underline.attribute.should.equal KCTUnderlinePatternDash
  end

  it "has pattern_dash_dot" do
    @underline.pattern_dash_dot?.should.equal false
    @underline.pattern_dash_dot = true
    @underline.pattern_dash_dot?.should.equal true
    @underline.attribute.should.equal KCTUnderlinePatternDashDot
  end

  it "has pattern_dash_dot_dot" do
    @underline.pattern_dash_dot_dot?.should.equal false
    @underline.pattern_dash_dot_dot = true
    @underline.pattern_dash_dot_dot?.should.equal true
    @underline.attribute.should.equal KCTUnderlinePatternDashDotDot
  end

  it "has attribute" do
    @underline.attribute.should.equal(KCTUnderlineStyleNone | KCTUnderlinePatternSolid)
    @underline.style_single = true
    @underline.pattern_dot = true
    @underline.attribute.should.equal(KCTUnderlineStyleSingle | KCTUnderlinePatternDot)
  end
end

