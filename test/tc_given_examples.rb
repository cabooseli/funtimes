require 'test/unit'
require './lib/find_subsets'
require './test/utils'

class GivenExamples < Test::Unit::TestCase
    def test_first_example
        input = [5,5,10,15]
        desired_sum = 15
        expected_out = [[0,2],[1,2],[3]]

        TestUtils.check_method_works(input, desired_sum, expected_out, self)
    end

    def test_second_example
        input = [1,2,3,4]
        desired_sum = 6
        expected_out = [[0,1,2],[1,3]]

        TestUtils.check_method_works(input, desired_sum, expected_out, self)
    end
end