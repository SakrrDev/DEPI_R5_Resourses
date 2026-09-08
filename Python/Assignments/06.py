'''
Given names = ["Ahmed", "Ali", "Mohamed", "Sara", "Omar", "Ibrahim"], 
use a loop to print only the names that contain more than 4 characters.
'''

names = ["Ahmed", "Ali", "Mohamed", "Sara", "Omar", "Ibrahim"]


for i in names:

    if len(i) > 4:

        print(i, end=" ")