describe TypeFloat, "for handling CGFloat(float) pointer" do
  before do
    @type = TypeFloat.new(1)
  end

  it "has value" do
    @type.value.should.equal 1
  end

  it "has pointer." do
    @type.pointer.should != nil
  end

  it "has size. I expect 4. But, this may be changed." do
    @type.size.should.equal 4
  end
end
