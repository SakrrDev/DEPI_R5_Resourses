'''

Given list1 = [1, 2, 3, 4] and list2 = [3, 4, 5, 6], 
create a new collection containing all unique numbers from both lists. 
The expected result is {1, 2, 3, 4, 5, 6}.

'''

list1 = [1, 2, 3, 4]

list2 = [3, 4, 5, 6]

  
list3 = list1 + list2
  

list4 = []

  

for i in list3:

    if i not in list4:

        list4.append(i)


print(list4)