<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tca.student.entity.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student List</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body { padding-top: 70px; }   /* space for the fixed navbar */
    </style>
</head>

<body>

<%@ include file="Header.jsp" %>

<div class="container mt-4">

    <!-- Page heading -->
    <div class="text-center mb-4">
        <h2 class="fw-bold">Student Management System</h2>
        <p class="text-muted">View and search registered students</p>
    </div>

    <!-- Search card -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form method="GET" action="./displaystudent"
                  class="row justify-content-center g-2">

                <div class="col-md-5">
                    <input type="text" name="rno" class="form-control"
                           placeholder="Enter Roll Number">
                </div>

                <div class="col-auto">
                    <button type="submit" name="sbtn" value="Search"
                            class="btn btn-primary">Search</button>
                </div>

                <div class="col-auto">
                    <button type="submit" name="sbtn" value="Refresh"
                            class="btn btn-secondary">Refresh</button>
                </div>

            </form>
        </div>
    </div>

    <!-- Student table -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Registered Students</h5>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-bordered mb-0">

                    <thead class="table-dark">
                        <tr>
                            <th class="text-center">Roll Number</th>
                            <th>Name</th>
                            <th class="text-center">Percentage</th>
                        </tr>
                    </thead>

                    <tbody>
                    <%
                        List<Student> list = (List<Student>) request.getAttribute("Student");

                        if (list != null && !list.isEmpty()) {
                            for (Student s : list) {
                    %>
                        <tr>
                            <td class="text-center"><%= s.getRno() %></td>
                            <td><%= s.getName() %></td>
                            <td class="text-center"><%= s.getPer() %>%</td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="3" class="text-center text-muted py-4">
                                No students found.
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>

                </table>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
