require_relative 'code'

class Command
  def initialize(tokens)
    @value = tokens["value"]
    @dest  = tokens["dest"]
    @comp  = tokens["comp"]
    @jump  = tokens["jump"]
  end

  def to_binary
    a_instruction? ? a_instruction_in_binary : c_instruction_in_binary
  end

  private

  def a_instruction?
    !!@value
  end

  def a_instruction_in_binary
    binary = @value.to_i.to_s(2)

    "0" + ("0" * (15 - binary.length)) + binary
  end

  def c_instruction_in_binary
    dest_binary = Code.new(@dest).dest
    comp_binary = Code.new(@comp).comp
    jump_binary = Code.new(@jump).jump

    "111" + comp_binary + dest_binary + jump_binary
  end
end
