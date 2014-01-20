describe CTLineBreakMode, "for handling CTLineBreakMode value for pointer." do
  before do
  end

  it "has CTLineBreakMode.word_wrapping" do
    CTLineBreakMode.word_wrapping.value.should.equal KCTLineBreakByWordWrapping
  end

  it "has CTLineBreakMode.char_wrapping" do
    CTLineBreakMode.char_wrapping.value.should.equal KCTLineBreakByCharWrapping
  end

  it "has CTLineBreakMode.clipping" do
    CTLineBreakMode.clipping.value.should.equal KCTLineBreakByClipping
  end 

  it "has CTLineBreakMode.truncating_head" do
    CTLineBreakMode.truncating_head.value.should.equal KCTLineBreakByTruncatingHead
  end 

  it "has CTLineBreakMode.truncating_tail" do
    CTLineBreakMode.truncating_tail.value.should.equal KCTLineBreakByTruncatingTail
  end 

  it "has CTLineBreakMode.truncating_middle" do
    CTLineBreakMode.truncating_middle.value.should.equal KCTLineBreakByTruncatingMiddle
  end

  it "has CTLineBreakMode.each(block)" do
    modes = []
    CTLineBreakMode.each do |line_break_mode|
      modes << line_break_mode
    end
    modes.size.should.equal 6
    modes.include?(CTLineBreakMode.word_wrapping).should.equal true
    modes.include?(CTLineBreakMode.char_wrapping).should.equal true
    modes.include?(CTLineBreakMode.clipping).should.equal true
    modes.include?(CTLineBreakMode.truncating_head).should.equal true
    modes.include?(CTLineBreakMode.truncating_tail).should.equal true
    modes.include?(CTLineBreakMode.truncating_middle).should.equal true
  end

  it "has to_s" do
    CTLineBreakMode.word_wrapping.to_s.should.equal 'KCTLineBreakByWordWrapping'
    CTLineBreakMode.char_wrapping.to_s.should.equal 'KCTLineBreakByCharWrapping'
    CTLineBreakMode.clipping.to_s.should.equal 'KCTLineBreakByClipping'
    CTLineBreakMode.truncating_head.to_s.should.equal 'KCTLineBreakByTruncatingHead'
    CTLineBreakMode.truncating_tail.to_s.should.equal 'KCTLineBreakByTruncatingTail'
    CTLineBreakMode.truncating_middle.to_s.should.equal 'KCTLineBreakByTruncatingMiddle'
  end
end
