<!-- Top navbar -->
<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">Student Management System</a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="offcanvas"
                data-bs-target="#offcanvasMenu"
                aria-controls="offcanvasMenu"
                aria-label="Toggle menu">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>

<!-- Side menu (offcanvas) -->
<div class="offcanvas offcanvas-end text-bg-dark" tabindex="-1"
     id="offcanvasMenu" aria-labelledby="offcanvasMenuLabel">

    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasMenuLabel">Student Management</h5>
        <button type="button" class="btn-close btn-close-white"
                data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>

    <div class="offcanvas-body">
        <ul class="navbar-nav">

            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/00_SMS/AddStudent.jsp">Home</a>
            </li>

            <!-- Student menu (collapse instead of dropdown) -->
            <li class="nav-item">
                <a class="nav-link d-flex justify-content-between align-items-center"
                   data-bs-toggle="collapse" href="#studentMenu" role="button"
                   aria-expanded="false" aria-controls="studentMenu">
                    Student <span>&#9662;</span>
                </a>

                <div class="collapse" id="studentMenu">
                    <ul class="navbar-nav ps-3">
                        <li><a class="nav-link" href="http://localhost:8080/00_SMS/AddStudent.jsp">Add Student</a></li>
                        <li><a class="nav-link" href="http://localhost:8080/00_SMS/DisplayStudent.jsp">Display Student</a></li>
                        <li><a class="nav-link" href="http://localhost:8080/00_SMS/DeleteStudent.jsp">Delete Student</a></li>
                        <li><a class="nav-link" href="http://localhost:8080/00_SMS/UpdateStudent.jsp">Update Student</a></li>
                    </ul>
                </div>
            </li>

        </ul>
    </div>
</div>
