<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.sakshi.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance </title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        .mark-container {
            width: 90%;
            max-width: 800px;
            margin: 40px auto;
            color: white;
            background: #141414;
            padding: 30px;
            border-radius: 8px;
            border-top: 4px solid #E50914;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #1f1f1f;
        }

        th {
            background: #333;
            color: #E50914;
            padding: 15px;
            text-align: left;
            text-transform: uppercase;
            font-size: 14px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #333;
            color: #fff;
        }

        tr:hover {
            background: #252525;
        }

        /* Radio Button Styling */
        .radio-group {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .radio-group input[type="radio"] {
            accent-color: #E50914; /* Netflix Red color for radio circle */
            cursor: pointer;
        }

        .submit-section {
            margin-top: 30px;
            text-align: center;
        }

        .back-link {
            color: #b3b3b3;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .back-link:hover { color: #fff; }
    </style>
</head>
<body style="background-color: #000;">

<div class="mark-container">
    <a href="Dashboard.jsp" class="back-link">← Back to DashBoard</a>
    
    <h2 style="color: #E50914;">Mark Student Attendance</h2>
    <p style="color: #b3b3b3; font-size: 14px;">Select 'Present' or 'Absent' for each student and click submit.</p>

    <form action="AttendanceServlet" method="post">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Student Name</th>
                    <th>Mark Status</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Connection con = DBConnection.getConnection();
                    Statement st = con.createStatement();
                    // Hume sirf active students dikhane hain
                    ResultSet rs = st.executeQuery("SELECT * FROM students");

                    while(rs.next()) {
                        int id = rs.getInt("id");
            %>
                <tr>
                    <td><%= id %></td>
                    <td style="font-weight: 500;"><%= rs.getString("name") %></td>
                    <td>
                        <div class="radio-group">
                            <label><input type="radio" name="status_<%= id %>" value="Present" required> Present</label>
                            <label><input type="radio" name="status_<%= id %>" value="Absent"> Absent</label>
                        </div>
                    </td>
                </tr>
            <%
                    }
                    con.close();
                } catch(Exception e) {
                    out.println("<tr><td colspan='3' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>

        <div class="submit-section">
            <input type="submit" value="SUBMIT ATTENDANCE" class="btn-login">
        </div>
    </form>
</div>

</body>
</html>