require 'logger'

class FindSubsets
    @num_list
    @desired_sum
    
    # Sum cache stores all subsets for a given sum
    # Key represents a sum
    # Value represents all subsets that add up to that sum
    # Ex. {"10" => [[0],[1,2]], "15" =>[[0],[0,1],[0,2],[3]] }
    @sum_cache
    @logger

    def initialize(num_list, desired_sum)
        @num_list = num_list
        @desired_sum = desired_sum
        @sum_cache = {}
        @logger = Logger.new(STDOUT)
        @logger.level = Logger::INFO
    end

    def set_logger_level(level)
        case level
        when "info"
            @logger.level = Logger::INFO
        when "debug"
            @logger.level = Logger::DEBUG
        end
    end

    def simple_calculate
        # Attempt all possible combinations and return only those that add up to the desired sum

        # Get all possible combinations by index
        index_combos = []
        index_list = []

        index_list = Array.new(@num_list.size) { |i| i }
        for i in 1..@num_list.size do
            index_combos += index_list.combination(i).to_a
        end

        # Return all combos that add up to the desired sum
        index_combos.select do |combo|
            combo_sum = 0
            combo.each do |ind|
                combo_sum += @num_list[ind]
            end
            combo_sum == @desired_sum
        end
    end

    def calculate
        # Taking a bottom up approach
        # Start from 0
        for j in 0..@num_list.size do
            @sum_cache[j.to_s] = {}
            for i in 0..@desired_sum
                @sum_cache[j.to_s][i.to_s] = nil
            end
        end
        @sum_cache['0']['0'] = []

        for i in 1..@num_list.size do
            # Iterate through all sums leading up to the desired sum
            @logger.debug("----------------------------\n")
            @logger.debug("Current number is #{@num_list[i-1]}\n")
            for current_sum in 0..@desired_sum do
                # Grab any sets that were set in the previous iteration
                # These represent sums that have already been found we just need to persist them
                @sum_cache[i.to_s][current_sum.to_s] = @sum_cache[(i-1).to_s][current_sum.to_s]
                @logger.debug("A set was found from the previous iteration for current sum:"\
                     "#{@sum_cache[i.to_s][current_sum.to_s].to_s}\n") unless @sum_cache[i.to_s][current_sum.to_s].nil?

                # Can we can populate the current sum with a set that includes the current index number?
                # We just need to check if there is a set for current_sum - current_number
                current_number = @num_list[i-1]
                difference = current_sum - current_number
                unless difference < 0
                    @logger.debug("Looking for set for difference #{difference.to_s} from previous iteration")
                    previous_sum_set = @sum_cache[(i-1).to_s][difference.to_s]
                    unless previous_sum_set.nil?
                        @logger.debug("Set for #{difference.to_s} was found: #{previous_sum_set.to_s}")
                        # A set has been found! Append index to the end of every set
                        # This represents adding this number to every set there to get the current sum
                        @sum_cache[i.to_s][current_sum.to_s] ||= []
                        new_sum_set = []

                        if previous_sum_set.empty? # If set is empty which usually happens with 0
                            new_sum_set << [i-1]
                        else
                            # Copy the set of the difference
                            # Gotta do deep copy or we just get the reference to the objects and we end up modifying it
                            new_sum_set += _deep_copy(previous_sum_set)
                            # Add current number to the difference to achieve the current sum
                            new_sum_set.each { |x| x << i - 1 }
                        end
                        @logger.debug("New set #{new_sum_set.to_s} for current sum #{current_sum.to_s}")
                        # Now add that new set to the current sums set
                        @sum_cache[i.to_s][current_sum.to_s] += new_sum_set
                        @logger.debug("Final set for current sum #{current_sum.to_s}: #{@sum_cache[i.to_s][current_sum.to_s].to_s}")
                    end
                end
            end
        end
        if @sum_cache[(@num_list.size).to_s][@desired_sum.to_s].nil?
            return []
        else
            return @sum_cache[(@num_list.size).to_s][@desired_sum.to_s]
        end
    end

    def _deep_copy(obj)
        # To help with copying some values around :S
        Marshal.load(Marshal.dump(obj))
    end
end