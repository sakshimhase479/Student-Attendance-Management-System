package com.sakshi.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/attendance_db", "root", "root");

            PreparedStatement ps1 = con.prepareStatement("DELETE FROM attendance WHERE student_id=?");
            ps1.setString(1, id);
            ps1.executeUpdate();
            
            PreparedStatement ps2 = con.prepareStatement("DELETE FROM students WHERE id=?");
            ps2.setString(1, id);
            int status = ps2.executeUpdate();

            if(status > 0) {
                out.println("<script>alert('Student Deleted Successfully!'); location='ManageStudentsServlet';</script>");
            } else {
                out.println("<script>alert('Error: Could not delete student.'); location='ManageStudentsServlet';</script>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
}