<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Database se count nikalne ke liye
    int totalStudents = 0;
    double avgAttendance = 0.0;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/attendance_db", "root", "root");
        
        // Query 1: Total Students count karne ke liye
        java.sql.ResultSet rs1 = con.prepareStatement("SELECT COUNT(*) FROM students").executeQuery();
        if(rs1.next()) { totalStudents = rs1.getInt(1); }
        
        // Query 2: Average Attendance % nikalne ke liye
        java.sql.ResultSet rs2 = con.prepareStatement("SELECT (COUNT(CASE WHEN status='Present' THEN 1 END) * 100.0 / COUNT(*)) FROM attendance").executeQuery();
        if(rs2.next()) { avgAttendance = rs2.getDouble(1); }
        
        con.close();
    } catch(Exception e) { e.printStackTrace(); }
%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String user = (String) session.getAttribute("username");
    if(user == null){
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DashBoard | Attendance System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; }
        
        body { background-color: #000000; display: flex; height: 100vh; overflow: hidden; color: white; }

        /* --- SIDEBAR STYLE --- */
        .sidebar {
            width: 280px;
            background-color: #000000;
            color: #fff;
            display: flex;
            flex-direction: column;
            border-right: 1px solid #333;
        }

        .sidebar-header {
            padding: 45px 20px;
            text-align: center;
            background: #E50914; /* Netflix Red */
        }

        .sidebar-header i { font-size: 55px; margin-bottom: 10px; }
        .sidebar-header h3 { font-size: 20px; letter-spacing: 2px; text-transform: uppercase; font-weight: 900; }

        .nav-menu { flex-grow: 1; margin-top: 30px; }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 18px 25px;
            color: #b3b3b3;
            text-decoration: none;
            transition: 0.4s;
            border-left: 4px solid transparent;
            font-size: 15px;
            font-weight: 600;
        }

        .nav-item i { width: 35px; font-size: 20px; }

        .nav-item:hover, .nav-item.active {
            background-color: #141414;
            color: #fff;
            border-left: 4px solid #E50914;
        }

        .logout-btn-container {
            padding: 25px;
            background-color: #000;
            border-top: 1px solid #333;
        }

        .logout-link {
            color: #b3b3b3;
            text-decoration: none;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            transition: 0.3s;
        }
        .logout-link:hover { color: #E50914; }

        /* --- MAIN CONTENT STYLE --- */
        .main-content { 
            flex-grow: 1; 
            overflow-y: auto; 
            padding: 50px; 
            background-color: #000000; 
        }

        .top-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding-bottom: 25px;
            border-bottom: 1px solid #333;
        }

        .top-header h1 { font-size: 38px; color: white; font-weight: 800; }
        .top-header span { color: #E50914; }
        .date-time { color: #b3b3b3; font-size: 16px; }

        .welcome-banner {
            background: #141414;
            border-left: 6px solid #E50914;
            padding: 35px;
            border-radius: 4px;
            margin-bottom: 50px;
        }

        .welcome-banner h2 { font-size: 26px; color: #fff; margin-bottom: 8px; }
        .welcome-banner p { color: #b3b3b3; font-size: 16px; }

        /* --- STATS CARDS --- */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 35px;
        }

        .stat-card {
            background: #181818; /* Dark grey card like Netflix row */
            padding: 35px;
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 4px solid #333;
            transition: all 0.4s ease;
            cursor: default;
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            border-bottom: 4px solid #E50914;
            background: #222;
        }

        .stat-info h2 { font-size: 52px; color: white; margin-bottom: 5px; font-weight: 900; }
        .stat-info p { color: #E50914; font-weight: 700; text-transform: uppercase; font-size: 14px; letter-spacing: 1.5px; }

        .stat-icon {
            width: 75px;
            height: 75px;
            background-color: rgba(229, 9, 20, 0.15);
            color: #E50914;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 32px;
        }

    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-id-badge"></i>
            <h3>Admin Panel</h3>
        </div>
        
        <nav class="nav-menu">
            <a href="Dashboard.jsp" class="nav-item active">
                <i class="fas fa-home"></i> DashBoard
            </a>
            <a href="addStudent.html" class="nav-item">
                <i class="fas fa-user-plus"></i> Add Student
            </a>
            <a href="ManageStudentsServlet" class="nav-item">
                <i class="fas fa-users-cog"></i> Manage Students
            </a>
            <a href="markAttendance.jsp" class="nav-item">
                <i class="fas fa-calendar-check"></i> Mark Attendance
            </a>
            <a href="ViewAttendanceServlet" class="nav-item">
                <i class="fas fa-file-invoice"></i> View Records
            </a>
        </nav>

        <div class="logout-btn-container">
            <a href="LogoutServlet" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-header">
            <h1>Welcome, <span><%= user %></span></h1>
            <div class="date-time" id="currentDate"></div>
        </div>

        <div class="welcome-banner">
            <h2>Student Attendance System</h2>
        </div>

        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-info">
                    <h2><%= totalStudents %></h2>
                    <p>Total Students</p>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h2><%= String.format("%.1f", avgAttendance) %>%</h2>
                    <p>Attendance Rate</p>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
            </div>
        </div>
    </div>

    <script>
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        document.getElementById('currentDate').innerHTML = new Date().toLocaleDateString(undefined, options);
    </script>

</body>
</html>