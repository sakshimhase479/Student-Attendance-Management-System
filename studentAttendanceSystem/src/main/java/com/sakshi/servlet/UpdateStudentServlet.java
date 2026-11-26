package com.sakshi.servlet;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class UpdateStudentServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String course = request.getParameter("course");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/attendance_db", "root", "root");

            String sql = "UPDATE students SET name=?, course=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, course);
            ps.setString(3, id);

            int status = ps.executeUpdate();

            if(status > 0) {
                response.getWriter().println("<script>alert('Student Updated Successfully!'); location='ManageStudentsServlet';</script>");
            } else {
                response.getWriter().println("<script>alert('Update Failed!'); location='ManageStudentsServlet';</script>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}