'''
Given students = {"Ahmed": 85, "Ali": 55, "Mona": 92, "Sara": 48, "Omar": 70}, 
calculate the average grade of all students and print the result.

'''

students = {"Ahmed": 85, "Ali": 55, "Mona": 92, "Sara": 48, "Omar": 70}

sum = 0

  

for i in students.values():

    sum += i

  

avrg = sum / len(students)

  

print("The average grade of all students is: ", avrg)