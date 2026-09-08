'''
Ask the user to enter 5 numbers.
Store the numbers in a list. After that, calculate and print the total sum,
the average, the largest number, and the smallest number.

'''

numbers = []

  

for x in range(5):

    x = float(input("Enter a number: "))
    numbers.append(x)

  

Sum = sum(numbers)

Avarage = Sum / len(numbers)

  

mx = max(numbers)

mn = min(numbers)

  

print("Total: ", Sum)

print("Avarage: ", Avarage)

print("Max Number: ", mx)

print("Min Number: ", mn)