require "big"

struct BridgeRepair

    @parsed = [] of {key: BigInt, values: Array(BigInt)}
    @memo = {} of Tuple(BigInt, Array(BigInt)) => Bool

    def initialize(filename : String)
        File.each_line(filename) do |line|
            parts = line.split(':')
            @parsed << {
                key: BigInt.new(parts[0].strip), 
                values: parts[1].strip.split.map { |v| BigInt.new(v) }
            }
        end
    end

    private def is_valid(key : BigInt, values : Array(BigInt)) : Bool
        return @memo[{key, values}] if @memo.has_key?({key, values})

        *head, tail = values
        valid : Bool = if head.empty?
            tail == key
        else
            quotient, rest = key.divmod(tail)
            rest == 0 && is_valid(quotient, head) || is_valid(key - tail, head)
        end

        @memo[{key, values}] = valid
        valid
    end

    def calibrate : BigInt
        @parsed.sum { |e| is_valid(e[:key], e[:values]) ? e[:key] : BigInt.zero }
    end
end

s = BridgeRepair.new("data.txt")
puts s.calibrate

