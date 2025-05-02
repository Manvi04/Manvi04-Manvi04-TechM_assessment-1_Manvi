import java.util.Scanner;

class Student {
    private String name;
    private int rollNumber;
    private double marks;

    // Constructor
    public Student(String name, int rollNumber, double marks) {
        this.name = name;
        this.rollNumber = rollNumber;
        this.marks = marks;
    }

    // Method to display student details
    public void displayStudent() {
        System.out.println("Name: " + name + ", Roll Number: " + rollNumber + ", Marks: " + marks);
    }
}

public class StudentInfoSystem {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter the number of students: ");
        int numStudents = sc.nextInt();
        sc.nextLine(); // Consume newline

        // Creating an array of Student objects
        Student[] students = new Student[numStudents];

        // Taking input for multiple students
        for (int i = 0; i < numStudents; i++) {
            System.out.println("\nEnter details for Student " + (i + 1) + ":");
            System.out.print("Name: ");
            String name = sc.nextLine();
            System.out.print("Roll Number: ");
            int rollNumber = sc.nextInt();
            System.out.print("Marks: ");
            double marks = sc.nextDouble();
            sc.nextLine(); // Consume newline

            students[i] = new Student(name, rollNumber, marks);
        }

        // Displaying all student details
        System.out.println("\nStudent Details:");
        for (Student student : students) {
            student.displayStudent();
        }

        sc.close();
    }
}