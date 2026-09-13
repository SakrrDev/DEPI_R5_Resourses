'''
Project Outline

1. Display all emp()
2. Search for an employee by SSN()
3. Insert a new employee()
4. Update employee salary by SSN()
5. Delete an employee by SSN()
6. exit()

'''


import  psycopg2 
connection = psycopg2.connect(
    host="localhost",
    database="EMPOLYEE",
    user="sakrdev",
    password="isakrdev26",
    port="5432"
)

cursor = connection.cursor()

def display_all_employees():

    print("Print all employees:")

    cursor.execute("SELECT * FROM EMP")

    employees = cursor.fetchall()

    for employee in employees:
        print(employee)

def search_employee():

    ssn = input("Enter employee SSN: ")

    cursor.execute(
        "SELECT * FROM EMP WHERE SSN = %s",
        (ssn,)
    )

    employee = cursor.fetchone()

    if employee:
        print(employee)
    else:
        print("Employee not found")


def insert_employee():

    ssn = input("Enter SSN: ")
    fname = input("Enter first name: ")
    lname = input("Enter last name: ")
    salary = float(input("Enter salary: "))
    age = int(input("Enter age: "))

    cursor.execute(
        """
        INSERT INTO EMP (SSN, FNAME, LNAME, SALARY, AGE)
        VALUES (%s, %s, %s, %s, %s)
        """,
        (ssn, fname, lname, salary, age)
    )

    connection.commit()

    print("Employee inserted successfully")


def update_employee():

    ssn = input("Enter employee SSN: ")
    salary = float(input("Enter new salary: "))

    cursor.execute(
        """
        UPDATE EMP
        SET SALARY = %s
        WHERE SSN = %s
        """,
        (salary, ssn)
    )

    connection.commit()

    if cursor.rowcount > 0:
        print("Employee updated successfully")
    else:
        print("Employee not found")


def delete_employee():

    ssn = input("Enter employee SSN: ")

    cursor.execute(
        "DELETE FROM EMP WHERE SSN = %s",
        (ssn,)
    )

    connection.commit()

    if cursor.rowcount > 0:
        print("Employee deleted successfully")
    else:
        print("Employee not found")

while True:

    print("\n===== Employee Management System =====")
    print("1. Display all employees")
    print("2. Search employee by SSN")
    print("3. Insert employee")
    print("4. Update employee")
    print("5. Delete employee")
    print("6. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        display_all_employees()

    elif choice == "2":
        search_employee()

    elif choice == "3":
        insert_employee()

    elif choice == "4":
        update_employee()

    elif choice == "5":
        delete_employee()

    elif choice == "6":
        print("Goodbye!")
        break

    else:
        print("Invalid choice. Try again.")

cursor.close()
connection.close()
