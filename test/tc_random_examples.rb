require 'test/unit'
require './lib/find_subsets'
require './test/utils'

class RandomExamples < Test::Unit::TestCase
    def test_random_examples
        for i in 1..1000
        # This test assumes that the simple_calculate method is never wrong
        # simple_calculate is just a brute force calculation and i have 100% confidence it works
        # So with randomized inputs simple_calculate will always give the correct output which can be compared to output of calculate
        input = Array.new(rand(0..10)) { rand(-30..30) }
        desired_sum = rand(-50..50)
        obj = FindSubsets.new(input, desired_sum)        
        expected_out = obj.simple_calculate

        TestUtils.check_method_works(input, desired_sum, expected_out, self)
        end
    end
end