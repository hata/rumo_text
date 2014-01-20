describe CTTextAlignment, "for handling CTTextAlignment value for pointer." do
  before do
  end

  it "has CTTextAlignment.left" do
    CTTextAlignment.left.value.should.equal KCTLeftTextAlignment
  end

  it "has CTTextAlignment.right" do
    CTTextAlignment.right.value.should.equal KCTRightTextAlignment
  end

  it "has CTTextAlignment.center" do
    CTTextAlignment.center.value.should.equal KCTCenterTextAlignment
  end 

  it "has CTTextAlignment.justified" do
    CTTextAlignment.justified.value.should.equal KCTJustifiedTextAlignment
  end 

  it "has CTTextAlignment.natural" do
    CTTextAlignment.natural.value.should.equal KCTNaturalTextAlignment
  end 

  it "has CTTextAlignment.each" do
    alignments = []
    CTTextAlignment.each do |alignment|
      alignments << alignment
    end
    alignments.size.should.equal 5
    alignments.include?(CTTextAlignment.left).should.equal true
    alignments.include?(CTTextAlignment.right).should.equal true
    alignments.include?(CTTextAlignment.center).should.equal true
    alignments.include?(CTTextAlignment.justified).should.equal true
    alignments.include?(CTTextAlignment.natural).should.equal true
  end

  it "has to_s" do
    CTTextAlignment.left.to_s.should.equal 'KCTLeftTextAlignment'
    CTTextAlignment.right.to_s.should.equal 'KCTRightTextAlignment'
    CTTextAlignment.center.to_s.should.equal 'KCTCenterTextAlignment'
    CTTextAlignment.justified.to_s.should.equal 'KCTJustifiedTextAlignment'
    CTTextAlignment.natural.to_s.should.equal 'KCTNaturalTextAlignment'
  end
end
