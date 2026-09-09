'''
Given numbers = [10, 15, 20, 25, 30, 35, 40], use a loop to calculate two separate sums: 
the sum of all even numbers and the sum of all odd numbers.
'''

numbers = [10, 15, 20, 25, 30, 35, 40]

  
even = 0

odd = 0

  

for i in numbers:

    if i % 2 == 0:

        even += i

    elif i % 2 != 0:

        odd += i

  

print("The sum of even numbers is: ", even)

print("The sum of odd numbers is:", odd)