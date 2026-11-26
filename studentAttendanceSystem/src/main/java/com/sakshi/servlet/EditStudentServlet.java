package com.sakshi.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EditStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/attendance_db", "root", "root");
            
            PreparedStatement ps = con.prepareStatement("SELECT * FROM students WHERE id=?");
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()) {
                request.setAttribute("id", rs.getString("id"));
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("course", rs.getString("course"));
                request.getRequestDispatcher("editStudent.jsp").forward(request, response);
            }
            con.close();
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
    }
}