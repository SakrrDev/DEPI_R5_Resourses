'''
Create a function called count_even(numbers). 
The function should receive a list of numbers and return how many even numbers exist in the list. 
Example: count_even([1, 2, 4, 7, 8]) should return 3.
'''

def count_even(numbers):

    count = 0

    for number in numbers:

        if number % 2 == 0:

            count += 1

    return count

  
print(count_even([1, 2, 4, 7, 8]))