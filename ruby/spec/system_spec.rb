# This is free and unencumbered software released into the public domain.

describe Flux::Theory::System do
  it "binds self when evaluating .new" do
    self_ = nil
    system = System.new do
      self_ = self
    end
    expect(self_).to be system
  end

  describe "#register" do
    it "registers valid blocks" do
      block = Pass.new
      system = System.new do
        register block
      end
      expect(system.blocks).to include(block)
    end

    it "doesn't double register blocks" do
      block = Pass.new
      system = System.new do
        register block
        register block
      end
      expect(system.blocks.size).to eq(1)
    end
  end

  describe "#connect" do
    it "connects valid ports" do
      a, b = Pass.new, Pass.new
      system = System.new do
        register a, b
        connect a.out, b.in
      end
      expect(system.connections.keys).to include([a.out.id, b.in.id])
    end

    it "rejects invalid ports" do
      expect do
        a, b = Pass.new, Pass.new
        system = System.new do
          register a, b
          connect a.in, b.out # the wrong way around
        end
      end.to raise_error(ArgumentError)
    end
  end
end
