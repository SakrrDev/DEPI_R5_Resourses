'''

Given students = {"Ahmed": 85, "Ali": 55, "Mona": 92, "Sara": 48, "Omar": 70}, 
use a loop to print only the students who passed. 
A student passes if the grade is 60 or higher.

'''

students = {"Ahmed": 85, "Ali": 55, "Mona": 92, "Sara": 48, "Omar": 70}

passing_score = 60

  

for name, score in students.items():

    if score >= passing_score:

        print(name, end=" ")