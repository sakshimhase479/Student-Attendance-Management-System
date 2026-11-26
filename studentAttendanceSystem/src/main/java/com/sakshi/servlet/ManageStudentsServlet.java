package com.sakshi.servlet;

import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ManageStudentsServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> studentList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/attendance_db", "root", "root");
            ResultSet rs = con.prepareStatement("SELECT * FROM students").executeQuery();

            while(rs.next()) {
                Map<String, String> student = new HashMap<>();
                student.put("id", rs.getString("id"));
                student.put("name", rs.getString("name"));
                student.put("course", rs.getString("course"));
                studentList.add(student);
            }
            request.setAttribute("studentList", studentList);
            request.getRequestDispatcher("manageStudents.jsp").forward(request, response);
            con.close();
        } catch (Exception e) { 
        	e.printStackTrace(); 
        	}
    }
}