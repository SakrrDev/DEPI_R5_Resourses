'''
Given products = {"Laptop": 15000, "Phone": 10000, "Mouse": 500, "Keyboard": 1000}, 
find the product with the highest price and print both its name and price. 
Do not use max() directly on the dictionary.

'''

products = {"Laptop": 15000, "Phone": 10000,"Mouse": 500,"Keyboard": 1000}

highest_product = ""
highest_price = 0

for product, price in products.items():
    if price > highest_price:
        highest_price = price
        highest_product = product

print(highest_product)
print(highest_price)