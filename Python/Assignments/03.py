'''
Given the list numbers = [10, -5, 0, 20, -8, 15, 0, -2], use a loop and conditions to count
how many numbers are positive,
how many are negative, and how many are equal to zero.
'''

numbers = [10, -5, 0, 20, -8, 15, 0, -2]

pos = 0

neg = 0

zero = 0

for x in numbers:

    if x > 0:

        pos += 1

    elif x < 0:

        neg += 1

    else:

        zero += 1


print("Number of Positive numbers is: ", pos)

print("Number of Nigative numbers is: ", neg)

print("Number of numbers equal zero is: ", zero)