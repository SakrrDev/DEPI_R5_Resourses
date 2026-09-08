'''

Ask the user to enter a number N. 
Print the multiplication table of N from 1 to 10, 
but print only the multiplication results that are even. For example,
if N = 5, print 10, 20, 30, 40, and 50.

'''

number = int(input("Enter a number: "))

  

for i in range(1,number + 1):

    print(i * 10)