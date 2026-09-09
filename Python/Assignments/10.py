'''

Given numbers = [1, 2, 2, 3, 4, 4, 5, 6, 6, 7],
create a new collection that contains each number only once. 
The order does not matter.

'''

numbers = [1, 2, 2, 3, 4, 4, 5, 6, 6, 7]


result = []


for i in numbers:

    if i not in result:

        result.append(i)

  

print(result)