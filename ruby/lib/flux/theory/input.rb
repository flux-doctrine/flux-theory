# This is free and unencumbered software released into the public domain.

require_relative 'port'

##
# A dataflow input port.
class Flux::Theory::Input < Flux::Theory::Port
  ##
  # Instantiates a new input port.
  #
  # @param name [Symbol, #to_sym] The name of the port
  # @param type [Class, nil] The message type
  # @param max [Integer, #to_i, nil] The expected message count (maximum)
  # @param min [Integer, #to_i, nil] The expected message count (minimum)
  def initialize(name, type: nil, max: nil, min: nil)
    super(self.class.next_id(), name, type:, max:, min:)
  end

  ##
  # Returns a developer-friendly representation of this input port.
  #
  # @return [String]
  def inspect
    spec = [@name, @type, @max, @min].compact.map(&:inspect).join(', ')
    "#<Input(#{spec}):#{@id}>"
  end

  protected

  ##
  # @private
  def self.next_id
    @next_id ||= 0
    @next_id -= 1
  end
end # Flux::Theory::Input
