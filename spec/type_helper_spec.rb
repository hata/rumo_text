describe TypeHelper, "for handling pointer" do
  before do
    @type = TypeHelper.new(1)
  end

  it "has value" do
    @type.value.should.equal 1
  end

  it "has pointer and type and the default impl throws exception to expect subclass implement it." do
    lambda { @type.pointer }.should.raise(RuntimeError)
  end

  it "has size" do
    lambda { @type.size }.should.raise(RuntimeError)
  end
end
