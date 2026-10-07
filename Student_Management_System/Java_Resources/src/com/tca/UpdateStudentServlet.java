
package com.tca.student;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tca.student.entity.Student;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updatestudent")
public class UpdateStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        // Database configuration
        final String DB_URL = "jdbc:postgresql://localhost/ajb22";
        final String DB_USER = "root";
        final String DB_PWD = "root@123";
        final String DB_DRIVER = "org.postgresql.Driver";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<Student> Slist = new ArrayList<>();

        String qry = "SELECT * FROM student ORDER BY rno";

        String sbtn = request.getParameter("sbtn");

        try {

            Class.forName(DB_DRIVER);

            con = DriverManager.getConnection(
                    DB_URL,
                    DB_USER,
                    DB_PWD
            );

            // Search
            if (sbtn != null && sbtn.equals("Search")) {

                String rno = request.getParameter("rno");

                if (rno != null && !rno.trim().isEmpty()) {

                    qry = "SELECT * FROM student WHERE rno = ?";

                    ps = con.prepareStatement(qry);

                    ps.setInt(1, Integer.parseInt(rno));

                } else {

                    qry = "SELECT * FROM student ORDER BY rno";

                    ps = con.prepareStatement(qry);
                }

            }

            // Refresh
            else {

                qry = "SELECT * FROM student ORDER BY rno";

                ps = con.prepareStatement(qry);
            }

            rs = ps.executeQuery();

            // Store database records in Student objects
            while (rs.next()) {

                int rno = rs.getInt("rno");

                String name = rs.getString("name");

                double per = rs.getDouble("per");

                Slist.add(
                    new Student(rno, name, per)
                );
            }

        }
        catch (Exception e) {

            e.printStackTrace();

        }
        finally {

            try {
                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Send list to JSP
        request.setAttribute("Student", Slist);

        RequestDispatcher rd =
                request.getRequestDispatcher("./UpdateStudent.jsp");

        rd.forward(request, response);
    }
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");

        PrintWriter out = response.getWriter();

        final String DB_URL = "jdbc:postgresql://localhost/ajb22";
        final String DB_USER = "root";
        final String DB_PWD = "root@123";
        final String DB_DRIVER = "org.postgresql.Driver";

        Connection con = null;
        PreparedStatement ps = null;

        String trno = request.getParameter("rollnum");
        String tname = request.getParameter("sname");
        String tper = request.getParameter("sper");

        String qry = "UPDATE student SET name = ?, per = ? WHERE rno = ?";

        try {

            Class.forName(DB_DRIVER);

            con = DriverManager.getConnection(
                    DB_URL,
                    DB_USER,
                    DB_PWD
            );

            ps = con.prepareStatement(qry);

            ps.setString(1, tname);
            ps.setDouble(2, Double.parseDouble(tper));
            ps.setInt(3, Integer.parseInt(trno));

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("Success");
            } else {
                out.println("Failure");
            }

        } catch (Exception e) {

            e.printStackTrace();
            out.println("Failure");

        } finally {

            try {
                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
