# This is free and unencumbered software released into the public domain.

require_relative 'input'
require_relative 'output'

##
# A dataflow block.
class Flux::Theory::Block
  private_class_method :new

  ##
  # Extends subclasses with the ability to define ports.
  #
  # @param [Class] subclass
  def self.inherited(subclass)
    subclass.class_eval do
      public_class_method :new

      def self.new(...)
        # Freeze subclass instances by default:
        super(...) #.freeze # FIXME
      end
    end
  end

  ##
  # Defines a new input port for this block.
  #
  # @param name [Symbol, #to_sym] The name of the port
  # @param type [Class, nil] The message type
  # @param max [Integer, #to_i, nil] The expected message count (maximum)
  # @param min [Integer, #to_i, nil] The expected message count (minimum)
  # @return [Input] the input port
  def self.port_input(name, type: nil, max: nil, min: nil)
    raise ArgumentError, "type must be a Class" unless type.nil? || type.is_a?(Class)
    raise ArgumentError, "max must be a positive integer" unless max.nil? || max.is_a?(Integer) && max > 0
    raise ArgumentError, "min must be a non-negative integer" unless min.nil? || min.is_a?(Integer) && min >= 0
    raise ArgumentError, "min must be less than or equal to max" unless min.nil? || max.nil? || min <= max
    name = name.to_sym
    @port_inputs ||= {}
    port_class = @port_inputs[name]
    if port_class.nil?
      max = max ? max.to_i : nil
      min = min ? min.to_i : nil
      port_class = Class.new(Input) do
        define_method(:initialize) do
          super(name, type:, max:, min:)
        end
        port_spec = [name, type, max, min].compact.map(&:inspect).join(', ')
        self.define_singleton_method(:inspect) do
          "Input(#{port_spec})"
        end
      end
      @port_inputs[name] = port_class
      self.class_eval("def #{name} = @#{name} ||= self.class.port_input(:#{name}).new()")
    end
    port_class
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
    raise ArgumentError, "type must be a Class" unless type.nil? || type.is_a?(Class)
    raise ArgumentError, "max must be a positive integer" unless max.nil? || max.is_a?(Integer) && max > 0
    raise ArgumentError, "min must be a non-negative integer" unless min.nil? || min.is_a?(Integer) && min >= 0
    raise ArgumentError, "min must be less than or equal to max" unless min.nil? || max.nil? || min <= max
    name = name.to_sym
    @port_outputs ||= {}
    port_class = @port_outputs[name]
    if port_class.nil?
      max = max ? max.to_i : nil
      min = min ? min.to_i : nil
      port_class = Class.new(Output) do
        define_method(:initialize) do
          super(name, type:, max:, min:)
        end
        port_spec = [name, type, max, min].compact.map(&:inspect).join(', ')
        self.define_singleton_method(:inspect) do
          "Output(#{port_spec})"
        end
      end
      @port_outputs[name] = port_class
      self.class_eval("def #{name} = @#{name} ||= self.class.port_output(:#{name}).new()")
    end
    port_class
  end

  ##
  # Returns the ports defined for this block.
  #
  # @return [Hash<Symbol, Port>] the ports
  def self.ports = self.port_inputs.dup.merge(self.port_outputs).freeze

  ##
  # Returns the input ports defined for this block.
  #
  # @return [Hash<Symbol, Input>] the input ports
  def self.port_inputs = (@port_inputs ||= {}).dup.freeze

  ##
  # Returns the output ports defined for this block.
  #
  # @return [Hash<Symbol, Output>] the output ports
  def self.port_outputs = (@port_outputs ||= {}).dup.freeze
end # Flux::Theory::Block
