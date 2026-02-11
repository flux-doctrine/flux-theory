# This is free and unencumbered software released into the public domain.

require_relative 'port'

##
# A dataflow output port.
class Flux::Theory::Output < Flux::Theory::Port
  ##
  # Instantiates a new output port.
  #
  # @param name [Symbol, #to_sym] The name of the port
  # @param type [Class, nil] The message type
  # @param max [Integer, #to_i, nil] The expected message count (maximum)
  # @param min [Integer, #to_i, nil] The expected message count (minimum)
  def initialize(name, type: nil, max: nil, min: nil)
    super(self.class.next_id(), name, type:, max:, min:)
  end

  ##
  # Returns a developer-friendly representation of this output port.
  #
  # @return [String]
  def inspect
    spec = [@name, @type, @max, @min].compact.map(&:inspect).join(', ')
    "#<Output(#{spec}):#{@id}>"
  end

  protected

  ##
  # @private
  def self.next_id
    @next_id ||= 0
    @next_id += 1
  end
end # Flux::Theory::Output
