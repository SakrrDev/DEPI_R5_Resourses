'''
Given numbers = [10, 45, 23, 89, 67, 12, 89, 34], 
find the second largest number in the list without using the sort() function.
'''

numbers = [10, 45, 23, 89, 67, 12, 89, 34]

largest = numbers[0]

second_largest = None

  

for number in numbers:

  

    if number > largest:

        second_largest = largest

        largest = number

  

    elif number != largest:

        if second_largest is None or number > second_largest:

            second_largest = number

  

print("Second largest is:", second_largest)