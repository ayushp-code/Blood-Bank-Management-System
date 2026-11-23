<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head><title>Blood Bank - Login</title></head>
<body style="font-family:Arial; text-align:center; margin-top:80px;">
    <h2>Blood Bank Management System</h2>
    <h3>Admin Login</h3>
    <form action="LoginServlet" method="post">
        Username: <input type="text" name="username" required><br><br>
        Password: <input type="password" name="password" required><br><br>
        <input type="submit" value="Login">
    </form>
    <p style="color:red;">
        <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
    </p>
</body>
</html>