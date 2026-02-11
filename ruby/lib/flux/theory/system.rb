# This is free and unencumbered software released into the public domain.

require_relative 'block'

##
# A dataflow system.
class Flux::Theory::System
  ##
  # The system's set of instantiated blocks.
  #
  # @return [Array<Block>] The blocks in the system
  attr_reader :blocks

  ##
  # The system's set of connections between ports.
  #
  # @return [Hash<(Output, Input), Integer>] The connections in the system
  attr_reader :connections

  ##
  # The system's set of externally exported ports.
  #
  # @return [Set<Port>]
  attr_reader :exports

  ##
  # Instantiates a new system.
  #
  # @yield []
  def initialize(&block)
    @blocks = []
    @connections = {}
    @exports = Set.new
    self.instance_eval(&block) if block_given?
  end

  ##
  # Registers a new block in the system.
  # This operation is idempotent.
  #
  # @param block [Block] The block instance to register
  # @return [System] `self`
  def <<(block)
    self.register(block)
    self
  end

  ##
  # Registers new blocks in the system.
  # This operation is idempotent.
  #
  # @param blocks [Array<Block>] The block instances to register
  # @return [Block] the first passed block
  def register(*blocks)
    raise ArgumentError, "block must be a Block" unless blocks.all? { it.is_a?(Block) }
    blocks.each do |block|
      @blocks << block unless @blocks.include?(block)
    end
    blocks.first
  end

  ##
  # Connects two ports in the system.
  # This operation is idempotent.
  #
  # @param source [Output] The source (output) port
  # @param target [Input] The target (input) port
  # @param capacity [Integer, #to_i, nil] The capacity of the connection
  # @return [System] `self`
  def connect(source, target, capacity: nil)
    raise ArgumentError, "source must be an Output" unless source.is_a?(Output)
    raise ArgumentError, "target must be an Input" unless target.is_a?(Input)
    #raise ArgumentError, 'source and target must be in the same system' unless source.system == target.system
    @connections[[source.id, target.id]] = capacity ? capacity.to_i : nil
    self
  end

  ##
  # Exports a port from the system.
  # This operation is idempotent.
  #
  # @param port [Port] The port to export
  # @return [System] `self`
  def export(port)
    raise ArgumentError, "port must be a Port" unless port.is_a?(Port)
    @exports << port
    self
  end
end # Flux::Theory::System
