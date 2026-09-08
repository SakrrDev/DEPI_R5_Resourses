'''
Create a function called average_above_50(numbers). 
The function should receive a list of numbers, 
calculate the average of only the numbers greater than 50, and return the result. 
Example: average_above_50([20, 60, 80, 40, 100]) should return 80.
'''

def average_above(numbers):

    above = []


    for number in numbers:

        if number > 50:

            above.append(number)

    if len(above) == 0:

        return 0


    return sum(above) / len(above)

  
  

print(average_above([20, 60, 80, 40, 100]))