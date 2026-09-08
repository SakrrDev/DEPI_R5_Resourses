'''
Given the list numbers = [10, 20, 30, 40, 50, 60], first calculate the average of the list.
Then create a new list containing only the numbers that are greater than the calculated average.
'''

numbers = [10, 20, 30, 40, 50, 60]

avrg = sum(numbers) / len(numbers)

  
numbers2 = []


for i in numbers:

    if i > avrg:

        numbers2.append(i)

  

print("Avarage: ", avrg)

print("Numbers are greater than avarage: ", numbers2)