'''
GAsk the user to enter a sentence. 
Use a loop to count how many vowels (a, e, i, o, u) exist in the sentence.
Treat uppercase and lowercase letters as the same.
'''

Sentence = str(input("Enter a sentence: "))

Number_of_vowels = 0

vowels = "aeiou"

  

Sentence = Sentence.lower()

  

for i in Sentence:

    if i in vowels:

        Number_of_vowels += 1

  

print("The number of the vowels is: ", Number_of_vowels)