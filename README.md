funtimes
========
Contains two methods:
* simple_calculate: A brute force solution to the problem that attempts every combination. More than sufficient for small array sizes but doesn't scale very well.
* calculate: An approach using dynamic programming.

# Tests
Can use the following command to run all tests.
```
rake test
```
There are currently three different test cases
## Given Examples
Examples that were given.
### First example
total_combinations = calculate_combinations(input=[5, 5, 15, 10], target_sum=15)
```
[2]           => input[2] = 15
[0, 3]       => input[0] = 5, input[3] = 10, sum = 15
[1, 3]       => input[1] = 5, input[3] = 10, sum = 15
```
### Second example
total_combinations = calculate_combinations(input=[1, 2, 3, 4], target_sum=6)
```
[0, 1, 2]
[1, 3]
```
## Extra Examples
Examples that I made up to test the functionality of the method.
## Random Examples
The simple_calculate can reliably get the correct list of subsets even if it isn't very efficient for larger arrays. Utilizing this we can randomly generate several inputs and get a correct expected output for each one. We can then compare this output to the calculate function to test that it works correctly.