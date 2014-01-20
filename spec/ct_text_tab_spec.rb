describe CTTextTab, "for a wrapper class of CTTextTabRef" do
  before do
    @type = CTTextTab.new(CTTextAlignment.left, 12)
  end

  it "has value" do
    @type.value.should != nil
  end

  it "has pointer." do
    @type.pointer.should != nil
  end

  it "has size. I expect 4. But, this may be changed. I think this depends on platform." do
    @type.size.should.equal 4
  end

  it "has alignment to call GetTextTabGetAlignment function." do
    @type.alignment.should.equal CTTextAlignment.left
  end

  it "has location to call GetTextTabGetLocation function." do
    @type.location.should.equal 12
  end

  it "has options to call GetTextTabGetOptions function." do
    @type.options.should == nil
  end
end
