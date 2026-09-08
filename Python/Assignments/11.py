'''

Given list1 = [1, 2, 3, 4, 5] and list2 = [3, 4, 5, 6, 7], 
create a new list containing only the numbers that exist in both lists. 
The expected result is [3, 4, 5].

'''

list1 = [1, 2, 3, 4, 5]

list2 = [3, 4, 5, 6, 7]

list3 = []

for i in list1:

    if i in list2:

        list3.append(i)


print(list3)