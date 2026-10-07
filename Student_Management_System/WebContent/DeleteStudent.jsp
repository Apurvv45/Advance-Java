<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tca.student.entity.Student" %>
<%@ include file="Header.jsp" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student List</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <script>

        function del(drno) {

            // Ask for confirmation
            var status = confirm(
                "Do you want to delete the Student with Roll No: " + drno + "?"
            );

            if (status == true) {

                fetch(
                    "http://localhost:8080/00_SMS/deletestudent",
                    {
                        method: "POST",

                        body: new URLSearchParams({
                            "rollnum": drno
                        })
                    }
                )

                .then(response => response.text())

                .then(data => {

                    if (data.trim() == "Success") {

                        // Find the table row using roll number
                        var row = document.getElementById(drno);

                        // Remove the row from the page
                        if (row) {
                            row.remove();
                        }

                        alert(
                            "Student Record is deleted Successfully..."
                        );
                    }

                    else if (data.trim() == "Failure") {

                        alert(
                            "Record is not deleted."
                        );
                    }

                })

                .catch(error => {

                    console.error(error);

                    alert(
                        "Problem While deleting student."
                    );

                });
            }
        }

    </script>

</head>


<body>

<div class="container mt-5">

    <!-- Page Heading -->

    <div class="text-center mb-4">

        <h2 class="fw-bold">
            Student Management System
        </h2>

        <p class="text-muted">
            View and search registered students
        </p>

    </div>


    <!-- Search Card -->

    <div class="card shadow-sm mb-4">

        <div class="card-body">

            <form
                method="GET"
                action="./deletestudent"
                class="row justify-content-center g-2">

                <div class="col-md-5">

                    <input
                        type="text"
                        name="rno"
                        class="form-control"
                        placeholder="Enter Roll Number">

                </div>


                <div class="col-auto">

                    <button
                        type="submit"
                        name="sbtn"
                        value="Search"
                        class="btn btn-primary">

                        Search

                    </button>

                </div>


                <div class="col-auto">

                    <button
                        type="submit"
                        name="sbtn"
                        value="Refresh"
                        class="btn btn-secondary">

                        Refresh

                    </button>

                </div>

            </form>

        </div>

    </div>


    <!-- Student Table -->

    <div class="card shadow-sm">

        <div class="card-header bg-primary text-white">

            <h5 class="mb-0">
                Registered Students
            </h5>

        </div>


        <div class="card-body p-0">

            <div class="table-responsive">

                <table class="table table-bordered table-striped text-center">

    <thead class="table-dark">
        <tr>
            <th>Roll No</th>
            <th>Name</th>
            <th>Percentage</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody>
        <%
        List<Student> slist = (List<Student>) request.getAttribute("Student");

        if (slist != null) {
            for (Student s : slist) {
        %>

        <tr id="<%= s.getRno() %>">
            <td><%= s.getRno() %></td>
            <td><%= s.getName() %></td>
            <td><%= s.getPer() %>%</td>

            <td>
               
                <button type="button"
                        class="btn btn-danger"
                        onclick="del(<%= s.getRno() %>)">
                    Delete
                </button>
            </td>
        </tr>

        <%
            }
        }
        %>
    </tbody>

</table>

            </div>

        </div>

    </div>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
