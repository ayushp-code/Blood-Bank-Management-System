<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.bb.DBConnection"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String search = request.getParameter("group");
%>
<html>
<head>
    <title>Blood Bank - Dashboard</title>
    <style>
        body { font-family: Arial; margin: 30px; }
        table { border-collapse: collapse; width: 100%; margin-top: 15px; }
        th, td { border: 1px solid #333; padding: 8px; text-align: center; }
        th { background: #c0392b; color: white; }
    </style>
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("admin") %> |
        <a href="LogoutServlet">Logout</a></h2>

    <h3>Add Donor</h3>
    <form action="AddDonorServlet" method="post">
        Name: <input type="text" name="name" required>
        Age: <input type="number" name="age" min="18" max="65" required>
        Blood Group:
        <select name="blood_group">
            <option>A+</option><option>A-</option>
            <option>B+</option><option>B-</option>
            <option>AB+</option><option>AB-</option>
            <option>O+</option><option>O-</option>
        </select>
        Phone: <input type="text" name="phone" required>
        City: <input type="text" name="city" required>
        <input type="submit" value="Add Donor">
    </form>

    <h3>Search by Blood Group</h3>
    <form action="dashboard.jsp" method="get">
        <select name="group">
            <option value="">All</option>
            <option>A+</option><option>A-</option>
            <option>B+</option><option>B-</option>
            <option>AB+</option><option>AB-</option>
            <option>O+</option><option>O-</option>
        </select>
        <input type="submit" value="Search">
    </form>

    <h3>Donor List</h3>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Age</th>
            <th>Blood Group</th><th>Phone</th><th>City</th><th>Action</th>
        </tr>
        <%
            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps;
                if (search != null && !search.equals("")) {
                    ps = con.prepareStatement("SELECT * FROM donor WHERE blood_group=?");
                    ps.setString(1, search);
                } else {
                    ps = con.prepareStatement("SELECT * FROM donor");
                }
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getInt("age") %></td>
            <td><%= rs.getString("blood_group") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("city") %></td>
            <td><a href="DeleteDonorServlet?id=<%= rs.getInt("id") %>"
                   onclick="return confirm('Delete this donor?')">Delete</a></td>
        </tr>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
</body>
</html>