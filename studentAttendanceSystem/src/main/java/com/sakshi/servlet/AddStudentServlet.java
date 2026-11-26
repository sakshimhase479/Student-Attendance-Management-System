package com.sakshi.servlet;

import java.io.*;
import java.sql.*;
import com.sakshi.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddStudentServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String course = request.getParameter("course");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO students(name, course) VALUES (?, ?)"
            );

            ps.setString(1, name);
            ps.setString(2, course);

            ps.executeUpdate();

         PrintWriter out = response.getWriter();
         out.println("<script type=\"text/javascript\">");
         out.println("alert('Student Added Successfully!');");
         out.println("location='addStudent.html';"); 
         out.println("</script>");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}