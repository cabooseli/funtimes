require 'test/unit'
require './lib/find_subsets'
require './test/utils'

class ExtraExamples < Test::Unit::TestCase
    def test_empty_input
        input = []
        desired_sum = 25
        expected_out = []

        TestUtils.check_method_works(input, desired_sum, expected_out, self)
    end

    def test_no_valid_subsets
        input = [3,4,5]
        desired_sum = 1
        expected_out = []

        TestUtils.check_method_works(input, desired_sum, expected_out, self)
    end

    def test_too_big
        input = [1,2,3,4,5,6,7,8]
        desired_sum = 8
        expected_out = [
            [0,1,4],
            [0,2,3],
            [0,6],
            [1,5],
            [7]
        ]

        TestUtils.check_method_works(input, desired_sum, expected_out, self)
    end

    def test_too_tiny
        input = [1,5]
        desired_sum = 6
        expected_out = [[0,1]]
        
        TestUtils.check_method_works(input, desired_sum, expected_out, self)
    end
end