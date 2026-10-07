
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="Header.jsp" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Student Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body>

<div class="container " style=margin-top:100px>

    <h2 class="text-center">Registration Form</h2>

    <br>

    <form method="POST"
          action="./addstudent"
          style="width: 400px;"
          class="mx-auto">

        <!-- Roll Number -->
        <div class="mb-3">

            <label for="rollNumber" class="form-label">
                Roll Number
            </label>

            <input type="text"
                   name="r"
                   id="rollNumber"
                   class="form-control"
                   placeholder="Enter Roll No"
                   required>

        </div>

        <!-- Name -->
        <div class="mb-3">

            <label for="studentName" class="form-label">
                Name
            </label>

            <input type="text"
                   name="n"
                   id="studentName"
                   class="form-control"
                   placeholder="Enter Name"
                   required>

        </div>

        <!-- Percentage -->
        <div class="mb-3">

            <label for="percentage" class="form-label">
                Percentage
            </label>

            <input type="text"
                   name="p"
                   id="percentage"
                   class="form-control"
                   placeholder="Enter Percentage"
                   required>

        </div>

        <!-- Save Button -->
        <div class="text-center">

            <input type="submit"
                   value="Save"
                   class="btn btn-primary">

        </div>

    </form>

    <!-- Display message -->
   
<%
    String msg = (String) request.getAttribute("m");
    String msgType = (String) request.getAttribute("msgType");

    if (msg != null && !msg.isEmpty()) {
%>

    <div class="alert alert-<%= msgType %> mt-4 text-center"
         role="alert">

        <%= msg %>

    </div>

<%
    }
%>



</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>

