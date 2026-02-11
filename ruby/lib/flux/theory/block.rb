# This is free and unencumbered software released into the public domain.

require_relative 'input'
require_relative 'output'

##
# A dataflow block.
class Flux::Theory::Block
  ##
  # Defines a new input port for this block.
  #
  # @param name [Symbol, #to_sym] The name of the port
  # @param type [Class, nil] The message type
  # @param max [Integer, #to_i, nil] The expected message count (maximum)
  # @param min [Integer, #to_i, nil] The expected message count (minimum)
  # @return [Input] the input port
  def self.port_input(name, type: nil, max: nil, min: nil)
    name = name.to_sym
    port = Input.new(name, type:, max:, min:).freeze
    @inputs ||= {}
    @inputs[name] = port
    self.attr_reader(name)
    port
  end

  ##
  # Defines a new output port for this block.
  #
  # @param name [Symbol, #to_sym] The name of the port
  # @param type [Class, nil] The message type
  # @param max [Integer, #to_i, nil] The expected message count (maximum)
  # @param min [Integer, #to_i, nil] The expected message count (minimum)
  # @return [Output] the output port
  def self.port_output(name, type: nil, max: nil, min: nil)
    name = name.to_sym
    port = Output.new(name, type:, max:, min:).freeze
    @outputs ||= {}
    @outputs[name] = port
    self.attr_reader(name)
    port
  end

  ##
  # Returns the input ports defined for this block.
  #
  # @return [Hash<Symbol, Input>] the input ports
  def self.port_inputs = (@inputs ||= {}).dup.freeze

  ##
  # Returns the output ports defined for this block.
  #
  # @return [Hash<Symbol, Output>] the output ports
  def self.port_outputs = (@outputs ||= {}).dup.freeze
end # Flux::Theory::Block
