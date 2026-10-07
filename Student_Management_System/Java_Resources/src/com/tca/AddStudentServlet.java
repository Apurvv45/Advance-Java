
package com.tca.student;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addstudent")
public class AddStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        // Collecting input from form
        String rnoValue = request.getParameter("r");
        String name = request.getParameter("n");
        String perValue = request.getParameter("p");

        String msg = "";
        String msgType = "";

        Connection con = null;
        PreparedStatement ps = null;

        try {

            // Validate empty values
            if (rnoValue == null || rnoValue.trim().isEmpty()
                    || name == null || name.trim().isEmpty()
                    || perValue == null || perValue.trim().isEmpty()) {

                throw new Exception("Please fill all the fields.");
            }

            // Convert input values
            int rno = Integer.parseInt(rnoValue);
            double per = Double.parseDouble(perValue);

            // Validate percentage
            if (per < 0 || per > 100) {

                throw new Exception(
                    "Percentage must be between 0 and 100."
                );
            }

            // Database configuration
            final String DB_URL =
                    "jdbc:postgresql://localhost/ajb22";

            final String DB_USER = "root";
            final String DB_PWD = "root@123";
            final String DB_DRIVER = "org.postgresql.Driver";

            // Load PostgreSQL driver
            Class.forName(DB_DRIVER);

            // Create connection
            con = DriverManager.getConnection(
                    DB_URL,
                    DB_USER,
                    DB_PWD
            );

            // Insert student
            String sql =
                    "INSERT INTO student (rno, name, per) VALUES (?, ?, ?)";

            ps = con.prepareStatement(sql);

            ps.setInt(1, rno);
            ps.setString(2, name);
            ps.setDouble(3, per);

            ps.executeUpdate();

            // Success message
            msg = "Student registered successfully!";
            msgType = "success";

        }
        catch (NumberFormatException e) {

            msg = "Please enter a valid Roll Number and Percentage.";
            msgType = "danger";

        }
        catch (SQLException e) {

            // Duplicate Roll Number
            if (e.getMessage().contains("duplicate")
                    || e.getMessage().contains("unique")) {

                msg = "Roll Number " + rnoValue
                        + " already exists. Please use a different Roll Number.";

            } else {

                msg = "Unable to save student information. "
                        + "Please try again.";

            }

            msgType = "danger";

            e.printStackTrace();

        }
        catch (Exception e) {

            msg = e.getMessage();
            msgType = "danger";

        }
        finally {

            try {

                if (ps != null) {
                    ps.close();
                }

                if (con != null) {
                    con.close();
                }

            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Send message to JSP
        request.setAttribute("m", msg);
        request.setAttribute("msgType", msgType);

        RequestDispatcher rd =
                request.getRequestDispatcher("./AddStudent.jsp");

        rd.forward(request, response);
    }
}

