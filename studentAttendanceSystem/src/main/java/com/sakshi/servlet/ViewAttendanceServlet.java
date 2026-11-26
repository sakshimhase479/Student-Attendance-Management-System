package com.sakshi.servlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ViewAttendanceServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<AttendanceRecord> attendanceList = new ArrayList<>();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/attendance_db", "root", "root");
            
            String query = "SELECT a.id as attendance_id, s.id as student_id, s.name, a.date, a.status " +
                    "FROM attendance a " +
                    "JOIN students s ON a.student_id = s.id " +
                    "ORDER BY a.date DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                AttendanceRecord record = new AttendanceRecord();
                record.setId(rs.getInt("student_id"));
                record.setName(rs.getString("name"));
                record.setDate(rs.getString("date"));
                record.setStatus(rs.getString("status"));
                attendanceList.add(record);
            }
            con.close();
            

            request.setAttribute("dataList", attendanceList);
            request.getRequestDispatcher("viewAttendance.jsp").forward(request, response);
            
        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().print("Error: " + e.getMessage());
        }
    }
}