'''
Ask the user to enter a number N. Use a for loop to print all numbers from 
1 to N that are divisible by 3. For example, if N = 10, the output should be: 3, 6, 9.

'''

numbers = int(input("Enter a number: "))

for x in range(1, numbers + 1):

    if x % 3 == 0:

        print(x)