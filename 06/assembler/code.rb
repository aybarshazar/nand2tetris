class Code
  DEST_MAP = Hash.new("000").tap do |h|
    h["M"]   = "001"
    h["D"]   = "010"
    h["MD"]  = "011"
    h["A"]   = "100"
    h["AM"]  = "101"
    h["AD"]  = "110"
    h["AMD"] = "111"
  end

  COMP_MAP = {
    "0"   => "0101010",
    "1"   => "0111111",
    "-1"  => "0111010",
    "D"   => "0001100",
    "A"   => "0110000",
    "M"   => "1110000",
    "!D"  => "0001101",
    "!A"  => "0110001",
    "!M"  => "1110001",
    "-D"  => "0001111",
    "-A"  => "0110011",
    "-M"  => "1110011",
    "D+1" => "0011111",
    "A+1" => "0110111",
    "M+1" => "1110111",
    "D-1" => "0001110",
    "A-1" => "0110010",
    "M-1" => "1110010",
    "D+A" => "0000010",
    "D+M" => "1000010",
    "D-A" => "0010011",
    "D-M" => "1010011",
    "A-D" => "0000111",
    "M-D" => "1000111",
    "D&A" => "0000000",
    "D&M" => "1000000",
    "D|A" => "0010101",
    "D|M" => "1010101"
  }

  JUMP_MAP = Hash.new("000").tap do |h|
    h["JGT"] = "001"
    h["JEQ"] = "010"
    h["JGE"] = "011"
    h["JLT"] = "100"
    h["JNE"] = "101"
    h["JLE"] = "110"
    h["JMP"] = "111"
  end

  def initialize(mnemonic)
    @mnemonic = mnemonic
  end

  def dest
    DEST_MAP[@mnemonic]
  end

  def comp
    COMP_MAP[@mnemonic]
  end

  def jump
    JUMP_MAP[@mnemonic]
  end
end
