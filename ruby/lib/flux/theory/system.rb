# This is free and unencumbered software released into the public domain.

require_relative 'block'

##
# A dataflow system.
class Flux::Theory::System
  ##
  # The system's set of blocks.
  #
  # @return [Array<Block>] The blocks in the system
  attr_reader :blocks

  ##
  # The system's set of connections.
  #
  # @return [Hash<(Output, Input), Integer>] The connections in the system
  attr_reader :connections

  ##
  # Instantiates a new system.
  #
  # @yield []
  def initialize(&block)
    @blocks = []
    @connections = {}
    self.instance_eval(&block) if block_given?
  end

  ##
  # Registers a new block in the system.
  #
  # @param block [Block] The block instance to register
  # @return [System] `self`
  def <<(block)
    self.register(block)
    self
  end

  ##
  # Registers a new block in the system.
  #
  # @param block [Block] The block instance to register
  # @return [Block] the block
  def register(block)
    @blocks << block
    block
  end

  ##
  # Connects two ports in the system.
  #
  # @param source [Output] The source (output) port
  # @param target [Input] The target (input) port
  # @param capacity [Integer, #to_i, nil] The capacity of the connection
  # @return [System] `self`
  def connect(source, target, capacity: nil)
    @connections[[source, target]] = capacity ? capacity.to_i : nil
    self
  end
end # Flux::Theory::System
