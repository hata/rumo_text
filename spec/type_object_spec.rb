describe TypeObject, "for handling Objective-C Object pointer" do
  before do
    @obj = []
    @type = TypeObject.new(@obj)
  end

  it "has value" do
    @type.value.should.equal @obj
  end

  it "has pointer." do
    @type.pointer.should != nil
  end

  it "has size. I expect 4. But, this may be changed. I think this depends on platform." do
    @type.size.should.equal 4
  end
end
