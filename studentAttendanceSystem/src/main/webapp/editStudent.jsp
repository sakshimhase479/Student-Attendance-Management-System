<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="background:#000000; color: #E50914; font-family:Arial; text-align:center;">
    <h2>Update Student Details</h2>
    <form action="UpdateStudentServlet" method="post" style="background: #E50914; color:black; padding:30px; display:inline-block; border-radius:10px; box-shadow: 0px 0px 10px rgba(0,0,0,0.5);">
        <input type="hidden" name="id" value="${id}">
        <b>Name:</b><br>
        <input type="text" name="name" value="${name}" style="padding:8px; width:250px;"><br><br>
        <b>Course:</b><br>
        <input type="text" name="course" value="${course}" style="padding:8px; width:250px;"><br><br>
        <input type="submit" value="Update Record" style="background: #000000; color: #E50914; border:none; padding:10px 20px; cursor:pointer; font-weight:bold;">
    </form>
</body>
</html>