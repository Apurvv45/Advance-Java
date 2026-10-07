# Student Management System

A web-based CRUD application for managing student records, built with **Java Servlets, JSP, JDBC and PostgreSQL**. It follows a simple MVC flow: servlets handle requests and database access, JSP pages render the views, and a `Student` entity carries the data between them.

## Features

- **Add Student**: registration form with server-side validation (empty fields, percentage range 0-100, invalid numbers, duplicate roll number)
- **Display Students**: view all registered students in a table
- **Search**: look up a student by roll number, or refresh to list everyone
- **Update Student**: edit name and percentage in a Bootstrap modal, saved through AJAX (`fetch`) with no full page reload
- **Delete Student**: confirmation prompt, then the row is removed from the table without reloading
- **Responsive UI**: Bootstrap 5 with a slide-out navigation menu shared across pages through a reusable `Header.jsp`

## Tech Stack

| Layer      | Technology                                   |
|------------|----------------------------------------------|
| Language   | Java (JDK 11 or later)                       |
| Backend    | Jakarta Servlets (Tomcat 10+)                |
| Views      | JSP                                          |
| Database   | PostgreSQL (accessed through JDBC)           |
| Frontend   | HTML, Bootstrap 5.3, JavaScript (`fetch` API)|
| Server     | Apache Tomcat 10 or later                    |

> The project uses the `jakarta.servlet` namespace, so it needs **Tomcat 10 or newer**. It will not run on Tomcat 9 or older.

## Project Structure

```
00_SMS/
├── src/main/java/com/tca/student/
│   ├── AddStudentServlet.java        # POST /addstudent
│   ├── DisplayStudentServlet.java    # GET  /displaystudent
│   ├── UpdateStudentServlet.java     # GET + POST /updatestudent
│   ├── DeleteStudent.java            # GET + POST /deletestudent
│   └── entity/
│       └── Student.java              # Entity (rno, name, per)
└── src/main/webapp/
    ├── Header.jsp                    # Shared navbar + offcanvas menu (fragment)
    ├── AddStudent.jsp
    ├── DisplayStudent.jsp
    ├── UpdateStudent.jsp
    └── DeleteStudent.jsp
```

## Request Flow

```
Browser ──► Servlet ──► PostgreSQL
               │
               ▼
        request.setAttribute("Student", list)
               │
               ▼
          JSP (forward) ──► HTML table in the browser
```

## URL Reference

| URL                | Method | Parameters                          | Purpose                          |
|--------------------|--------|-------------------------------------|----------------------------------|
| `/addstudent`      | POST   | `r` (roll no), `n` (name), `p` (%)  | Insert a new student             |
| `/displaystudent`  | GET    | `rno`, `sbtn` (Search / Refresh)    | List or search students          |
| `/updatestudent`   | GET    | `rno`, `sbtn`                       | Load the update page             |
| `/updatestudent`   | POST   | `rollnum`, `sname`, `sper`          | Update a student (AJAX)          |
| `/deletestudent`   | GET    | `rno`, `sbtn`                       | Load the delete page             |
| `/deletestudent`   | POST   | `rollnum`                           | Delete a student (AJAX)          |

> Always open the list pages through the servlet URLs (`/displaystudent`, `/updatestudent`, `/deletestudent`), not the `.jsp` files directly. The servlet loads the data and forwards it to the JSP; opening the JSP directly shows an empty table.

## Getting Started

### Prerequisites

- JDK 11 or later
- Apache Tomcat 10 or later
- PostgreSQL 12 or later
- PostgreSQL JDBC driver (`postgresql-*.jar`) placed in `WEB-INF/lib`
- An IDE such as Eclipse (Dynamic Web Project) or IntelliJ IDEA

### 1. Clone the repository

```bash
git clone https://github.com/Apurvv45/student-management-system.git
cd student-management-system
```

### 2. Set up the database

Create a database and the `student` table:

```sql
CREATE DATABASE ajb22;

\c ajb22

CREATE TABLE student (
    rno  INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    per  DOUBLE PRECISION NOT NULL
);
```

### 3. Configure the database connection

The connection settings are currently defined inside each servlet:

```java
final String DB_URL    = "jdbc:postgresql://localhost/ajb22";
final String DB_USER   = "your_db_user";
final String DB_PWD    = "your_db_password";
final String DB_DRIVER = "org.postgresql.Driver";
```

Update `DB_USER` and `DB_PWD` to match your PostgreSQL setup in `AddStudentServlet`, `DisplayStudentServlet`, `UpdateStudentServlet` and `DeleteStudent`.

> **Do not commit real passwords to GitHub.** See the roadmap below for moving these into a config file.

### 4. Run the application

1. Import the project into your IDE as a Dynamic Web Project.
2. Add Tomcat 10+ as the server and the PostgreSQL JDBC jar to the build path / `WEB-INF/lib`.
3. Run the project on the server.
4. Open [http://localhost:8080/00_SMS/AddStudent.jsp](http://localhost:8080/00_SMS/AddStudent.jsp).

## Screenshots

> Add screenshots here, for example:
>
> - `docs/add-student.png`
> - `docs/display-students.png`
> - `docs/update-modal.png`
> - `docs/delete-confirm.png`

## Known Limitations and Roadmap

This project was built to practice core Java web fundamentals. Planned improvements:

- [ ] Replace string concatenation in the delete query with a `PreparedStatement`
- [ ] Move repeated JDBC code into a `StudentDAO` and a `DBUtil` connection class
- [ ] Load database credentials from a properties file or environment variables
- [ ] Use JSTL / EL and escape output to prevent XSS
- [ ] Use relative URLs and `${pageContext.request.contextPath}` instead of hardcoded `localhost:8080`
- [ ] Add redirect-after-POST on the add form to avoid duplicate submissions on refresh
- [ ] Show proper error messages when a database query fails
- [ ] Add a connection pool
- [ ] Migrate to **Spring Boot + JPA/Hibernate** with REST endpoints
- [ ] Add unit and integration tests

## What I Learned

- Servlet lifecycle and request/response handling
- `doGet` vs `doPost`, and request forwarding with `RequestDispatcher`
- JDBC with PostgreSQL, `PreparedStatement` and resource cleanup
- Passing data from servlet to JSP through request attributes
- Asynchronous UI updates with the `fetch` API
- Reusing JSP fragments with `<%@ include %>`
- Building responsive layouts and modals with Bootstrap 5

## Author

**Apurv Surwase**
Computer Engineering student, Pune
GitHub: [@Apurvv45](https://github.com/Apurvv45)
