<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.sakshi.servlet.AttendanceRecord" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Records</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #000; color: white; padding: 40px; }
        .view-container { width: 95%; max-width: 1100px; margin: 0 auto; }
        
        .back-btn { color: #b3b3b3; text-decoration: none; font-size: 14px; display: inline-block; margin-bottom: 20px; transition: 0.3s; }
        .back-btn:hover { color: #E50914; }

        h2 { color: #E50914; font-size: 32px; margin-bottom: 20px; text-transform: uppercase; }

        .search-wrapper { margin-bottom: 30px; position: relative; width: 400px; }
        .search-wrapper input {
            width: 100%; padding: 12px 15px 12px 40px;
            background: #141414; border: 1px solid #333;
            color: white; border-radius: 4px; outline: none; transition: 0.3s;
        }
        .search-wrapper input:focus { border-color: #E50914; box-shadow: 0 0 10px rgba(229, 9, 20, 0.3); }
        .search-wrapper i { position: absolute; left: 15px; top: 15px; color: #b3b3b3; }

        /* Table Styling */
        table { width: 100%; border-collapse: collapse; background: #141414; border-radius: 8px; overflow: hidden; }
        th { background: #E50914; color: white; padding: 15px; text-align: left; text-transform: uppercase; font-size: 14px; }
        td { padding: 15px; border-bottom: 1px solid #222; color: #fff; }
        tr:hover { background: #222; }
        
        .status-present { color: #2ecc71; font-weight: bold; background: rgba(46, 204, 113, 0.1); padding: 4px 10px; border-radius: 4px; }
        .status-absent { color: #E50914; font-weight: bold; background: rgba(229, 9, 20, 0.1); padding: 4px 10px; border-radius: 4px; }
    </style>
</head>
<body>

<div class="view-container">
    <a href="Dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    <h2>Attendance Records</h2>

    <div class="search-wrapper">
        <i class="fas fa-search"></i>
        <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search by Student Name...">
    </div>

    <table id="attendanceTable"> <thead>
            <tr>
                <th>ID</th>
                <th>Student Name</th>
                <th>Date</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                @SuppressWarnings("unchecked")
                List<AttendanceRecord> list = (List<AttendanceRecord>) request.getAttribute("dataList");
                if(list != null && !list.isEmpty()) {
                    for(AttendanceRecord record : list) {
                        String statusClass = record.getStatus().equalsIgnoreCase("Present") ? "status-present" : "status-absent";
            %>
                <tr>
                    <td><%= record.getId() %></td>
                    <td class="student-name"><%= record.getName() %></td>
                    <td><%= record.getDate() %></td>
                    <td><span class="<%= statusClass %>"><%= record.getStatus() %></span></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="4" style="text-align:center; padding: 30px; color: #b3b3b3;">No attendance records found.</td></tr>
            <% } %>
        </tbody>
    </table>
</div>

<script>
function filterTable() {
    var input = document.getElementById("searchInput");
    var filter = input.value.toUpperCase();
    var table = document.getElementById("attendanceTable");
    var tr = table.getElementsByTagName("tr");

    for (var i = 1; i < tr.length; i++) {
        var td = tr[i].getElementsByClassName("student-name")[0];
        if (td) {
            var txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}
</script>

</body>
</html>