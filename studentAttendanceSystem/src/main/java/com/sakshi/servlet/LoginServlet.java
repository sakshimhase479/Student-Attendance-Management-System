package com.sakshi.servlet;

import java.io.*;
import java.sql.*;
import com.sakshi.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
public class LoginServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			Connection con = null;
			con = DBConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				System.out.println("Login successful");
				response.sendRedirect(request.getContextPath() + "/Dashboard.jsp");
			} else {
				response.sendRedirect("login.html?error=1");
				System.out.println("Login failed");
			}
			rs.close();
			ps.close();
			con.close();
		}catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error:" + e.getMessage());
		}
	}
}