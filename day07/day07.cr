require "big"

struct BridgeRepair

    @parsed = [] of {key: BigInt, values: Array(BigInt)}

    def initialize(filename : String)
        File.each_line(filename) do |line|
            parts = line.split(':')
            @parsed << {
                key: BigInt.new(parts[0].strip),
                values: parts[1].strip.split.map { |v| BigInt.new(v) }
            }
        end
    end

    private def check_suffix?(a : BigInt, b : BigInt) : Bool
        # number strlen with log base 10
        n = Math.log10(b).to_i + 1
        # returns true if b is a suffix of a -> (a - b) % 10^n 
        (a - b) % BigInt.new((10 ** n)) == 0
    end

    private def check_concat?(a : BigInt, b : Array(BigInt), c : BigInt) : Bool
        # number strlen (ex if c = 6 -> n = 1)
        n = Math.log10(c).to_i + 1

        # get key base (ex if a=156 n=1 -> base=15)
        base = a // (10 ** n)
        is_valid?(base, b, true)
    end

    private def is_valid?(key : BigInt, values : Array(BigInt), check_concat : Bool) : Bool
        *head, tail = values

        # if no more numbers -> tail must be key else flase
        if head.empty?
            return tail == key
        end

        # potential multiplication if tail divides the key evenly
        quotient, rest = key.divmod(tail)
        if rest == 0 && is_valid?(quotient, head, check_concat)
            return true
        end

        # potential concat if the tail is a suffix of the key
        if check_concat && check_suffix?(key, tail)
            # recurse with new concat base
            if check_concat?(key, head, tail)
                return true
            end
        end

        # potential addition
        is_valid?(key - tail, head, check_concat)
    end

    def calibrate(p : Bool = false) : BigInt
        @parsed.sum { |entry| is_valid?(entry[:key], entry[:values], p) ? entry[:key] : BigInt.zero }
    end

end


s = BridgeRepair.new("data.txt")
puts "Part1: ", s.calibrate(false)
puts "Part2: ", s.calibrate(true)

