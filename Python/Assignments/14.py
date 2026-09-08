'''

Given words = ["cat", "house", "python", "car"], 
create a dictionary where each word is a key and the length of the word is its value. 
The expected result is {"cat": 3, "house": 5, "python": 6, "car": 3}.

'''

words = ["cat", "house", "python", "car"]

freq ={}
  

for i in words:

        if i not in freq:

            freq[i] = len(i)


print(freq)