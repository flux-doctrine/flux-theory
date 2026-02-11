# This is free and unencumbered software released into the public domain.

##
# A dataflow port.
class Flux::Theory::Port
  private_class_method :new

  ##
  # The name of this port.
  #
  # @return [Symbol]
  attr_reader :name

  ##
  # The port's message type, if any.
  #
  # @return [Class] or `nil` for an unspecified type
  attr_reader :type

  ##
  # The port's expected message count maximum.
  #
  # @return [Integer] or `nil` for unlimited message count
  attr_reader :max

  ##
  # The port's expected message count minimum.
  #
  # @return [Integer] or `nil` for unlimited message count
  attr_reader :min

  ##
  # Instantiates a new port.
  #
  # @param name [Symbol, #to_sym] The name of the port
  # @param type [Class, nil] The message type
  # @param max [Integer, #to_i, nil] The expected message count (maximum)
  # @param min [Integer, #to_i, nil] The expected message count (minimum)
  def initialize(name, type: nil, max: nil, min: nil)
    @name = name.to_sym
    @type = type
    @max = max ? max.to_i : nil
    @min = min ? min.to_i : nil
    self.freeze
  end

  ##
  # The port's expected message count range.
  #
  # Note that this is *not* the same as the connection capacity.
  #
  # @return [Range] `min..max`
  def arity = @min..@max

  ##
  # @private
  # @return [Array<Symbol>] The instance variables to inspect
  def instance_variables_to_inspect
    %i[@name @type @max @min].delete_if { |ivar| self.instance_variable_get(ivar).nil? }
  end
end # Flux::Theory::Port
