'''

Given numbers = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4], 
use a dictionary to count how many times each number appears. 
The expected result is {1: 1, 2: 2, 3: 3, 4: 4}.

'''

numbers = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

freq= {}


for i in numbers:

    if i in freq:

        freq[i] += 1

    else:

        freq[i] = 1


print(freq)