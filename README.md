# Project Report: Online Book Store Management System

## 1. Executive Summary
The Online Book Store Management System is a robust Java-based web application designed to facilitate seamless book purchasing for customers and efficient inventory management for administrators. Built using the Java Servlet and JSP (JavaServer Pages) framework, the system provides a high-performance, user-friendly platform that operates without a traditional SQL database, instead utilizing a persistent file-based storage system.

## 2. Technical Stack
| Category | Technology |
| :--- | :--- |
| **Backend** | Java 8+, Servlets, JSP |
| **Frontend** | HTML5, CSS3, JavaScript, Bootstrap 5 |
| **Data Storage** | Plain-text File Persistence (Pipe-separated values) |
| **Architecture** | Model-View-Controller (MVC) |
| **UI Components** | Bootstrap Icons, Custom Glassmorphism CSS |
| **Server** | Apache Tomcat 9/10 |

## 3. Core Features & Functionalities

### 👤 Customer Perspective
*   **User Authentication**: Secure registration and login functionality.
*   **Book Catalog**: Browse a wide collection of books with advanced filtering (E-books vs. Printed).
*   **Book Details**: View detailed information including title, author, price, category, and customer reviews.
*   **Shopping Cart**: Add books to a persistent cart that saves even after logout.
*   **Order Management**: Secure checkout process with multiple payment options (Cash on Delivery / Pay Now).
*   **Review System**: Share feedback and ratings for purchased books.
*   **Profile Management**: Update personal details and view order history.

### 🛡️ Administrator Perspective
*   **Unified Dashboard**: A central hub for monitoring system statistics.
*   **Book Inventory Management**: Complete CRUD (Create, Read, Update, Delete) operations for the book catalog.
*   **User/Admin Management**: Ability to manage customer accounts and promote/demote administrators.
*   **Payment Monitoring**: Review transaction histories and payment statuses.
*   **Review Moderation**: Monitor and manage customer reviews to maintain quality.

## 4. System Architecture
The project follows a modular **MVC (Model-View-Controller)** architecture to ensure maintainability and scalability:

*   **Model Layer (`src/main/java/model`)**: Contains POJO (Plain Old Java Objects) classes representing core entities like Book, User, Payment, and Review. It utilizes OOP principles such as inheritance (e.g., EBook and PrintedBook extending the abstract Book class).
*   **Controller Layer (`src/main/java/servlet`)**: Servlets handle incoming HTTP requests, process business logic via services, and route users to the appropriate JSP views.
*   **Service Layer (`src/main/java/service`)**: Encapsulates business logic and abstracts data access. This layer handles the reading/writing of data to the text files.
*   **View Layer (`src/main/webapp`)**: Uses JSP files to render dynamic content to the user, integrated with Bootstrap for responsive design.

## 5. Data Persistence Model
The system uses a custom-built file-based persistence mechanism. Data is stored in the `data/` directory in structured text files:
*   **books.txt**: Stores book inventory metadata.
*   **users.txt / admins.txt**: Stores user credentials and profile data.
*   **cart.txt**: Maintains active shopping cart items per user.
*   **payments.txt**: Logs all successful transaction details.
*   **reviews.txt**: Stores user-submitted book ratings and comments.

## 6. UI/UX Design Philosophy
The application features a modern **"Glassmorphism"** design aesthetic, characterized by:
*   **Translucent Elements**: Using semi-transparent backgrounds with backdrop filters.
*   **Premium Typography**: Clean, modern fonts for readability.
*   **Responsiveness**: Fully adaptive layout that works across desktops, tablets, and mobile devices via Bootstrap 5.
*   **Visual Feedback**: Subtle animations and hover effects to enhance user engagement.

## 7. Future Enhancements
*   **Database Migration**: Transitioning from file-based storage to a relational database like MySQL or PostgreSQL for enterprise-scale data handling.
*   **Search Engine Optimization (SEO)**: Implementation of dynamic meta tags and descriptive URLs.
*   **Advanced Analytics**: A visual reporting tool for admins to track sales trends and popular book categories.
*   **Email Notifications**: Automated order confirmation and password reset emails.

