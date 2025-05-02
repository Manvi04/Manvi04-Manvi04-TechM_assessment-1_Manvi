import java.util.Scanner;

class Book {
    private final String title;
    private final String author;
    private final double price;

    // Constructor
    public Book(String title, String author, double price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }

    // Method to display book details
    public void displayBook() {
        System.out.println("Title: " + title + ", Author: " + author + ", Price: " + price);
    }

    // Getter for title
    public String getTitle() {
        return title;
    }
}

// Main class
public class Main {
    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            // Creating an array of 5 books
            Book[] books = new Book[5];

            // Taking input for 5 books
            for (int i = 0; i < 5; i++) {
                System.out.println("Enter details for Book " + (i + 1) + ":");
                System.out.print("Title: ");
                String title = sc.nextLine();
                System.out.print("Author: ");
                String author = sc.nextLine();
                System.out.print("Price: ");
                double price = sc.nextDouble();
                sc.nextLine(); // Consume newline

                books[i] = new Book(title, author, price);
            }

            // Searching for a book by title
            System.out.print("\nEnter title to search: ");
            String searchTitle = sc.nextLine();
            boolean found = false;

            for (Book book : books) {
                if (book.getTitle().equalsIgnoreCase(searchTitle)) {
                    System.out.println("Book Found:");
                    book.displayBook();
                    found = true;
                    break;
                }
            }

            if (!found) {
                System.out.println("Book not found.");
            }
        }
    }
}
