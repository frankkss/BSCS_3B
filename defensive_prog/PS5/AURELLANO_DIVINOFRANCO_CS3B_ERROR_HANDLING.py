def get_data():
    """
    Prompts the user to input student names and grades in the format: StudentName: Grade.
    Inputs are stored as tuples in a list.
    
    Returns:
        list of tuples: A list containing tuples of student names and their grades.
    """
    data = []
    print("Enter student grades (format: StudentName: Grade)")
    print("Press Enter twice to finish input")
    print("Press Ctrl+C to exit the program")
    try:
        while True:
            user_input = input()
            if user_input.strip() == '':
                break
            try:
                name, grade = user_input.split(':')
                name = name.strip().capitalize()
                grade = int(grade.strip())
                if not name:
                    print("Input Error: Student name cannot be empty.")
                    continue
                data.append((name, grade))
            except ValueError:
                print("Input Error: Please enter [StudentName: Grade] format.")
    except KeyboardInterrupt:
        print("\nYou pressed [CTRL+C]. Program terminated...")
        raise SystemExit
    
    if not data:
        print("No data entered. Exiting the program.")
        raise SystemExit
    
    return data

def validate_grade(name, grade):
    """
    Checks if the grade input is valid. If the grade is less than 0 or greater than 100,
    an error message will be printed and the program will terminate.
    
    Args:
        name (str): The name of the student.
        grade (int): The grade of the student.
    
    Returns:
        bool: True if the grade is valid, False otherwise.
    """
    if grade < 0 or grade > 100:
        print(f"Error: {name} has an invalid grade {grade}. Exiting the program.")
        raise SystemExit
    return True

def avg(grades):
    """
    Calculates the average of the grades in the list.
    
    Args:
        grades (list of int): The list of grades.
    
    Returns:
        float: The average grade rounded to two decimal places.
    """
    return round(sum(grades) / len(grades), 2) if grades else 0.0

def highest(grades):
    """
    Returns the highest grade in the list.
    
    Args:
        grades (list of int): The list of grades.
    
    Returns:
        int: The highest grade.
    """
    return max(grades)

def lowest(grades):
    """
    Returns the lowest grade in the list.
    
    Args:
        grades (list of int): The list of grades.
    
    Returns:
        int: The lowest grade.
    """
    return min(grades)

def total_students(grades):
    """
    Returns the total number of students in the list.
    
    Args:
        grades (list of int): The list of grades.
    
    Returns:
        int: The total number of students.
    """
    return len(grades)

def passed_students(grades):
    """
    Counts and returns the number of students who passed (grade >= 60).
    
    Args:
        grades (list of int): The list of grades.
    
    Returns:
        int: The number of students who passed.
    """
    return sum(1 for grade in grades if grade >= 60)

def print_grades(data):
    """
    Prints the individual grade of each student in the list.
    
    Args:
        data (list of tuples): The list of student names and grades.
    """
    for name, grade in data:
        status = "PASSED" if grade >= 60 else "FAILED"
        print(f"{name}: {grade:.1f} ({status})")

def main():
    data = get_data()
    grades = [grade for name, grade in data if validate_grade(name, grade)]
                
    print("Results:")
    print("-------------------------------------------------------")

    if grades:
        print(f"Number of Students: {total_students(grades)}")
        print(f"Average Grade: {avg(grades)}")
        print(f"Highest Grade: {highest(grades)}")
        print(f"Lowest Grade: {lowest(grades)}")
        print(f"Number of Passing Students: {passed_students(grades)}")      
        print("Individual Grades:")
        print("-------------------------------------------------------")
        print_grades(data)
            
if __name__ == "__main__":
    main()
