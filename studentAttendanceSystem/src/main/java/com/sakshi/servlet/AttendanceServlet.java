package com.sakshi.servlet;

import java.io.*;
import java.sql.*;
import java.util.*;
import com.sakshi.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AttendanceServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Connection con = DBConnection.getConnection();

            Enumeration<String> paramNames = request.getParameterNames();

            while(paramNames.hasMoreElements()) {
                String param = paramNames.nextElement();

                if(param.startsWith("status_")) {

                    int studentId = Integer.parseInt(param.split("_")[1]);
                    String status = request.getParameter(param);

                    PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO attendance(student_id, date, status) VALUES (?, CURDATE(), ?)"
                    );

                    ps.setInt(1, studentId);
                    ps.setString(2, status);

                    ps.executeUpdate();
                }
            }

         PrintWriter out = response.getWriter();
         out.println("<script type=\"text/javascript\">");
         out.println("alert('Attendance Mark Successfully!');");
         out.println("location='markAttendance.jsp';");
         out.println("</script>");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}