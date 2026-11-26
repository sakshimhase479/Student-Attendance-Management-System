<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Students</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body { 
            font-family: 'Segoe UI', Arial, sans-serif; 
            background-color: #000000; /* Pure Black Background */
            color: white; 
            text-align: center; 
            margin: 0;
            padding: 20px;
        }

        h2 { 
            color: #E50914; /* Netflix Red */
            font-size: 32px;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        /* Table Styling */
        table { 
            width: 90%; 
            margin: 20px auto; 
            border-collapse: collapse; 
            background: #141414; /* Dark Grey/Black background for table */
            color: white; 
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(229, 9, 20, 0.2); /* Red subtle glow */
        }

        th, td { 
            padding: 15px; 
            border: 1px solid #333; /* Dark borders */
            text-align: center;
        }

        th { 
            background: #E50914; /* Netflix Red for Header */
            color: white; 
            font-weight: bold;
            text-transform: uppercase;
        }

        tr:hover {
            background-color: #222; /* Hover effect for rows */
        }

        /* Buttons Styling */
        .btn { 
            padding: 8px 15px; 
            text-decoration: none; 
            border-radius: 4px; 
            color: white; 
            font-weight: bold; 
            font-size: 13px;
            transition: 0.3s;
            display: inline-block;
        }

        .edit { 
            background: #333; 
            border: 1px solid #E50914;
        }
        .edit:hover { 
            background: #E50914; 
        }

        .delete { 
            background: #E50914; 
        }
        .delete:hover { 
            background: #b20710; 
            transform: scale(1.05);
        }

        /* Back Button */
        .back-link {
            display: inline-block;
            margin-top: 30px;
            color: #b3b3b3;
            text-decoration: none;
            font-size: 14px;
            transition: 0.3s;
        }
        .back-link:hover {
            color: #E50914;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h2><i class="fas fa-users-cog"></i> Student Records</h2>
    
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Course</th>
            <th>Actions</th>
        </tr>
        <%
        @SuppressWarnings("unchecked")
            List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("studentList");
            if(list != null) {
                for(Map<String, String> s : list) {
        %>
        <tr>
            <td><%= s.get("id") %></td>
            <td><%= s.get("name") %></td>
            <td><%= s.get("course") %></td>
            <td>
                <a href="EditStudentServlet?id=<%= s.get("id") %>" class="btn edit">EDIT</a>
                <a href="DeleteStudentServlet?id=<%= s.get("id") %>" class="btn delete" onclick="return confirm('Are you sure you want to delete this record?')">DELETE</a>
            </td>
        </tr>
        <% } } else { %>
            <tr>
                <td colspan="4" style="color: #b3b3b3; padding: 20px;">No records found.</td>
            </tr>
        <% } %>
    </table>

    <a href="Dashboard.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to DashBoard
    </a>

</body>
</html>