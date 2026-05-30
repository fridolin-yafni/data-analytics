#student record management system

import csv


print("student record management system")

student=[]


def load_data():
    try:
        with open("students.csv", "r") as f:
            reader = csv.DictReader(f)
            for row in reader:
                student.append({
                    "name": row["name"],
                    "roll_number": row["roll_number"],
                    "grade": row["grade"]
                })
    except FileNotFoundError:
        pass

load_data()

def save_data():
    with open("students.csv", "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["name", "roll_number", "grade"])
        for i in student:
            writer.writerow([i["name"], i["roll_number"], i["grade"]])



#create

def add():

    roll_number=input("enter the  roll_number")
    
    for i in student:
        if i["roll_number"]== roll_number:
              print("existing roll_number ")
              return
            
    name=input("enter the name")
    grade=input("enter the grade")
    student.append({"name":name,"roll_number":roll_number,"grade":grade})
    print("new student ",student,"is added sucessfully")
    
    save_data()
    

#read
def display():
    
    if not student:
        print("No records found")
    else:
        for i in student:
            print("Student list is:", i)
    
   
            
def search():
    
    roll_number=input("enter the  roll_number")
    
    for i in student:
        
        if i["roll_number"]== roll_number:
            
            print("student detail is:",i)
            break
    else:
        print("no records found")

#update            
def update():

    roll_number=input("enter the roll_number to update details")
    
    for i in student:
         
        if i["roll_number"]== roll_number:
            i["name"]=input("enter the new name")
            i["grade"]=input("enter the new grade")
            print("updated student roll_number ",roll_number,"detail is",i)
            break
    else:
            print("no records found so , no changes")
    save_data()

#delete
def delete():

    roll_number=input("enter the roll_number to delete ")
    
    for i in student:
         
        if i["roll_number"]== roll_number:
            student.remove(i)
            print("roll_number:",roll_number,"student detail is deleted successfully")
            break
    else:
            print("no records found ")

    save_data()
    
        
while True:
    
    print("choice.1:to add a new student")
    print("choice.2:display a list of all students")
    print("choice.3:search for one specific student")
    print("choice.4:Change the grade or details of an existing student")
    print("choice.5:Remove a student from the system")
    print("choice.6:exit")


    choice=int(input ("enter the choice"))
       
    
    if choice==1:
       add()
     
    elif  choice==2:
       display() 

    elif  choice==3:
       search() 

    elif  choice==4:
       update() 

    elif  choice==5:
       delete()

    elif choice==6:
       print("exiting program.....")
       break
    
    else:
      print("invalid choice")

 ouput:
     student record management system
choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice1
enter the  roll_number1
enter the nameyafni
enter the grade12
new student  [{'name': 'yafni', 'roll_number': '1', 'grade': '12'}] is added sucessfully

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice1
enter the  roll_number1
existing roll_number

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice1
enter the  roll_number2
enter the namechrysa
enter the grade21
new student  [{'name': 'yafni', 'roll_number': '1', 'grade': '12'}, {'name': 'chrysa', 'roll_number': '2', 'grade': '21'}] is added sucessfully

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice2
Student list is: {'name': 'yafni', 'roll_number': '1', 'grade': '12'}
Student list is: {'name': 'chrysa', 'roll_number': '2', 'grade': '21'}

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice3
enter the  roll_number3
no records found

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice2
Student list is: {'name': 'yafni', 'roll_number': '1', 'grade': '12'}
Student list is: {'name': 'chrysa', 'roll_number': '2', 'grade': '21'}

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice3
enter the  roll_number2
student detail is: {'name': 'chrysa', 'roll_number': '2', 'grade': '21'}

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice4
enter the roll_number to update details2
enter the new namefridolin
enter the new grade23
updated student roll_number  2 detail is {'name': 'fridolin', 'roll_number': '2', 'grade': '23'}

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice2
Student list is: {'name': 'yafni', 'roll_number': '1', 'grade': '12'}
Student list is: {'name': 'fridolin', 'roll_number': '2', 'grade': '23'}

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice5
enter the roll_number to delete 2
roll_number: 2 student detail is deleted successfully

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice2
Student list is: {'name': 'yafni', 'roll_number': '1', 'grade': '12'}

choice.1:to add a new student
choice.2:display a list of all students
choice.3:search for one specific student
choice.4:Change the grade or details of an existing student
choice.5:Remove a student from the system
choice.6:exit
enter the choice6
exiting program.....

