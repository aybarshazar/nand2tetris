require_relative 'parser'

class Assembler
  def initialize(input_filename)
    @output_filename = input_filename.sub(".asm", ".hack")
    @parser = Parser.new(input_filename)
  end

  def translate
    File.open(@output_filename, "w") do |file|
      @parser.each_binary_instruction do |binary_instruction|
        file.puts(binary_instruction)
      end
    end
  end
end

filename = ARGV[0]

assembler = Assembler.new(filename)
assembler.translate
