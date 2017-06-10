require_relative 'symbol_table'
require_relative 'command'

class Parser
  COMMENT_MATCHER    = /(\/\/).*/
  WHITESPACE_MATCHER = /(\s)+/

  LABEL_MATCHER         = /^\((?<label>[^\d](\w|\.|\$|:)*)\)$/
  A_INST_SYMBOL_MATCHER = /^@(?<symbol>[^\d](\w|\.|\$|:)*)$/

  STARTING_STORAGE_ADDRESS = 16

  MATCHERS = [
    /^@(?<value>\d+)$/,                      # A instruction with numbers
    /^(?<dest>.+)=(?<comp>.+);(?<jump>.+)$/, # C instruction
    /^(?<dest>.+)=(?<comp>[^;]+)$/,          # C instruction without jump
    /^(?<comp>[^=]+);(?<jump>.+)$/           # C instruction without dest
  ]

  def initialize(filename)
    @filename     = filename
    @symbol_table = SymbolTable.new
  end

  def each_binary_instruction
    build_symbol_table # first pass

    # second pass
    storage_address = STARTING_STORAGE_ADDRESS

    valid_lines.reject { |line| line.match(LABEL_MATCHER) }.each do |line|
      symbol = line.match(A_INST_SYMBOL_MATCHER) do |match_data|
        match_data.named_captures["symbol"]
      end

      if symbol
        unless @symbol_table.contains?(symbol)
          @symbol_table.add(symbol, storage_address)
          storage_address = storage_address + 1
        end

        line.sub!(symbol, @symbol_table.get(symbol))
      end

      tokens = tokenize(line)
      command = Command.new(tokens)

      yield command.to_binary
    end
  end

  private

  def build_symbol_table
    line_number = 0

    valid_lines.each do |line|
      label = line.match(LABEL_MATCHER) do |match_data|
        match_data.named_captures["label"]
      end

      if label
        @symbol_table.add(label, line_number) unless @symbol_table.contains?(label)
      else
        line_number = line_number + 1
      end
    end
  end

  def valid_lines
    File.foreach(@filename)
        .lazy
        .map { |line| line.gsub(COMMENT_MATCHER, "") }
        .map { |line| line.gsub(WHITESPACE_MATCHER, "") }
        .reject { |line| line.empty? }
        .to_enum
  end

  def tokenize(line)
    MATCHERS.each do |matcher|
      tokens = line.match(matcher) do |match_data|
        match_data.named_captures
      end

      break tokens if tokens
    end
  end
end
