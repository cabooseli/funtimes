require 'test/unit'

class TestUtils < Test::Unit::TestCase
    def self.check_method_works(input, desired_sum, expected_out, instance)
        # initialize object
        obj = FindSubsets.new(input, desired_sum)        
        actual_out = obj.calculate

        # To compare the expected and actual arrays we'll just sort each element and subtract the arrays
        # If it shows up as an empty list then there was no difference in the arrays
        compare =  expected_out.map { |x| x.sort } - actual_out.map { |y| y.sort }

        # Assert and spit out message
        unless compare.empty?
            obj.set_logger_level("debug")
            obj.calculate
        end
        instance.assert(compare.empty?, "Input: #{input.to_s}\nDesired Sum: #{desired_sum.to_s}\nExpected: "\
                                        "#{expected_out.to_s}\nGot: #{actual_out.to_s}\nDifference: #{compare.to_s}")
    end
end