describe CTWritingDirection, "for handling CTWritingDireciton value for pointer." do
  before do
  end

  it "has CTWritingDirection.natural" do
    CTWritingDirection.natural.value.should.equal KCTWritingDirectionNatural
  end

  it "has CTWritingDirection.left_to_right" do
    CTWritingDirection.left_to_right.value.should.equal KCTWritingDirectionLeftToRight
  end

  it "has CTWritingDirection.right_to_left" do
    CTWritingDirection.right_to_left.value.should.equal KCTWritingDirectionRightToLeft
  end 

  it "has each" do
    directions = []
    CTWritingDirection.each do |direction|
      directions << direction
    end
    directions.size.should.equal 3
    directions.include?(CTWritingDirection.natural).should.equal true
    directions.include?(CTWritingDirection.left_to_right).should.equal true
    directions.include?(CTWritingDirection.right_to_left).should.equal true
  end

  it "has to_s" do
    CTWritingDirection.natural.to_s.should.equal 'KCTWritingDirectionNatural'
    CTWritingDirection.left_to_right.to_s.should.equal 'KCTWritingDirectionLeftToRight'
    CTWritingDirection.right_to_left.to_s.should.equal 'KCTWritingDirectionRightToLeft'
  end
end
