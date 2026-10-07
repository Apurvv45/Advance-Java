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

function openPopUpBox(rno) {

    var tr = document.getElementById(rno);
    var td = tr.getElementsByTagName("td");

    var srno = td[0].textContent.trim();
    var sname = td[1].textContent.trim();
    var sper = td[2].textContent.trim();

    document.getElementById("modalRno").value = srno;
    document.getElementById("modalName").value = sname;
    document.getElementById("modalPer").value = sper.replace("%", "");

    var modal = new bootstrap.Modal(
        document.getElementById("UpdateModal")
    );

    modal.show();
}


function modify() {

    var trno = document.getElementById("modalRno").value;
    var tname = document.getElementById("modalName").value;
    var tper = document.getElementById("modalPer").value;

    var status = confirm(
        "Do you want to Update the Student with Roll No: " + trno + "?"
    );

    if (status == true) {

        fetch("http://localhost:8080/00_SMS/updatestudent", {

            method: "POST",

            body: new URLSearchParams({
                "rollnum": trno,
                "sname": tname,
                "sper": tper
            })

        })
        .then(response => response.text())
        .then(data => {

            if (data.trim() == "Success") {

                alert("Student Record is Updated Successfully...");
                location.reload();

            } else {

                alert("Record is not Updated.");

            }

        })
        .catch(error => {

            console.error(error);
            alert("Problem While Updating student.");

        });
    }
}

</script>
</head>


<body>

<div class="container" style="margin-top:100px">

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
                action="./updatestudent"
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

                <table
                    class="table table-hover table-bordered mb-0">

                    <thead class="table-dark">

                        <tr>

                            <th class="text-center">
                                Roll Number
                            </th>

                            <th>
                                Name
                            </th>

                            <th class="text-center">
                                Percentage
                            </th>

                            <th class="text-center">
                                Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>

                    <%

                        List<Student> list =
                            (List<Student>) request.getAttribute("Student");

                        if (list != null && !list.isEmpty()) {

                            for (Student s : list) {

                    %>

                        <tr id="<%= s.getRno() %>">

                            <td class="text-center">

                                <%= s.getRno() %>

                            </td>


                            <td>

                                <%= s.getName() %>

                            </td>


                            <td class="text-center">

                                <%= s.getPer() %>%

                            </td>


                            <td class="text-center">

                                <button
                                    type="button"
                                    class="btn btn-primary"
                                    onclick="openPopUpBox(<%=s.getRno()%>)">

                                    Update

                                </button>

                            </td>

                        </tr>


                    <%

                            }

                        } else {

                    %>

                        <tr>

                            <td
                                colspan="4"
                                class="text-center text-muted py-4">

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

<div class="modal" id="UpdateModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Update Student</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>
        <div class="mb-3">
       <label for="exampleFormControlInput1" class="form-label">Roll No.</label>
       <input type="text" class="form-control" id="modalRno" placeholder="Roll no." readonly>
       </div>
       
       <div class="mb-3">
      <label for="exampleFormControlInput1" class="form-label">Student Name</label>
      <input type="text" class="form-control" id="modalName" placeholder="Name">
      </div>

      <div class="mb-3">
      <label for="exampleFormControlInput1" class="form-label">Percentage</label>
      <input type="text" class="form-control" id="modalPer" placeholder="Percentage">
      </div>
        
        
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="modify()">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
